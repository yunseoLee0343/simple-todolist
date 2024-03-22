import 'dart:collection';
import 'dart:developer';

enum ToDoItemState {
  waiting, created, updated, strikeouted;
}

class ToDoItem {
  String content;
  ToDoItemState todoItemState;

  ToDoItem({required this.content, required this.todoItemState});
}

class Repository {
  static final Repository _repository = Repository();
  factory Repository() => _repository;

  static Map<int, List<ToDoItem>> map = HashMap();

  static add(int index, ToDoItem item) {
    map.putIfAbsent(index, () => <ToDoItem>[]);
    map.update(index, (List<ToDoItem> value) {
      if(item.content != "") {
        value.add(item);
        log("[Notify] #Repository# '${item.content}' is added to the $index card above.");
      }
      return value;
    });
  }

  static List<ToDoItem> getItems(int index) {
    List<ToDoItem> items = [];
    map.forEach((key, value) { if(key == index) items = value; });

    if(items.isEmpty) log("[Notify] #Repository# $index card is empty. getItem() returned empty list.");
    return items;
  }

  static void updateItem(int index, String content, ToDoItemState toDoItemState) {
    map.forEach((key, value) {
      if(key == index) {
        value.forEach((ToDoItem element) {
          if(element == content) {
            element.content = content;
            element.todoItemState = toDoItemState;
          }
        });
      }
    });
  }

  static void deleteItem(int index, String content) {
    List pointer = [];

    map.forEach((key, value) {
      if (key == index) pointer = value;
    });
    if(pointer.isNotEmpty) pointer.remove(content);
    else log("[Notify] #Repository# Tries to delete empty list in repository.");
  }
}