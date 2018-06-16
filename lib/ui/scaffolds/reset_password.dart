import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  String userEmail;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
      children: <Widget>[
        new Expanded(
          child: new Container(
            child: new TextField(
              decoration: new InputDecoration(labelText: "Input E-Mail:"),
              onChanged: (input) {
                userEmail = input;
              },
            ),
          ),
        ),
        new Expanded(
          child: new Container(
            child: new RaisedButton(
              onPressed: (() {}),
              child: new Text("Request Reset Code"),
            ),
          ),
        ),
      ],
    ));
  }
}
