


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/helpers/SharedPrefHelper.dart';

import '../../../model/HistoryModel.dart';

class HistoryItemCard extends StatelessWidget{
  HistoryItemCard({super.key, required this.data});

  SharedPreferences? prefs;
  HistoryModel data;

  void asyncStuff() async{

    prefs = await SharedPrefsHelper.getPrefs();

  }


  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 96,
      child: Card(
        color: Color(0xff141414),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top part
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(Icons.numbers,color: Colors.white,),
                    SizedBox(width: 4,),
                    Text(data.id,style:TextStyle(color: Colors.white),)
                  ],),
                  Row(children: [
                    Icon(Icons.calendar_month,color: Colors.white,),
                    SizedBox(width: 4,),
                    Text(data.date,style:TextStyle(color: Colors.white),)
                  ],),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(Icons.electric_meter_rounded,color: Colors.white,),
                    SizedBox(width: 4,),
                    Text(data.readingValue,style:TextStyle(color: Colors.white),)
                  ],),
                  Row(children: [
                    Icon(Icons.attach_money,color: Colors.white,),
                    SizedBox(width: 4,),
                    Text(data.billValue,style:TextStyle(color: Colors.white),)
                  ],),
                  Row(children: [
                    Icon(Icons.update,color: Colors.white,),
                    SizedBox(width: 4,),
                    Text(data.status,style:TextStyle(color: Colors.white),)
                  ],),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }




}