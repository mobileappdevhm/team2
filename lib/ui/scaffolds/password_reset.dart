import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  final String _userEmail;

  PasswordReset(String email) : _userEmail = email;

  @override
  State<StatefulWidget> createState() => _PasswordResetState(_userEmail);
}

class _PasswordResetState extends State<PasswordReset> {
  String _code;
  String _newPassword;
  String _newPasswordRepeat;
  String _userEmail;
  TextEditingController codeController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordRepeatController = new TextEditingController();

  _PasswordResetState(String string) : _userEmail = string;

  @override
  Widget build(BuildContext context) {
    codeController.addListener(() {
      _code = codeController.text.toString();
    });

    passwordController.addListener(() {
      _newPassword = passwordController.text.toString();
    });

    passwordRepeatController.addListener(() {
      _newPasswordRepeat = passwordRepeatController.text.toString();
    });

    emailController = new TextEditingController(text: _userEmail);
    emailController.addListener(() {
      _userEmail = emailController.text.toString();
    });

    FocusNode resetNode = new FocusNode();
    FocusNode passwordNode = new FocusNode();
    FocusNode repeatNode = new FocusNode();

    return new Builder(builder: (BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Reset Password"),
          centerTitle: true,
        ),
        body: new Builder(
          builder: (BuildContext context) {
            return new Column(
              children: <Widget>[
                inputField("User E-Mail", _userEmail, emailController, null,
                    resetNode, false, context),
                inputField("Reset Code", _code, codeController, resetNode,
                    passwordNode, false, context),
                inputField(
                    "Password (min size = 5)",
                    _newPassword,
                    passwordController,
                    passwordNode,
                    repeatNode,
                    true,
                    context),
                inputField("Repeat Password (min size = 5)", _newPasswordRepeat,
                    passwordRepeatController, repeatNode, null, true, context),
                resetButton(context),
              ],
            );
          },
        ),
      );
    });
  }

  Expanded inputField(
      String labelText,
      String saveTo,
      TextEditingController controller,
      FocusNode own,
      FocusNode next,
      bool obscured,
      BuildContext context) {
    return new Expanded(
      child: new Container(
        child: new TextFormField(
          decoration: new InputDecoration(
            labelText: labelText,
          ),
          onFieldSubmitted: ((text) {
            saveTo = text;
            FocusScope.of(context).requestFocus(next);
          }),
          focusNode: own,
          controller: controller,
          obscureText: obscured,
        ),
        margin: const EdgeInsets.only(left: 40.0, right: 40.0),
        alignment: Alignment.center,
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    if (checkInput(context)) {
      new Injector()
          .sessionController
          .resetPassword(_userEmail, _code, _newPassword)
          .then((success) {
        if (success) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return new AlertDialog(
                  title: new Text("Password Successfully changed!"),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: (() {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }),
                        child: new Text("Return to Login Page"))
                  ],
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return new AlertDialog(
                  title: new Text("There was an Error changing the Password"),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: (() {
                          Navigator.of(context).pop();
                        }),
                        child: new Text("Close"))
                  ],
                );
              });
        }
      });
    }
  }

  Widget resetButton(BuildContext context) {
    return new Container(
      child: new RoundedButton(
        text: new Text("Reset Password",
            style: new TextStyle(fontSize: 18.0, color: Colors.white)),
        onPressed: (() {
          print(_userEmail);
          print(_code);
          print(_newPassword);
          resetPassword(context);
        }),
        color: Colors.black,
      ),
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      alignment: Alignment.center,
    );
  }

  bool checkInput(BuildContext context) {
    bool emailEmpty = true;
    bool containsAtAndDot = true;
    bool passwordEmpty = true;
    bool repeatPasswordEmpty = true;
    bool resetCodeEmpty = true;
    if (_userEmail != null) {
      if (_userEmail.length > 0) {
        emailEmpty = false;
        if (!(_userEmail.contains("@") && _userEmail.contains("."))) {
          containsAtAndDot = false;
        }
      }
    }
    if (_newPassword != null) {
      if (_newPassword.length > 0) {
        passwordEmpty = false;
      }
    }
    if (_newPasswordRepeat != null) {
      if (_newPasswordRepeat.length > 0) {
        repeatPasswordEmpty = false;
      }
    }
    if (_code != null) {
      if (_code.length > 0) {
        resetCodeEmpty = false;
      }
    }
    if (emailEmpty || passwordEmpty || resetCodeEmpty || repeatPasswordEmpty) {
      showSnackBar("Please fill all Input Fields", context);
      return false;
    }
    if (containsAtAndDot == false) {
      showSnackBar("Please enter data in a valid format", context);
      return false;
    }
    if (_newPasswordRepeat != _newPassword) {
      showSnackBar("Passwords must match!", context);
      return false;
    }
    if (_newPassword.length < 5) {
      showSnackBar("Password is to Short (min. 5)", context);
      return false;
    }
    return true;
  }

  void showSnackBar(String text, BuildContext context) {
    Scaffold.of(context).showSnackBar(
          new SnackBar(
            content: new Text(
              text,
              textAlign: TextAlign.center,
              style: new TextStyle(fontSize: 24.0),
            ),
            duration: new Duration(seconds: 1),
          ),
        );
  }
}
