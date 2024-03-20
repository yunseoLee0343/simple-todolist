import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TodoCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final Color color;
  final String fontFamily;
  int index = 0;
  List flexVals = [];
  final Function(int, int) updateFlexValue;
  final Function(int) updateSubTitle;
  final Function() restoreSubTitle;

  TodoCard({super.key, required this.title, required this.subTitle, required this.color, required this.fontFamily, required this.index, required this.flexVals, required this.updateFlexValue, required this.updateSubTitle, required this.restoreSubTitle,});

  @override
  State<StatefulWidget> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool flexed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        flexed = !flexed;
        if(flexed) {
          widget.updateFlexValue(widget.index, 5);
          widget.updateSubTitle(widget.index);
        }
        else {
          widget.restoreSubTitle();
          widget.updateFlexValue(widget.index, 1);
        }
      },
      child: ListTile(
        tileColor: widget.color,
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: widget.fontFamily, fontSize: 30),
        ),
        subtitle: Text(
          widget.subTitle,
          style: TextStyle(fontFamily: widget.fontFamily),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => context.go('/create'),
        ),
      ),
    );
  }
}

