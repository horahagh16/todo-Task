import 'package:flutter/material.dart';
import 'package:todo1_app/forms/task.dart';
import 'package:todo1_app/forms/tasks.dart';

class Home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<Home> {
  TextEditingController forTitle;
  TextEditingController forDesc;

  @override
  void initState() {
    forTitle = TextEditingController();
    forDesc = TextEditingController();
  }

  void dispose() {
    forTitle.dispose();
    forDesc.dispose();
  }

  void _showDetails(context, task old, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(
                child: Card(
              color:
                  old.isDone ? Colors.lightGreenAccent[100] : Colors.cyan[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Text(old.title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Text(old.description),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Text(old.time.toString())),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("done:"),
                            Switch(
                              value: old.getStatus(),
                              onChanged: (value) {
                                setState(() {
                                  old.converter();
                                });
                              },
                              activeTrackColor: Colors.lightBlueAccent[100],
                              activeColor: Colors.blueAccent,
                            ),
                          ])),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 40)),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('close')),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 40)),
                ],
              ),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                Colors.blue[900],
                Colors.cyan[700],
                Colors.lightGreenAccent[100],
              ])),
        ),
        title: Text('Todo App'),
        leading: Icon(Icons.assignment),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.indigo),
        onPressed: () {
          DateTime time;
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(5),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: TextField(
                              controller: forTitle,
                              decoration: InputDecoration(labelText: 'Title'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: forDesc,
                              decoration:
                                  InputDecoration(labelText: 'description'),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: RaisedButton(
                                    child: Text("Pick a date"),
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2021),
                                              lastDate: DateTime(2022))
                                          .then((date) {
                                        setState(() {
                                          time = date;
                                        });
                                      });
                                    }),
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                            ],
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 40)),
                          ElevatedButton(
                            child: Text('Add'),
                            onPressed: () {
                              setState(() {
                                Tasks.add(task(
                                    forTitle.text, forDesc.text, false, time));
                                forTitle.clear();
                                forDesc.clear();
                                Navigator.pop(context);
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      body: ListView.builder(
          itemCount: Tasks.taskGetter().length,
          itemBuilder: (context, int index) {
            return GestureDetector(
                onTap: () {
                  task old = Tasks.tasks.elementAt(index);
                  _showDetails(context, old, index);
                },
                child: Card(
                  child: ListTile(
                    title: Text(Tasks.taskGetter().elementAt(index).getTitle(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    tileColor: Tasks.taskGetter().elementAt(index).getStatus()
                        ? Colors.lightGreenAccent[100]
                        : Colors.cyan[100],
                    trailing: Switch(
                      value: Tasks.taskGetter().elementAt(index).getStatus(),
                      onChanged: (value) {
                        setState(() {
                          Tasks.taskGetter().elementAt(index).converter();
                        });
                      },
                      activeTrackColor: Colors.lightBlueAccent[100],
                      activeColor: Colors.blueAccent,
                    ),
                  ),
                ));
          }),
    );
  }
}
