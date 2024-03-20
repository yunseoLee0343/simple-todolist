import 'package:dorun_2th_flutter_study/Stateful/route.dart';
import 'package:dorun_2th_flutter_study/Stateful/widgets.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

class StatefulApp extends StatefulWidget {
  const StatefulApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<StatefulApp> with AutomaticKeepAliveClientMixin {
  List items = ["To do", "To schedule", "To delegate", "To delete"];
  List subItems = [
    "Urget, Important Things.",
    "Not Urgent, Important Things.",
    "Urgent, Not Important Things.",
    "Not Urgent, Not Important THings."
  ];
  List copiedSubItems = [];

  List<Color> itemColors = [
    Color(0xffFF8181),
    Color(0xffFCE38A),
    Color(0xffEAFFD0),
    Color(0xff95E1D3)
  ];
  List flexVals = [1, 1, 1, 1];

  void updateFlexValue(int index, int flexValue) {
    setState(() {
      for(int i=0; i<flexVals.length; i++) {
        if(i == index) flexVals[i] = flexValue;
        else flexVals[i] = 1;
      }
    });
  }

  void updateSubTitle(int index) {
    setState(() {
      for(int i=0; i<subItems.length; i++) {
          if(i == index) copiedSubItems[i] = subItems[i];
          else copiedSubItems[i] = "";
      }
    });
  }

  void restoreSubTitle() {
    setState(() {
      for(int i=0; i<subItems.length; i++) {
        copiedSubItems[i] = subItems[i];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: List.generate(items.length, (index) {
              return Expanded(
                flex: flexVals[index],
                child: TodoCard(
                  title: items[index],
                  subTitle: copiedSubItems[index],
                  color: itemColors[index],
                  fontFamily: "Jalnan",
                  index: index,
                  flexVals: flexVals,
                  updateFlexValue: updateFlexValue,
                  updateSubTitle: updateSubTitle,
                  restoreSubTitle: restoreSubTitle,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Appbar"),
        ),
      ),
    );
  }
}
