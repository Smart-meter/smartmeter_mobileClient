import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:smartmeter/Widgets/Navigation/Camera/Camera.dart';
import 'package:smartmeter/helpers/MeterReadingHelper.dart';
import 'package:smartmeter/helpers/image_upload_helper.dart';
import 'package:smartmeter/model/CallToActions.dart';

import '../../../model/Message.dart';
import '../../ImageCropper/Cropper.dart';

class CarouselCard extends StatelessWidget {
  CarouselCard(this.containerColor, this.data, {super.key, required this.deleteMessage, required this.index});

  Color containerColor;
  Message data;
  Function(int index) deleteMessage;
  int index;

  void takeAction(BuildContext context) {
    // route to appropriate endpoints based on actions.

    switch (data.action) {

      case CallToActions.CONFIRM_AUTOMATED_METER_READING:
        // show a popup and ask for confirmation.

        showPlatformDialog(
          context: context,
          builder: (context) => BasicDialogAlert(
            title: const Text("Confirmation Required"),
            content: const Text(
                "your meter reading is processed, please confirm if its accurate or reject and raise a dispute if it is not."),
            actions: <Widget>[
              BasicDialogAction(
                title: Text("Dispute"),
                onPressed: () async {
                  //todo
                 Navigator.pop(context);
                },
              ),
              BasicDialogAction(
                title: const Text("Confirm"),
                onPressed: () async {

                  // remove that message from messages
                  deleteMessage(index);
                  // send api call for confirmation
                  bool val = await MeterReadingHelper.confirmationCall();

                  Navigator.pop(context);

                },
              )
            ],
          ),
        );

        break;
      case CallToActions.CAPTURE_IMAGE:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Camera()),
        );
        break;
      case CallToActions.MANUAL_METER_READING:
        // when prompted for manual meter reading,
        // give the user choice wether he would like to draw bounding box and manually enter the data
        // or just recapture the image.
        showPlatformDialog(
          context: context,
          builder: (context) => BasicDialogAlert(
            title: Text("Action Required"),
            content: Text(
                "your meter reading was not processed, choose one of the below options"),
            actions: <Widget>[
              BasicDialogAction(
                title: Text("Re capture Image"),
                onPressed: () async {
                  // Invalidate the previous image
                  await ImageUploadHelper.invalidateImage();
                  // move to camera route
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Camera()),
                  );
                },
              ),
              BasicDialogAction(
                title: Text("Manual Entry"),
                onPressed: () async {
                  navigateCropper(context);
                  // Navigator.pop(context);
                },
              ),
              BasicDialogAction(
                title: Text("Dismiss"),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );

      default:
        break;
    }
  }

  void navigateCropper(BuildContext context) {
    print("hello");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Cropper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Navigator.pop(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: containerColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data.message,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          data.action == CallToActions.NO_ACTION?const Text(""): Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    takeAction(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Take Action "),
                      Icon(Icons.arrow_right_alt_rounded)
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
