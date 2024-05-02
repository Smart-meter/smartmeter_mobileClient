import 'package:flutter/material.dart';
import 'package:smartmeter/Widgets/HomeScreen/Carousel/CarouselCard.dart';

import '../../../model/Message.dart';

class Carousel extends StatefulWidget {
  Carousel({Key? key, required this.messages, required this.deleteMessage})
      : super(key: key);

  List<Message> messages;

  Function(int index) deleteMessage;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<Color> colors = [Colors.teal, Colors.blue, Colors.pink];
  int position = 0;

  Widget myCircle(int p) {
    return Container(
      height: 6,
      width: 6,
      decoration: BoxDecoration(
          color: position == p ? colors[p] : Colors.grey.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(25))),
    );
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> l = [];
    for (int i = 0; i < widget.messages.length; i++) {
      l.add(myCircle(i));

      l.add(const SizedBox(
        width: 5,
      ));
    }

    return SizedBox(
      height: 275,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 225,
            child: PageView.builder(
              onPageChanged: (pageposition) {
                setState(() {
                  position = pageposition;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                if (index < widget.messages.length) {
                  return CarouselCard(
                    colors[index],
                    widget.messages[index],
                    deleteMessage: widget.deleteMessage,
                    index: index,
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: l.toList(),
          )
        ],
      ),
    );
  }
}
