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
  bool call = false;

  void asyncStuff() async {
    List<HistoryModel> d = await HistoryHelper.fetchHistory();

    setState(() {
      data = d;
      call = true;
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
        call ? const Center(child: Text("No History Data Found", style: TextStyle(color: Colors.grey, fontSize: 24),)):const Center(child: CircularProgressIndicator(),)
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
