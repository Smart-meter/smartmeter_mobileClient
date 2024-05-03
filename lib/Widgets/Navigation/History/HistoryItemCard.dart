import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/helpers/SharedPrefHelper.dart';

import '../../../model/HistoryModel.dart';

class HistoryItemCard extends StatefulWidget {
   HistoryItemCard({super.key, required this.data});

  HistoryModel data;

  @override
  State<StatefulWidget> createState() {
    return HistoryItemState();
  }
}

class HistoryItemState extends State<HistoryItemCard> {
  SharedPreferences? prefs;

  String? imageUrl = "https://picsum.photos/250?image=9";

  void viewImage(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: Text("Submission - ${widget.data.id}"),
        content: Container(
            margin: EdgeInsets.only(top: 4),
            child: Image.network(
              imageUrl!,
              fit: BoxFit.cover,
            )),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text("Close"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      imageUrl = widget.data.imageUrl;
    });
    return InkWell(
      onTap: () {
        viewImage(context);
      },
      child: SizedBox(
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
                    Row(
                      children: [
                        Icon(
                          Icons.numbers,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.data.id,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.data.date,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.electric_meter_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.data.readingValue,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.data.billValue,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.update,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.data.status,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
