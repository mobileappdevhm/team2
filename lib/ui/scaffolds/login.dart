import 'dart:async';

import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/model/user/user_settings.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:courses_in_english/ui/basic_components/scenery_widget.dart';
import 'package:courses_in_english/ui/scaffolds/bnb_home.dart';
import 'package:courses_in_english/ui/scaffolds/reset_password_request.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static final String noPasswordSnack = "Please enter a Password!";
  static final String noEmailSnack = "Please enter a E-Mail!";
  static final String noEmailAndNoPasswordSnack =
      "Please Enter a E-Mail and a Password!";
  static final String emailWrongFormatSnack =
      "Please enter a proper E-Mail e.G: 'abc@d.e'";
  static final String continueAsGuestSnack = "Hello Guest :)";
  static final String loginFailureSnack = "Login Failure!";
  static final String loginSuccessSnack = "Yaaay you're logged in!";
  static final Key keyLoginButton = new Key("loginButton");
  static final Key keyGuestButton = new Key("guestButton");
  static final Key keyEmailField = new Key("emailField");
  static final Key keyPasswordField = new Key("passwordField");
  static final Key keyResetKey = new Key("resetKey");
  static final String continueAsGuestButton = "Continue as Guest";
  static final String resetPasswordButton = "Reset Password!";
  static final String loginButton = "Login";

  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Builder(builder: (BuildContext context) {
        return new SceneryWrapperWidget(
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
                            margin: new EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          new Container(child:
                              resetButton(context),
                          ),
                          new Container(
                            child: new LineSeparator(),
                            margin: new EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          new Container(
                            child: continueAsGuest(context),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Row continueAsGuest(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(
          child: new RoundedButton(
            text: new Text(
              LoginScreen.continueAsGuestButton,
              style: new TextStyle(fontSize: 18.0,color: Colors.white),
            ),
            onPressed: (() {
              Session s = new Session();
              s.setSettings(new UserSettings());
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: new Text(LoginScreen.continueAsGuestSnack),
                duration: new Duration(seconds: 1),));
              new Future.delayed(new Duration(seconds: 1), () {
                Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new HomeScaffold()),
                );
              });
            }),
            color: Colors.black,
            key: LoginScreen.keyGuestButton,
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
        onPressed: (() {
          if (checkInput(context)) {
            doLogin(context);
          }
        }),
        text: new Text(
          LoginScreen.loginButton,style: TextStyle(fontSize: 18.0,color: Colors.white),
        ),
        color: Colors.black,
        key: LoginScreen.keyLoginButton,
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
            //maxLength: 20, TODO REINSTATE
            decoration: new InputDecoration(
              labelText: "Input E-Mail",
              icon: new Icon(Icons.person),
            ),
            onFieldSubmitted: (String input) {
              this.email = input;
              FocusScope.of(context).requestFocus(passwordNode);
            },
            key: LoginScreen.keyEmailField,
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
          key: LoginScreen.keyPasswordField,
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
    Session s = new Session();
    new Session().login(
      email,
      password,
      success: (session) {
        Scaffold.of(context).showSnackBar(
          new SnackBar(
            content: new Text(
              LoginScreen.loginSuccessSnack,
              textAlign: TextAlign.center,
            ),
            duration: new Duration(seconds: 1),
          ),
        );
        new Future.delayed(new Duration(milliseconds: 1200), () {
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => new HomeScaffold()),
          );
        });
      },
      failure: (session, error) {
        Scaffold.of(context).showSnackBar(
          new SnackBar(
            content: new Text(
              LoginScreen.loginFailureSnack,
              textAlign: TextAlign.center,
            ),
            duration: new Duration(seconds: 2),
          ),
        );
      },
    );
    if (s.user != null) {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new HomeScaffold()),
      );
    }
  }

  bool checkInput(BuildContext context) {
    bool emailEmpty = true;
    bool containsAtAndDot = true;
    bool passwordEmpty = true;
    if (this.email != null) {
      if (this.email.length > 0) {
        emailEmpty = false;
        if (!this.email.contains("@") && !this.email.contains(".")) {
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
      Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: new Text(
            LoginScreen.noEmailSnack,
            textAlign: TextAlign.center,
          ),
          duration: new Duration(seconds: 2),
        ),
      );
      return false;
    }
    if (emailEmpty == false && passwordEmpty == true) {
      Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: new Text(
            LoginScreen.noPasswordSnack,
            textAlign: TextAlign.center,
          ),
          duration: new Duration(seconds: 2),
        ),
      );
      return false;
    }
    if (emailEmpty == true && passwordEmpty == true) {
      Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: new Text(
            LoginScreen.noEmailAndNoPasswordSnack,
            textAlign: TextAlign.center,
          ),
          duration: new Duration(seconds: 2),
        ),
      );
      return false;
    }
    if (containsAtAndDot == false) {
      Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: new Text(
            LoginScreen.emailWrongFormatSnack,
            textAlign: TextAlign.center,
          ),
          duration: new Duration(seconds: 2),
        ),
      );
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
                builder: (context) =>
                new ResetPasswordRequest()));
      }),
      child: new Text(
        LoginScreen.resetPasswordButton, style: TextStyle(fontSize: 15.0,color: Colors.redAccent.withOpacity(0.8),),),
      key: LoginScreen.keyResetKey,
    );
  }
}
