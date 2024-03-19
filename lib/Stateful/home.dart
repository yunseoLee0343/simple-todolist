import 'package:flutter/material.dart';

class StatefulApp extends StatefulWidget {
  const StatefulApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<StatefulApp> {
  List items = ["To do", "To schedule", "To delegate", "To delete"];
  List<Color> itemColors = [
    Color(0xffFF8181),
    Color(0xffFCE38A),
    Color(0xffEAFFD0),
    Color(0xff95E1D3)
  ];
  List flexVals = [1, 1, 1, 1];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: List.generate(items.length, (index) {
              return Expanded(
                flex: 1,
                child: TodoCard(
                  title: items[index],
                  color: itemColors[index],
                  fontFamily: "Jalnan",),
              );
            }),
          ),
        ),
      ),
    );
  }
}