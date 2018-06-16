import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/ui/scaffolds/reset_password.dart';
import 'package:flutter/material.dart';

class ResetPasswordRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userEmail;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Request Reset Code"),
        centerTitle: true,
      ),
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
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40.0),
            ),
          ),
          new Expanded(
            child: new Container(
              child: new RaisedButton(
                onPressed: (() {
                  if (userEmail != null &&
                      userEmail.contains("@") &&
                      userEmail.contains(".")) {
                    new Session().requestPasswordReset(userEmail);
                    Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ResetPassword(userEmail)),
                    );
                  }
                }),
                child: new Text("Request Reset Code"),
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
