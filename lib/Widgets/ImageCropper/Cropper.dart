import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/model/BoundingBox.dart';

import '../../helpers/SharedPrefHelper.dart';
import '../../helpers/SnackBarHelper.dart';
import '../../helpers/image_upload_helper.dart';

class Cropper extends StatefulWidget {
  const Cropper({super.key});

  @override
  State<StatefulWidget> createState() {
    return CropperState();
  }
}

class CropperState extends State<Cropper> {
  late CropController controller;
  String imageUrl =
      "https://static.vecteezy.com/system/resources/previews/004/141/669/large_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg";

  final _valueController = TextEditingController();

  double top = 0;
  double left = 0;
  double right = 0;
  double bottom = 0;

  double trx = 0;
  double tr_y = 0;
  double tlx = 0;
  double tly = 0;

  double brx = 0;
  double bry = 0;
  double blx = 0;
  double bly = 0;

  void setValues(Rect rect) {
    setState(() {
      trx = rect.topRight.dx;
      tr_y = rect.topRight.dy;

      tlx = rect.topLeft.dx;
      tly = rect.topLeft.dy;

      brx = rect.bottomRight.dx;
      bry = rect.bottomRight.dy;

      blx = rect.bottomLeft.dx;
      bly = rect.bottomRight.dy;
    });

    // print("trx : ${trx}, try:${tr_y} ");
    // print("tlx ${tlx}, tly:${tly}");
    // print("brx ${brx}, bry : ${bry}");
    // print("blx ${blx}, bly: ${bly}");

    setState(() {
      top = rect.top;
      left = rect.left;
      right = rect.right;
      bottom = rect.bottom;
    });
  }

  void sendValues() async {
    // validate the value

    if (_valueController.text.isEmpty) {
      SnackBarHelper.showMessage("Please enter the reading", context);
      return;
    }

    //make an API call and send these values

    var box = BoundingBox(trx, tr_y, tlx, tly, brx, bry, blx, bly);

    print(box);

    bool result = await ImageUploadHelper.uploadCoordinates(box);

    if (result) {
      //go back to home
      SnackBarHelper.showMessage("Bounding Box submitted sucessfully", context);
    } else {
      //error message
      // widget.changePage(0);
      Navigator.pop(context);
      SnackBarHelper.showMessage("Bounding Box sumbission failed!", context);
    }
  }

  @override
  void initState() {
    controller = CropController(
      /// If not specified, [aspectRatio] will not be enforced.
      //aspectRatio: 1,

      /// Specify in percentages (1 means full width and height). Defaults to the full image.
      defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
    );

    asyncStuff();
    Future.delayed(Duration.zero).then((_) {});
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  void asyncStuff() async {
    SharedPreferences prefs = await SharedPrefsHelper.getPrefs();

    setState(() {
      imageUrl = prefs.getString("imageURL")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return controller != null
        ? Scaffold(
            appBar: AppBar(
              leading: const BackButton(
                color: Colors.white, // Change the color here
              ),
              title: const Text(
                'Bounding Box',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.black,
            body: Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 56),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.info,
                            color: Colors.white,
                          )),
                      Expanded(
                          child: Text(
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white54),
                              maxLines: 3,
                              "Try highlighting the portion of image where the meter reading is "
                              "clearly visible and provide the meter reading you see")),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CropImage(
                    controller: controller,
                    onCrop: (rect) => {setValues(rect)},
                    image: Image.network(imageUrl),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _valueController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.electric_meter),
                        labelText: 'Enter Current Meter Reading',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            controller.crop =
                                const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                          },
                          child: const Text("Reset")),
                      ElevatedButton(
                          onPressed: () {
                            sendValues();
                          },
                          child: const Text("Complete"))
                    ],
                  )
                ],
              ),
            ))
        : const Center(child: CircularProgressIndicator());
  }
}
