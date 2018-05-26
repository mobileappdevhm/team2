import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/model/user/user.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/basic_components/scenery_widget.dart';
import 'package:courses_in_english/ui/scaffolds/bnb_home.dart';
import 'package:courses_in_english/ui/scaffolds/create_user.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new SceneryWrapperWidget(
        new Column(
          children: <Widget>[
            titleRow(),
            new Expanded(
              child: new Column(
                children: <Widget>[
                  new Expanded(
                    child: login(),
                  ),
                  new Container(
                    child: new LineSeparator(),
                    margin: new EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                  new Container(
                    child: createButton(),
                  ),
                  new Container(
                    child: new LineSeparator(),
                    margin: new EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                  new Container(
                    child: continueAsGuest(),
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
              Navigator.pushReplacement(
                context,
                new MaterialPageRoute(builder: (context) => new HomeScaffold()),
              );
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
          margin: new EdgeInsets.symmetric(vertical: 25.0),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Column login() {
    FocusNode passwordNode = new FocusNode();
    return new Column(
      children: <Widget>[
        userNameField(passwordNode),
        passwordField(passwordNode),
        loginButton(),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Container loginButton() {
    return new Container(
      child: new RaisedButton(
        onPressed: () {
          doLogin();
        },
        child: new Text(
          "Login",
        ),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(100000.0)),
        color: Colors.black,
        textColor: Colors.white,
      ),
      alignment: AlignmentDirectional.center,
      margin: new EdgeInsets.symmetric(vertical: 10.0),
    );
  }

  Expanded userNameField(FocusNode passwordNode) {
    TextEditingController controller = new TextEditingController();
    controller.addListener(() {
      username = controller.text.toString();
    });
    return new Expanded(
      child: new Container(
          child: new TextFormField(
            maxLines: 1,
            //maxLength: 20, TODO REINSTATE
            decoration: new InputDecoration(
              labelText: "Input Username",
              icon: new Icon(Icons.person),
            ),
            onFieldSubmitted: (String input) {
              this.username = input;
              FocusScope.of(context).requestFocus(passwordNode);
            },
          ),
          margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          alignment: Alignment.topCenter),
    );
  }

  Expanded passwordField(FocusNode passwordNode) {
    TextEditingController controller = new TextEditingController();
    controller.addListener(() {
      password = controller.text.toString();
    });
    return new Expanded(
      child: new Container(
        child: new TextFormField(
          maxLines: 1,
          //maxLength: 30,TODO REINSTATE
          decoration: new InputDecoration(
              labelText: "Input Password", icon: new Icon(Icons.vpn_key)),
          obscureText: true,
          onFieldSubmitted: (String input) {
            this.password = input;
          },
          controller: controller,
          focusNode: passwordNode,
        ),
        margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      ),
    );
  }

  Container createButton() {
    return new Container(
      child: new FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new CreateUserScreen()));
        },
        child: new Text(
          "No Account yet? -> Create new User",
          style: new TextStyle(fontSize: 10.0, color: Colors.blueAccent),
        ),
      ),
      alignment: AlignmentDirectional.topCenter,
      margin: new EdgeInsets.only(top: 5.0),
    );
  }

  Container titleRow() {
    return new Container(
        child: new Text("Courses in English",
            style: new TextStyle(
                fontWeight: FontWeight.w100, color: new Color(0xFF707070)),
            textScaleFactor: 2.5),
        alignment: AlignmentDirectional.center,
        margin: new EdgeInsets.symmetric(vertical: 20.0));
  }

  void doLogin() {
    if (username != null && password != null) {
      User user;
      new Data().userProvider.login(username, password).then((success) {
        user = success;
      });
      if (user != null) {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new HomeScaffold()),
        );
      }
    }
  }
}
