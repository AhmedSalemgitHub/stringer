import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen(this.user);

  final String user;

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("First Screen Loged In with email :${widget.user}"),
          ],
        ),
      ),
    );
  }
}
