import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TodoCard extends StatefulWidget {
  final String title;
  final Color color;
  final String fontFamily;
  int index = 0;
  List flexVals = [];
  final Function(int, int) updateFlexValue;

  TodoCard({super.key, required this.title, required this.color, required this.fontFamily, required this.index, required this.flexVals, required this.updateFlexValue});

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
        if(flexed) widget.updateFlexValue(widget.index, 3);
        else widget.updateFlexValue(widget.index, 1);
        flexed = !flexed;
      },
      child: ListTile(
        tileColor: widget.color,
        title: Text(
          widget.title,
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