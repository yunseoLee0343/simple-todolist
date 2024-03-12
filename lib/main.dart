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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isClicked = 2;

    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          TextWidget(value: isClicked),
        ]),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final int value;
  const TextWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: value,
      child: Row(children: [
        Column(
          children: [
            Text(value.toString()),
            Text('Text'),
          ],
        )
      ]),
    );
  }
}
