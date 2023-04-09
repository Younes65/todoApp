

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgets/Bloc/data_cubit.dart';

Widget taskTitle({
  @required Map? model,
  @required BuildContext? context ,
  IconData? icon1,
  IconData? icon2
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
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
                    '${model!['time']}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),

          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  '${model!['name']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${model['value']}',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: (){

                if(icon1 == Icons.archive){
                  DataCubit.get(context).updateDatabase('archived', model['id']);
                }
               else  DataCubit.get(context).updateDatabase('new', model['id']);

              },
              icon: Icon(icon1)),

          IconButton(
              onPressed: (){
                DataCubit.get(context).updateDatabase('done', model['id']);
              },
              icon: Icon(icon2)),
          IconButton(
              onPressed: (){
                DataCubit.get(context).deleteFromDatabase( model!['id']);
              },
              icon: Icon(Icons.delete)),

        ],
      ),
    );
