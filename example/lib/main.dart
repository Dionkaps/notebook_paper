import 'package:flutter/material.dart';
import 'package:notebook_paper/notebook_paper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notebook Paper Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Notebook Paper Example'),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: const NotebookPaper(
              entireText: 'Hello, Notebook Paper!',
              title: 'My Notebook',
              fontSize: 20.0,
              rowHeight: 1.0,
              width: 0.8, // Adjust the width as needed
              paperColor: Colors.white,
              horizontalLinesColor: Colors.grey,
              verticalLinesColor: Colors.black,
              pageTitle: true,
            ),
          ),
        ),
      ),
    );
  }
}
