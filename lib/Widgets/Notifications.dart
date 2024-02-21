import 'package:card_slider/card_slider.dart';
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




  void dismiss(){
    print("hello");
    setState(() {
      // widget.messages.removeAt(index);
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
          transform: Matrix4.translationValues(0.0, -66.0, 0.0),
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: valuesDataColors[i],
          ),
          child: Column(
            children: [
              Text(
                widget.messages[i],
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){}, style: TextButton.styleFrom(foregroundColor: Colors.greenAccent),child: const Text("Take Action")),
                  TextButton(onPressed: (){
                    print("hello");
                  }, style: TextButton.styleFrom(foregroundColor: Colors.red), child: const Text("Dismiss",),)
                ],
              )
            ],
          )));
    }

    return CardSlider(
      cards: valuesWidget,
      bottomOffset: .0003,
      cardHeight: 0.25,
      itemDotOffset: -0.7,
    );
  }
}
