import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

import '../../helpers/SnackBarHelper.dart';
import '../../helpers/image_upload_helper.dart';

class Cropper extends StatefulWidget {
  Cropper({super.key, required this.imageUrl});

  String imageUrl;

  @override
  State<StatefulWidget> createState() {
    return CropperState();
  }
}

class CropperState extends State<Cropper> {
  late CropController controller;

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

    showDialog(context);

  }

  void apiCall() async{
    if (_valueController.text.isEmpty) {
      SnackBarHelper.showMessage("Please enter the reading", context);
      return;
    }

    //make an API call and send these values

    //var box = BoundingBox(trx, tr_y, tlx, tly, brx, bry, blx, bly);



    bool result = await ImageUploadHelper.uploadCoordinates(_valueController.text.trim());

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
  }

  void showDialog(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: Text("Enter Meter Reading"),
        content: Material(
          child: SizedBox(
            height: 32,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _valueController,
            ),
          ),
        ),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("Submit"),
            onPressed: () async {
              apiCall();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller != null
        ? Scaffold(
            resizeToAvoidBottomInset: false,
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
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: const Icon(
                              Icons.info,
                              color: Colors.white,
                            )),
                        const Expanded(
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
                      height: 8,
                    ),
                    CropImage(
                        controller: controller,
                        onCrop: (rect) => {setValues(rect)},
                        image: Image.network(
                          widget.imageUrl,
                          height: 180,
                        )),
                    // TextField(
                    //   keyboardType: TextInputType.number,
                    //   controller: _valueController,
                    //   style: const TextStyle(color: Colors.white),
                    //   decoration: InputDecoration(
                    //       prefixIcon: const Icon(Icons.electric_meter),
                    //       labelText: 'Enter Current Meter Reading',
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(16))),
                    // ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Row(
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
