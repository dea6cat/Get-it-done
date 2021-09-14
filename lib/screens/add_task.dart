//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it_done/helpers/database_helper.dart';
import 'package:get_it_done/models/task_model.dart';
import 'package:intl/intl.dart';

class addTask extends StatefulWidget {
  final Task task;
  final Function updateTaskList;

  const addTask({Key key, this.task, this.updateTaskList})
      : super(key: key);
  @override
  _addTaskState createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority;
  DateTime _date = DateTime.now();

  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final List<String> _priorities = ['Low', 'Medium', 'High', 'Significant'];
  AndroidInitializationSettings androidInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.task != null) {
      _title = widget.task.title;
      _date = widget.task.date;
      _priority = widget.task.priority;
    }
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose(){
    _dateController.dispose();
    super.dispose();
  }


  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }
  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title $_date $_priority');

      //insert the task to our user's database
      Task task = Task(title: _title, date: _date, priority: _priority);
      if (widget.task == null) {
        task.status = 0;
        DatabaseHelper.instance.insertTask(task);
      } else {
        //update the task
        task.id = widget.task.id;
        task.status = widget.task.status;
        DatabaseHelper.instance.updateTask(task);
      }
      widget.updateTaskList();
      Navigator.pop(context);
    }
  }

  _delete() {
    DatabaseHelper.instance.deleteTask(widget.task.id);
    widget.updateTaskList();
    Navigator.pop(context);
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: const Color(0XFF03DAC5),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(widget.task == null ? 'Add Task' : 'Update Task',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              labelText: 'Title',
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          validator: (input) => input.trim().isEmpty
                              ? "Please enter a task"
                              : null,
                          onSaved: (input) => _title = input,
                          initialValue: _title,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          onTap: _handleDatePicker,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              labelText: 'Date',
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),

                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: DropdownButtonFormField(
                            isDense: true,
                            items: _priorities.map((String priority) {
                              return DropdownMenuItem(
                                  value: priority,
                                  child: Text(
                                    priority,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ));
                            }).toList(),
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                                labelText: 'Priority',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            validator: (input) => _priority == null
                                ? "Please Select a priority level"
                                : null,
                            onChanged: (value) {
                              setState(() {
                                _priority = value;
                              });
                            },
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0XFF03DAC5),
                            borderRadius: BorderRadius.circular(30)),
                        child: FlatButton(
                          onPressed: _submit,
                          child: Text(
                            widget.task == null ? "Add" : 'Update',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      widget.task == null
                          ? SizedBox.shrink()
                          : Container(
                        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0XFF6200EE),
                            borderRadius: BorderRadius.circular(30)),
                        child: FlatButton(
                          onPressed: _delete,
                          child: Text(
                            'Delete',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}