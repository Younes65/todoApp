
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:widgets/Bloc/data_cubit.dart';
import 'package:widgets/Bloc/data_states.dart';
import 'package:widgets/components/component.dart';

class ArchrivedTasks extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Tasks();
}

class _Tasks  extends State<ArchrivedTasks>{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataCubit, DataStates>(
      listener: (context , state){},
     builder: (context ,state){

       DataCubit cubit = DataCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                if(cubit.showIcon == false){
                  cubit.selectItem(true, index);
                }
                else cubit.selectItem(false, -1);
              },
              child: Container(
                color: cubit.selectedItem == index ? Colors.blueAccent : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 50.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage('assets/time.png'),
                                    fit: BoxFit.cover)),
                          ),
                          Text(
                            '${cubit.archivedTask[index]['time']}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            '${cubit.archivedTask[index]['name']}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${cubit.archivedTask[index]['value']}',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: (){
                          DataCubit.get(context).updateDatabase('new', cubit.archivedTask[index]['id']);

                        },
                        icon: Icon(Icons.unarchive)),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: (){
                          DataCubit.get(context).deleteFromDatabase( cubit.archivedTask[index]['id']);

                        },
                        icon: Icon(Icons.delete)),
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Divider(
                    height: 1,
                    color: Colors.black
                ),
              );
            },
            itemCount: cubit.archivedTask.length);
     },
    );
  }
}