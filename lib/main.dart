import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:widgets/Bloc/data_states.dart';
import 'package:widgets/Bloc/data_cubit.dart';
import 'package:widgets/Bloc/observer.dart';
import 'package:widgets/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  Bloc.observer = MyBlocObserver();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()));
}

class MyApp extends StatelessWidget {
  TextEditingController taskController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DataCubit(),
      child: BlocConsumer<DataCubit, DataStates>(
        listener: (BuildContext context, DataStates state) {},
        builder: (BuildContext context, DataStates state) {
          DataCubit cubit = DataCubit.get(context);
          cubit.createDatabase();
          return Scaffold(
            backgroundColor: Colors.white,
            key: _formKey,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.blueAccent),
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                'ToDo List',
                style: TextStyle(fontSize: 30, color: Colors.blueAccent),
              ),
              actions: [
                if (cubit.showIcon)
                  IconButton(
                      onPressed: () {
                        cubit.updateDatabase(
                            'done', cubit.task[cubit.selectedItem]['id']);
                        cubit.selectItem(false, -1);
                      },
                      icon: Icon(Icons.done))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              onPressed: () {
                if (cubit.isChanged) {
                  if (formKey.currentState!.validate()) {
                    if (state is ChangeIcon) {
                      Navigator.pop(context);
                      cubit.change(false, Icons.edit);
                      cubit.insertData(taskController.text, timeController.text,
                          dateController.text);
                      timeController.text = '';
                      taskController.text = '';
                      dateController.text = '';
                    }
                  }
                } else {
                  _formKey.currentState!
                      .showBottomSheet(
                          backgroundColor: Colors.transparent,
                          elevation: 15,
                          (context) => Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 205, 205, 205),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                    )),
                                padding: EdgeInsets.all(20),
                                width: double.infinity,
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        textInputAction:
                                            TextInputAction.newline,
                                        maxLines: null,
                                        keyboardType: TextInputType.name,
                                        style: TextStyle(fontSize: 15),
                                        controller: taskController,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'add something ';
                                          }
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Tasks',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'add time ';
                                          }
                                        },
                                        enabled: true,
                                        controller: timeController,
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) =>
                                                  timeController.text = value!
                                                      .format(context)
                                                      .toString());
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            labelText: 'Time',
                                            prefixIcon:
                                                Icon(Icons.access_time)),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'add Date ';
                                          }
                                        },
                                        enabled: true,
                                        controller: dateController,
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.utc(2025))
                                              .then((value) =>
                                                  dateController.text =
                                                      DateFormat.yMMMd()
                                                          .format(value!));
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            labelText: 'Date',
                                            prefixIcon:
                                                Icon(Icons.calendar_month)),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                      .closed
                      .then((value) => {cubit.change(false, Icons.edit)});
                  cubit.change(true, Icons.add);
                }
              },
              child: Icon(cubit.fable),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Color.fromARGB(255, 41, 88, 169),
                  selectedItemColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.toggel(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu), label: 'Tasks'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.done), label: 'Finished Tasks'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive), label: 'Archived Tasks')
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: cubit.screens[cubit.currentIndex],
            ),
          );
        },
      ),
    );
  }
}
