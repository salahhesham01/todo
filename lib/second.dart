import 'package:flutter/material.dart';
import 'package:todo/toDo.dart';

import 'database.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  var title = TextEditingController();
  var subtitle = TextEditingController();
  var time = TextEditingController();
  database db = database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ADD Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(
                  label: Text("Title"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: subtitle,
              decoration: InputDecoration(
                  label: Text("SubTitle"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: time,
              decoration: InputDecoration(
                  label: Text("Time"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                db.InsertData(title.text, subtitle.text, time.text);
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return Todo();
                }));
              },
              child: Text(
                "ADD",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
