import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/Widgets/Navigation/Camera/Camera.dart';
import 'package:smartmeter/helpers/MeterReadingHelper.dart';
import 'package:smartmeter/model/CallToActions.dart';

import '../../../helpers/SharedPrefHelper.dart';
import '../../../helpers/SnackBarHelper.dart';
import '../../../model/Message.dart';
import '../../ImageCropper/Cropper.dart';
import '../../Navigation/Navigation.dart';

class CarouselCard extends StatelessWidget {
  CarouselCard(this.containerColor, this.data,
      {super.key, required this.deleteMessage, required this.index});

  Color containerColor;
  Message data;
  Function(int index) deleteMessage;
  int index;

  void showMultiDialog(BuildContext context) {
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
              bool result = await MeterReadingHelper.invalidateImage();

              if (result) {
                // move to camera route
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Camera()),
                );
              } else {
                SnackBarHelper.showMessage(
                    "Image invalidation Failed..", context);
              }
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
  }

  void confirmationDialog(BuildContext context) {
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
              Navigator.pop(context);
              showMultiDialog(context);
            },
          ),
          BasicDialogAction(
            title: const Text("Confirm"),
            onPressed: () async {
              // send api call for confirmation
              bool val = await MeterReadingHelper.confirmationCall();

              if (val) {
                // remove that message from messages
                deleteMessage(index);
                Navigator.pop(context);
              } else {
                SnackBarHelper.showMessage("confirmation Failed", context);
              }
            },
          )
        ],
      ),
    );
  }

  void billDueDialog(BuildContext context, SharedPreferences prefs) {
    String? billAmount = prefs.getString("billAmount");
    showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: const Text("Confirm Bill Payment"),
        content: Text(
            "Your Bill amount of ${billAmount} is due, please confirm to pay now, or cancel to pay later"),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("Cancel"),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          BasicDialogAction(
            title: const Text("Pay"),
            onPressed: () async {
              // send api call for confirmation
              bool val = await MeterReadingHelper.payBill();

              if (val) {
                // remove that message from messages
                deleteMessage(index);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Navigation()),
                );
              } else {
                SnackBarHelper.showMessage("Bill Payment Failed", context);
              }
            },
          )
        ],
      ),
    );
  }

  void takeAction(BuildContext context) async {
    // route to appropriate endpoints based on actions.

    SharedPreferences prefs = await SharedPrefsHelper.getPrefs();

    switch (data.action) {
      case CallToActions.CONFIRM_AUTOMATED_METER_READING:
        // show a popup and ask for confirmation.

        confirmationDialog(context);

        break;

      case CallToActions.BILL_AMOUNT_DUE:
        billDueDialog(context, prefs);

        break;
      case CallToActions.CAPTURE_IMAGE:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Camera()),
        );
        break;
      case CallToActions.MANUAL_METER_READING:
        showMultiDialog(context);
        break;

      default:
        break;
    }
  }

  void navigateCropper(BuildContext context) async {
    SharedPreferences prefs = await SharedPrefsHelper.getPrefs();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Cropper(imageUrl: prefs.getString("imageURL")!)),
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
          data.action == CallToActions.NO_ACTION
              ? const Text("")
              : Row(
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
