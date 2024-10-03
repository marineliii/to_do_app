// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/my_button.dart';
import 'package:to_do_app/util/todo_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  final _controller = TextEditingController();

@override
  void initState() {
    
    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }else{
      db.loadData();
    }

    
    super.initState();
  }


// metod
void checkBoxChanged(bool? value,int index){
setState(() {
 db.toDoList[index][1] = !db.toDoList[index][1];
});
db.updateData();
}

// save new task

void saveNewTask(){
  setState(() {
    db.toDoList.add([_controller.text,false]);
    _controller.clear();
  });
  Navigator.of(context).pop();
  db.updateData();
}

// delete task

void deleteTask(int index){
setState(() {
  db.toDoList.removeAt(index);
});
db.updateData();
}


// create new task

void createNewTask(){
showDialog(
  context: context,
  builder: (context){
    return DialogBox(
      controller: _controller,
      onSave: saveNewTask,
      onCancel: Navigator.of(context).pop
      );
  },

);
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("TO DO"),
        elevation: 0,
        
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add, color: Colors.deepPurple,),
      ),
      body: ListView.builder(
       itemCount: db.toDoList.length,
       itemBuilder: (context, index){
        return TodoTitle(
          taskName: db.toDoList[index][0],
           taskCompleted: db.toDoList[index][1], 
           onChanged: (value) => checkBoxChanged(value,index) ,
           deleteFunction: (context) => deleteTask(index) , 
           );
       },
      ),
    );
  }
}