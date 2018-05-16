import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/basic_components/scenery_widget.dart';
import 'package:courses_in_english/ui/scaffolds/bnb_home.dart';
import 'package:courses_in_english/ui/screens/create_user_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SceneryWrapperWidget(
        new Column(
          children: <Widget>[
            titleRow(),
            new Expanded(
              child: new Column(
                children: <Widget>[
                  new Expanded(
                    child: continueAsGuest(),
                  ),
                  new Container(child: new LineSeparator(),margin: EdgeInsets.symmetric(horizontal: 10.0),),
                  new Expanded(
                    child: createUser(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row continueAsGuest() {
    return new Row(
      children: <Widget>[
        new Container(
          child: new RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new HomeScaffold()));
            },
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(100000.0)),
            color: Colors.black,
            textColor: Colors.white,
            child: new Text(
              "Continue as Guest",
              style: new TextStyle(fontSize: 18.0),
            ),
          ),
          alignment: AlignmentDirectional.bottomCenter,
          margin: EdgeInsets.only(bottom: 15.0),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Row createUser() {
    return new Row(
      children: <Widget>[
        new Container(
          child: new RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new CreateUserScreen()));
            },
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(100000.0)),
            color: Colors.black,
            textColor: Colors.white,
            child: new Text(
              "Create new User",
              style: new TextStyle(fontSize: 18.0),
            ),
          ),
          alignment: AlignmentDirectional.topCenter,
          margin: EdgeInsets.only(top: 15.0),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Container titleRow() {
    return new Container(
        child: new Text("Courses in English",
            style: new TextStyle(
                fontWeight: FontWeight.w100, color: new Color(0xFF707070)),
            textScaleFactor: 2.5),
        alignment: AlignmentDirectional.center,
        margin: EdgeInsets.symmetric(vertical: 20.0));
  }
}
