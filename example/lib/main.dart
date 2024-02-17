import 'package:flutter/material.dart';
import 'package:notebook_paper/notebook_paper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: const NotebookPaper(
              entireText: 'Hello, Notebook Paper!',
              title: 'My Notebook',
              fontSize: 20.0,
              rowHeight: 1.0,
              width: 0.8,
              paperColor: Color.fromARGB(255, 253, 248, 184),
              horizontalLinesColor: Colors.blue,
              verticalLinesColor: Colors.pink,
              pageTitle: true,
            ),
          ),
        ),
      ),
    );
  }
}
