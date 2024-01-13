

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class History extends StatefulWidget{
  const History({super.key});


  @override
  State<StatefulWidget> createState() {
    return _HistoryState();
  }

}


class _HistoryState extends State<History>{

  File? selectedImage;
  void _pickImage() {
    ImagePicker().pickImage(source: ImageSource.camera).then((image){

      if(image!=null) {
        setState(() {
          String  path = image!.path;
          selectedImage = File(path)!;
        });
      }


    }).onError((error, stackTrace){
      print(error);
    });


  }

  @override
  Widget build(BuildContext context) {
     _pickImage();
   return selectedImage == null ? const Text("Select an image") : Image.file(selectedImage!);
  }

}