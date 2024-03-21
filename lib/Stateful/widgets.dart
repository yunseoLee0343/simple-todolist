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
  final Function(int, bool) updateSubTitle;

  TodoCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.fontFamily,
    required this.index,
    required this.flexVals,
    required this.updateFlexValue,
    required this.updateSubTitle,
  });

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
        widget.updateSubTitle(widget.index, flexed);

        if(flexed) widget.updateFlexValue(widget.index, 5);
        else widget.updateFlexValue(widget.index, 1);
      },
      child: Container(
        color: widget.color,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
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
          ],
        ),
      ),
    );
  }
}

