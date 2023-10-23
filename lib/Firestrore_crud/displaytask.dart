import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter16firebase2/Firestrore_crud/updatetask.dart';
import 'package:flutter16firebase2/Firestrore_crud/addtasksample.dart';


class DisplayTask extends StatefulWidget {
  const DisplayTask({super.key});

  @override
  State<DisplayTask> createState() => _DisplayTaskState();
}

class _DisplayTaskState extends State<DisplayTask> {
  final CollectionReference task =
      FirebaseFirestore.instance.collection('record');
  // final CollectionReference task1 =
  // FirebaseFirestore.instance.collection('task');
  deleteTask(docId) {
    task.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text("Flutter CRUD Operation"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.teal,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddTask(),
            ));
          },
          label: Text("Add task"),
          icon: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: task.orderBy('timestamp').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot taskSnap =
                        snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.yellow[200],
                        child: Column(
                          children: [
                            ListTile(
                                title: Text('${taskSnap['content']}'),
                                subtitle: Text('${taskSnap['timestamp']}')),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return UpdateTask(
                                            content: taskSnap['content'],
                                            timestamp: taskSnap['timestamp']
                                                .toString(),
                                            id: taskSnap.id);
                                      }));
                                    },
                                    icon: Icon(color: Colors.teal, Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      deleteTask(taskSnap.id);
                                    },
                                    icon: Icon(color: Colors.red, Icons.delete))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Container();
          },
        ));
  }
}
