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
  var isClicked = [1,1,1,1];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          TextWidget(index: 0, value: isClicked),
          TextWidget(index: 1, value: isClicked),
          TextWidget(index: 2, value: isClicked),
          TextWidget(index: 3, value: isClicked),
        ]),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final List<int> value;
  final int index;

  const TextWidget({super.key, required this.value, required this.index});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: value[index],
      child: GestureDetector(
        child: Row(children: [
          Column(
            children: [
              Text(value.toString()),
              Text(key.toString()),
              Text('Text'),
            ],
          )
        ]),
        onTap: () {
          value[index] = 2;
          print("Clicked");
        },
      ),
    );
  }
}
