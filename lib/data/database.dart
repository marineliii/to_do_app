import 'package:hive/hive.dart';
import 'package:to_do_app/util/todo_title.dart';

class ToDoDataBase{

List toDoList = [];

final _myBox = Hive.box('mybox');

void createInitialData(){
  toDoList = [["1st task", false], ["2nd task",true]];
}
void loadData(){
toDoList = _myBox.get("TODOLIST");
}

void updateData(){
_myBox.put("TODOLIST", toDoList);
}

}