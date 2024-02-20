import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartmeter/helpers/SnackBarHelper.dart';
import 'package:smartmeter/helpers/image_upload_helper.dart';
import 'package:smartmeter/main.dart';

import '../../TakePictureScreen.dart';

class Camera extends StatefulWidget {
   Camera({super.key, required this.changePage});


  void Function (int page) changePage;
  @override
  State<StatefulWidget> createState() {
    return _CameraState();
  }
}

class _CameraState extends State<Camera> {
  File? selectedImage;


  void init(){
    /// make source : ImageSource.Camera => to access the camera.
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        selectedImage = File(value!.path);
      });
    }).onError((error, stackTrace) {});
  }

  @override
  initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {

    return selectedImage == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Upload Image",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.w700)),
              Image.file(selectedImage!),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedImage = null;
                        init();
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: kColorScheme.error),
                    child: const Text("Clear"),
                  ),
                  ElevatedButton(onPressed: () async {
                   bool status = await ImageUploadHelper.uploadImage(selectedImage!);

                   if(status){
                     SnackBarHelper.showMessage("Meter Image Uploaded Sucessfully", context);

                     widget.changePage(0);
                   }else{
                     SnackBarHelper.showMessage("Meter Image Upload Failed", context);
                   }


                  }, child: const Text("Upload!"))
                ],
              )
            ],
          );

  }
}
