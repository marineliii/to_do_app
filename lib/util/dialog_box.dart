import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

   DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add new task.."
                ),
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(buttonName: "Save", isPressed: onSave),

              const SizedBox(width: 8),

              MyButton(buttonName: "Cancle", isPressed: onCancel),
            ],
          )
          ]),
      
      ),
    );
  }
}