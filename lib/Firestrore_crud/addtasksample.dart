import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final contentController= TextEditingController();
  final timestampController= TextEditingController();
  final CollectionReference task= FirebaseFirestore.instance.collection('record');
  addTask(){
    final data = {
      'content': contentController.text,
    'timestamp': timestampController.text
    };
    task.add(data);

    print("*************************************************Success***********************");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text("Add task"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: contentController,
            decoration: InputDecoration(label: Text("Content")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: timestampController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text("Timestamp")),
          ),
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal)),
            onPressed: () {
              addTask();
              Navigator.pop(context);
            },
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ))
      ]),
    );
  }
}