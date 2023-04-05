

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgets/Bloc/data_cubit.dart';

Widget taskTitle(Map model , BuildContext context  ) =>
    Row(
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
                  '${model['time']}',
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
                '${model['name']}',
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
        ),SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: (){
              DataCubit.get(context).updateDatabase('archived', model['id']);

            },
            icon: Icon(Icons.archive)),
        SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: (){
              DataCubit.get(context).deleteFromDatabase( model['id']);

            },
            icon: Icon(Icons.delete)),
      ],
    );
