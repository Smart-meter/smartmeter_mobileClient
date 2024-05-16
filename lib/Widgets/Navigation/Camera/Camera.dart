import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/Widgets/HomeScreen/HomeScreen.dart';
import 'package:smartmeter/helpers/SharedPrefHelper.dart';
import 'package:smartmeter/helpers/SnackBarHelper.dart';
import 'package:smartmeter/helpers/image_upload_helper.dart';
import 'package:smartmeter/main.dart';

import '../Navigation.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CameraState();
  }



}

class _CameraState extends State<Camera> {
  File? selectedImage;

  bool isError = false;
  bool isLoading = false;

  void init() {
    /// make source : ImageSource.Camera => to access the camera.
    ImagePicker().pickImage(source: ImageSource.camera).then((value) {
      setState(() {
        selectedImage = File(value!.path);
      });
    }).onError((error, stackTrace) {
      setState(() {
        isError = true;
      });
    });
  }

  void reInit() {
    ImagePicker().pickImage(source: ImageSource.camera).then((value) {
      setState(() {
        selectedImage = File(value!.path);
      });
    }).onError((error, stackTrace) {
      setState(() {
        isError = true;
      });
    });
  }

  @override
  initState() {
    super.initState();
    init();
  }

  void deleteUserData() async {
    SharedPreferences preferences = await SharedPrefsHelper.getPrefs();
    preferences.remove("userDetails");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white, // Change the color here
          ),
          title: const Text(
            'Capture Meter Image',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: selectedImage != null
            ? Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.file(selectedImage!),
                  isLoading?const Center(
                    child: CircularProgressIndicator(),
                  ):const Text(""),
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
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kColorScheme.error),
                        child: const Text("Clear"),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            bool status = await ImageUploadHelper.uploadImage(
                                selectedImage!);

                            if (status) {
                              SnackBarHelper.showMessage(
                                  "Meter Image Uploaded Sucessfully", context);

                              deleteUserData();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Navigation()),
                              );
                            } else {
                              SnackBarHelper.showMessage(
                                  "Meter Image Upload Failed", context);
                            }

                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const Text("Upload!"))
                    ],
                  )
                ],
              )
            : isError
                ? Center(
                    child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 48),
                    child: ElevatedButton(
                        onPressed: () {
                          reInit();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline_sharp),
                            SizedBox(
                              width: 16,
                            ),
                            Text("Try Again")
                          ],
                        )),
                  ))
                : const Center(child: CircularProgressIndicator()));
  }
}
