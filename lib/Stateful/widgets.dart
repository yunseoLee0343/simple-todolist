import 'package:dorun_2th_flutter_study/Stateful/models.dart';
import 'package:dorun_2th_flutter_study/Stateful/screens.dart';
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

  final List items;
  final List subItems;

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
    required this.items,
    required this.subItems,
  });

  @override
  State<StatefulWidget> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool flexed = false;
  bool _offstage = true;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        flexed = !flexed;
        widget.updateSubTitle(widget.index, flexed);

        if(flexed) widget.updateFlexValue(widget.index, 4); //5 이상일 경우 Overflow 발생. 이슈 등록 필요.
        else widget.updateFlexValue(widget.index, 1);

        // show TodoTexts
        setState(() {
          _offstage = !_offstage;
        });
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
                onPressed: () => context.goNamed("create", pathParameters: {'items': widget.items.join(","), 'subItems': widget.subItems.join("|")}),
              ),
            ),

            Expanded(
              child: Offstage(
                offstage: _offstage,
                child: TodoList(cardIdx: widget.index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  final int cardIdx;
  const TodoList({required this.cardIdx});

  @override
  State<StatefulWidget> createState() => _TodoTextState();
}

class _TodoTextState extends State<TodoList> {
  late List<ToDoItem> _items;
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    _items = Repository.getItems(widget.cardIdx);

    return ListView.builder(
      itemCount: _items.isEmpty ? 1 : _items.length,
      itemBuilder: (context, index) => _items.isEmpty
          ? Text("ALL DONE!\nClick + Button To Add ToDo Items!", style: TextStyle(fontSize: 17),)
          : TextButton(
              child: Text(_items[index].content, style: TextStyle(fontSize: 17, decoration: _isToggled ? TextDecoration.lineThrough : null,),),
              onPressed: () {
                setState(() => _isToggled = !_isToggled);
                Repository.updateItem(index, _items[index].content, ToDoItemState.strikeouted);
              },
              onLongPress: () {
                Repository.deleteItem(index, _items[index].content);
              },
              style: TextButton.styleFrom(alignment: Alignment.centerLeft,),
            ),
      padding: EdgeInsets.all(10),
    );
  }
}
