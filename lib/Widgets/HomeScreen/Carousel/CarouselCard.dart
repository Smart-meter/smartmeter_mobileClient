

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ImageCropper/Cropper.dart';

class CarouselCard extends StatelessWidget {
  CarouselCard(this.containerColor, this.data, {super.key});

  Color containerColor;
  String data;

  void takeAction(BuildContext context){


    // route to appropriate endpoints based on actions.


   
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: containerColor,

            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(data,style: const TextStyle(color: Colors.white, fontSize: 16),),
            Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: (){
                takeAction(context);
              }, child:const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text("Take Action "),
                Icon(Icons.arrow_right_alt_rounded)
              ],))
            ],)
          ],
        ),
    );
  }
}
