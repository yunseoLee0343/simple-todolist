import 'package:flutter/material.dart';

class StatefulApp extends StatefulWidget {
  const StatefulApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<StatefulApp> {
  List items = ["To do", "To schedule", "To delegate", "To delete"];
  List<Color> itemColors = [Color(0xffFF8181), Color(0xffFCE38A), Color(0xffEAFFD0), Color(0xff95E1D3)];
  List flexVals = [1,1,1,1];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: flexVals[0],
                child: TodoCard(title: "To do", color: itemColors[0], fontFamily: "Jalnan"),
              ),
              Expanded(
                flex: flexVals[1],
                child: TodoCard(title: "To do", color: itemColors[1], fontFamily: "Jalnan"),
              ),
              Expanded(
                flex: flexVals[2],
                child: TodoCard(title: "To do", color: itemColors[2], fontFamily: "Jalnan"),
              ),
              Expanded(
                flex: flexVals[3],
                child: TodoCard(title: "To do", color: itemColors[3], fontFamily: "Jalnan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}