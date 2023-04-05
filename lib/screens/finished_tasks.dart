
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets/Bloc/data_cubit.dart';
import 'package:widgets/Bloc/data_states.dart';
import 'package:widgets/components/component.dart';

class NewTasks extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Tasks();
}

class _Tasks  extends State<NewTasks>{
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
                child: taskTitle(cubit.finishedTask[index] , context),
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
            itemCount: cubit.finishedTask.length);
      },
    );
  }
}