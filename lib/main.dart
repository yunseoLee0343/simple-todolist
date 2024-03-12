import 'package:flutter/material.dart';

// 배경1: #FF8181
// 폰트1: #077522

// 배경2: #FCE38A
// 폰트2: #6677BB

// 배경3: #EAFFD0
// 폰트3: #BA55D3

// 배경4: #95E1D3
// 폰트4: #569889

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var isClicked = [1, 1, 1, 1];

  void setClicked(index) {
    setState(() {
      isClicked = [1, 1, 1, 1];
      isClicked[index] = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          TextRow(1, Colors.blue),
          TextRow(2, Colors.red),
          TextRow(3, Colors.green),
          TextRow(4, Colors.yellow),
        ]),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Expanded TextRow(index, color) {
    return Expanded(
      flex: isClicked[index - 1],
      child: GestureDetector(
        onTap: () => {setClicked(index - 1)},
        child: Container(
            color: color,
            child: const Row(children: [
              Column(
                children: [
                  Text('Text'),
                ],
              )
            ])),
      ),
    );
  }
}
