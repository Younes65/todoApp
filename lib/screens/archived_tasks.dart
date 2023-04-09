
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
              child: taskTitle(model: cubit.archivedTask[index], context: context , icon1: Icons.unarchive,icon2: Icons.done)
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