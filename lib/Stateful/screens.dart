import 'dart:developer';

import 'package:dorun_2th_flutter_study/Stateful/models.dart';
import 'package:dorun_2th_flutter_study/Stateful/route.dart';
import 'package:dorun_2th_flutter_study/Stateful/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            children: List.generate(subItems.length, (index) {
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
                  items: items,
                  subItems: subItems,
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

class CreatePage extends StatefulWidget {
  final List<String> items;
  final List<String> subItems;

  CreatePage({required this.items, required this.subItems});

  @override
  State<StatefulWidget> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  Color backgroundColor = Color(0xffD3D3D3);
  String fontFamily = "Jalnan";

  // for storing input temporarily
  ToDoItem temp = new ToDoItem(content: "", todoItemState: ToDoItemState.waiting);

  List<bool> isChecked = List.filled(4, false);

  // for adding to repository
  var _targetCardVal; // what to add
  int _targetCardIdx = 0; // where to add

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Create Todo", style: TextStyle(fontFamily: fontFamily,),),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => context.go('/'),
          ),
          shape: Border(bottom: BorderSide(color: Colors.black, width: 1,)),
          backgroundColor: backgroundColor,
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("What to do?", style: TextStyle(fontFamily: fontFamily, fontSize: 25),),
              SizedBox(height: MediaQuery.sizeOf(context).height / 50,),
              SizedBox(
                child: TextField(
                  decoration: InputDecoration(hintText: "What are you planning to do?"),
                  onSubmitted: (String input) {
                    if(input != "") temp = new ToDoItem(content: input, todoItemState: ToDoItemState.created);
                    else log("[WARN] #CreatePage# Empty temp created. ToDoItem("",ToDoItemState.created)");
                  },
                ),
              ),

              SizedBox(height: MediaQuery.sizeOf(context).height / 10,),

              Text("How Important it is?", style: TextStyle(fontFamily: fontFamily, fontSize: 25),),
              SizedBox(height: MediaQuery.sizeOf(context).height / 50,),
              Expanded(
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      print(widget.subItems[index]);

                      return ListTile(
                        title: Text(widget.items[index], style: TextStyle(fontFamily: fontFamily, fontSize: 20),),
                        subtitle: Text(widget.subItems[index], style: TextStyle(fontFamily: fontFamily,),),

                        leading: Radio<String>(
                          value: widget.items[index],
                          groupValue: _targetCardVal,
                          onChanged: (var value) {
                            setState(() {
                              _targetCardVal = widget.items[index];
                              _targetCardIdx = index;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                      );
                    }
                ),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width/1.5,
                      child: OutlinedButton(
                        onPressed: () {
                          temp.todoItemState = ToDoItemState.updated;
                          if(_targetCardVal != "")Repository.add(_targetCardIdx, temp);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)),),
                          foregroundColor: Colors.black,
                          side: BorderSide(color: Colors.black, width: 5,),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Create", style: TextStyle(fontFamily: fontFamily, fontSize: 25,), ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        backgroundColor: backgroundColor,
      ),
    );
  }
}