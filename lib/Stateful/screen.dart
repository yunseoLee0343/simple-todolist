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
  // immutable
  static const List items = [
    "To do",
    "To schedule",
    "To delegate",
    "To delete"
  ];
  static const List subItems = [
    "Urgent, Important Things.",
    "Not Urgent, Important Things.",
    "Urgent, Not Important Things.",
    "Not Urgent, Not Important Things."
  ];
  static const List<Color> itemColors = [
    Color(0xffFF8181),
    Color(0xffFCE38A),
    Color(0xffEAFFD0),
    Color(0xff95E1D3)
  ];

  // for TodoCard's subTitle to disappear
  List copiedSubItems = [];

  // for TodoCard's reactive size
  List flexVals = [1, 1, 1, 1];

  void updateFlexValue(int index, int flexValue) {
    setState(() {
      for(int i=0; i<flexVals.length; i++) {
        if(i == index) flexVals[i] = flexValue;
        else flexVals[i] = 1;
      }
    });
  }

  void updateSubTitle(int index, bool flexed) {
    setState(() {
      for(int i=0; i<subItems.length; i++) {
        if(flexed && i != index) {
          copiedSubItems[i] = "";
        } else {
          copiedSubItems[i] = subItems[i];
        }
      }
    });
  }

  @override
  void initState() {
    copiedSubItems = List.from(subItems);
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