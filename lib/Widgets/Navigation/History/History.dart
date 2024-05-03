import 'package:flutter/material.dart';
import 'package:smartmeter/helpers/HistoryHelpers.dart';

import '../../../model/HistoryModel.dart';
import 'HistoryItemCard.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<StatefulWidget> createState() {
    return HistoryState();
  }
}

class HistoryState extends State<History> {
  List<HistoryModel> data = [];

  void asyncStuff() async {
    List<HistoryModel> d = await HistoryHelper.fetchHistory();

    setState(() {
      data = d;
    });
  }

  @override
  void initState() {
    super.initState();
    asyncStuff();
    Future.delayed(Duration.zero).then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> w = [];

    // var d1 = HistoryModel("1", "date", "status", "imageUrl", "-", "-");
    //
    // data.add(d1);
    // data.add(d1);
    // data.add(d1);
    // data.add(d1);
    // data.add(d1);

    
    for (var d in data) {
      w.add(HistoryItemCard(data: d));
    }

   return w.isEmpty? Column(
     mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
     mainAxisSize: MainAxisSize.max,
      children: [
        Container(
        margin: EdgeInsets.all(8),
        child: const Text("History",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            )),


        ),
        const SizedBox(height: 280,),
        const Center(child: CircularProgressIndicator(),)
      ],
    )  : Column(

      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          child: const Text("History",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              )),
        ),
         Expanded(flex: 1,child: ListView(children: w,),)
      ],
    );
  }
}
