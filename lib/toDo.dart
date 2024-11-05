import 'package:flutter/material.dart';
import 'package:todo/second.dart';

import 'database.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  database mydata = database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todo App"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.add), // Add an "add" icon
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return Second(); // Navigate to the Second screen
                }));
              },
            ),
          ],
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data;
                if (data != null && data.isNotEmpty) {
                  // For demonstration, converting the first row's data to a string
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                data[index]["time"],
                                style: TextStyle(color: Colors.white),
                              ),
                              radius: 30,
                              backgroundColor: Colors.black,
                            ),
                            title: Text(data[index]["title"]),
                            subtitle: Text(data[index]["subtitle"]),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 35,
                                color: Colors.black,
                              ),
                              onPressed: () async {
                                setState(() {});
                                await mydata.deleteData(data[index]["id"]);
                              },
                            ),
                          ),
                          color: Colors.grey[100],
                          elevation: 10,
                        ),
                      );
                    },
                    itemCount: data.length,
                  );
                } else {
                  return Center(
                    child: Text("No data found"),
                  );
                }
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          future: mydata.readData(),
        ));
  }
}
