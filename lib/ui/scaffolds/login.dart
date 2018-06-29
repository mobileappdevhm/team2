import 'dart:async';

import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:courses_in_english/ui/basic_components/scenery_widget.dart';
import 'package:courses_in_english/ui/scaffolds/loading.dart';
import 'package:courses_in_english/ui/scaffolds/request_password_reset.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  Timer pageForward;

  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Builder(
        builder: (context) => new SceneryWrapperWidget(
              new Column(
                children: <Widget>[
                  titleRow(),
                  new Expanded(
                    child: new Column(
                      children: <Widget>[
                        new Expanded(
                          child: login(context),
                        ),
                        new Expanded(
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                child: new LineSeparator(),
                                margin:
                                    new EdgeInsets.symmetric(horizontal: 10.0),
                              ),
                              new Container(
                                child: resetButton(context),
                              ),
                              new Container(
                                child: new LineSeparator(),
                                margin:
                                    new EdgeInsets.symmetric(horizontal: 10.0),
                              ),
                              new Container(
                                child: continueAsGuest(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Row continueAsGuest() {
    return new Row(
      children: <Widget>[
        new Container(
          child: new RoundedButton(
            onPressed: () => Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new LoadingScaffold()),
                ),
            color: Colors.black,
            text: new Text(
              "Continue as Guest",
              style: new TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
          alignment: AlignmentDirectional.bottomCenter,
          margin: new EdgeInsets.symmetric(vertical: 25.0),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Column login(BuildContext context) {
    FocusNode passwordNode = new FocusNode();
    return new Column(
      children: <Widget>[
        userNameField(passwordNode),
        passwordField(passwordNode),
        loginButton(context),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Container loginButton(BuildContext context) {
    return new Container(
      child: new RoundedButton(
        onPressed: () => doLogin(context),
        text: new Text(
          "Login",
          style: new TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        color: Colors.black,
      ),
      alignment: AlignmentDirectional.center,
      margin: new EdgeInsets.symmetric(vertical: 20.0),
    );
  }

  Expanded userNameField(FocusNode passwordNode) {
    TextEditingController controller = new TextEditingController();
    controller.addListener(() {
      email = controller.text.toString();
    });
    return new Expanded(
      child: new Container(
          child: new TextFormField(
            maxLines: 1,
            maxLength: 40,
            decoration: new InputDecoration(
              labelText: "Input Username",
              icon: new Icon(Icons.person),
            ),
            onFieldSubmitted: (String input) {
              this.email = input;
              FocusScope.of(context).requestFocus(passwordNode);
            },
            controller: controller,
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
          maxLength: 30,
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

  Container titleRow() {
    return new Container(
        child: new Text("Courses in English",
            style: new TextStyle(
                fontWeight: FontWeight.w100, color: new Color(0xFF707070)),
            textScaleFactor: 2.5),
        alignment: AlignmentDirectional.center,
        margin: new EdgeInsets.symmetric(vertical: 10.0));
  }

  void doLogin(BuildContext context) {
    if (checkInput(context)) {
      new Injector().sessionController.login(email, password).then(
        (user) {
          showSnackBar("You're successfully logged in", context);
          new Injector().cieController.user = user;
          pageForward = new Timer(
            new Duration(milliseconds: 1000),
            () => Navigator.pushReplacement(
                this.context,
                new MaterialPageRoute(
                    builder: (context) => new LoadingScaffold())),
          );
        },
      ).catchError((e) async => showSnackBar("Login failure! $e}", context));
    }
  }

  bool checkInput(BuildContext context) {
    bool emailEmpty = true;
    bool containsAtAndDot = true;
    bool passwordEmpty = true;
    if (this.email != null) {
      if (this.email.length > 0) {
        emailEmpty = false;
        if (!(this.email.contains("@") && this.email.contains("."))) {
          containsAtAndDot = false;
        }
      }
    }
    if (this.password != null) {
      if (this.password.length > 0) {
        passwordEmpty = false;
      }
    }
    if (emailEmpty == true && passwordEmpty == false) {
      showSnackBar("Please enter a valid email!", context);
      return false;
    }
    if (emailEmpty == false && passwordEmpty == true) {
      showSnackBar("Please enter a valid password!", context);
      return false;
    }
    if (emailEmpty == true && passwordEmpty == true) {
      showSnackBar("Please enter data", context);
      return false;
    }
    if (containsAtAndDot == false) {
      showSnackBar("Please enter data in a valid format", context);
      return false;
    }
    return true;
  }

  resetButton(BuildContext context) {
    return new FlatButton(
      onPressed: (() {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new RequestPasswordReset()));
      }),
      child: new Text(
        "Forgot Password?",
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.redAccent.withOpacity(0.8),
        ),
      ),
    );
  }

  void showSnackBar(String text, BuildContext context) {
    Scaffold.of(context).showSnackBar(
          new SnackBar(
            content: new Text(
              text,
              textAlign: TextAlign.center,
            ),
            duration: new Duration(seconds: 1),
          ),
        );
  }

  @override
  void dispose() {
    super.dispose();
    pageForward?.cancel();
  }
}
