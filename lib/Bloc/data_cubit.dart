import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:widgets/Bloc/data_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets/screens/archived_tasks.dart';
import 'package:widgets/screens/finished_tasks.dart';
import 'package:widgets/screens/tasks.dart';

class DataCubit extends Cubit<DataStates> {
  DataCubit() : super(DataInitialState());

  static DataCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [Tasks(), NewTasks(), ArchrivedTasks()];

  List<Map> task = [];
  List<Map> archivedTask = [];
  List<Map> finishedTask = [];

// function to toggles betweens screens
  void toggel(int index) {
    currentIndex = index;
    emit(ChangeBottomNavigationBar());
  }

  Database? database;

  createDatabase() async {
    database = await openDatabase('db todo', version: 1,
        onCreate: (database, version) {
      print('database is created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, name TEXT, time TEXT, value TEXT ,data TEXT) ')
          .then((value) {
        emit(CreateDatabase());
        print('table created');
      }).catchError((error) {
        print('Error is ${error.toString()}');
      });
    }, onOpen: (database) {
      emit(CreateDatabase());
      getDatabase(database);
      print('databae is opend');
    });
  }

// insert items to database
  insertData(String name, String time, String date) async {
    return await database?.transaction((txn) => txn
            .rawInsert(
                'INSERT INTO tasks(name , time ,value , data ) VALUES ("$name","$time","$date" , "new" )')
            .then((value) {
          emit(InsertDatabase());
          print('inserted $value');
          getDatabase(database!).then((value) {});
        }).catchError((error) {
          print('error is $error');
        }));
  }

// fun to get data from table and store it in lists
  Future getDatabase(Database database) async {
    task = [];
    archivedTask = [];
    finishedTask = [];
    await database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['data'] == 'archived') {
          archivedTask.add(element);
          emit(GetDatabase());
        } else if (element['data'] == 'done') {
          finishedTask.add(element);
          emit(GetDatabase());
        } else
          task.add(element);
        emit(GetDatabase());
      });
    });
    emit(GetDatabase());
  }

  bool isChanged = false;
  IconData fable = Icons.edit;
  void change(bool isShow, IconData icon) {
    isChanged = isShow;
    fable = icon;
    emit(ChangeIcon());
  }

// fun to select item
  bool showIcon = false;
  int selectedItem = -1;
  void selectItem(bool icon, index) {
    showIcon = icon;
    selectedItem = index;
    emit(SelectedItem());
  }

// delete items from database
  void deleteFromDatabase(int n) async {
    await database!.rawDelete('DElETE FROM tasks WHERE id = ?', [n]);
    getDatabase(database!);
    emit(DeleteFromDatabase());
  }

// update items
  void updateDatabase(String status, int n) async {
    await database!.rawUpdate(
        'UPDATE tasks SET data = ? WHERE id = ?', ['$status', n]).then((value) {
      getDatabase(database!);

      emit(UpdateDatabase());
    }).catchError((e) {
      print(e);
    });
  }
}
