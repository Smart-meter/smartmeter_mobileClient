import 'package:card_slider/card_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  Notifications({super.key, required this.messages});

  List<String> messages;

  @override
  State<StatefulWidget> createState() {
    return _NotificationState();
  }
}

class _NotificationState extends State<Notifications> {
  void dismiss() {
    print("hello");
  }

  void removeNotification(int index) {
    if (kDebugMode) {
      print('removign data');
    }
    setState(() {
      widget.messages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> valuesDataColors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.yellow,
      Colors.red,
      Colors.grey,
    ];

    List<Widget> valuesWidget = [];
    for (int i = 0; i < widget.messages.length; i++) {
      valuesWidget.add(Container(
          //transform: Matrix4.translationValues(0.0, -66.0, 0.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: valuesDataColors[i],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(flex:1,child: Text(
                widget.messages[i],
                softWrap: true,
                maxLines: 2,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style:ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {
                      print("hello");
                    },
                    child: const Text('Enabled'),
                  ),
                  TextButton(
                      onPressed: () {
                        print("decline");
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.greenAccent,
                      fixedSize: Size.fromHeight(80)),
                      child: const Text("Take Action")),
                  TextButton(
                    onPressed: () {
                      print("dismiss");
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text(
                      "Dismiss",
                    ),
                  )
                ],
              )
            ],
          )));
    }

    return CardSlider(
      cards: valuesWidget,
      bottomOffset: .0005,
      cardHeight: 0.75,
      itemDotOffset: 0.25,
    );


  }
}
