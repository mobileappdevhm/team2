import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  final String _userEmail;

  ResetPassword(String email) : _userEmail = email;

  @override
  Widget build(BuildContext context) {
    String code;
    String newPassword;
    String newPasswordRepeat;

    TextEditingController codeController = new TextEditingController();
    codeController.addListener(() {
      code = codeController.text.toString();
    });
    TextEditingController passwordController = new TextEditingController();
    passwordController.addListener(() {
      newPassword = passwordController.text.toString();
    });
    TextEditingController passwordRepeatController =
        new TextEditingController();
    passwordRepeatController.addListener(() {
      newPasswordRepeat = passwordRepeatController.text.toString();
    });
    Text buttonText = new Text("Reset Password",
        style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Reset Password"),
        centerTitle: true,
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new Column(
            children: <Widget>[
              new Expanded(
                child: new Column(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        child: new Text(
                          "Reset password for User with the E-Mail: ",
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: 15.0),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                    new Expanded(
                      child: new Container(
                        child: new Text(
                          _userEmail,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
              inputField("Reset Code"),
              inputField("Password"),
              inputField("Repeat Password"),
              new Container(
                child: new RoundedButton(
                  text: buttonText,
                  onPressed: (() {
                    resetPassword(_userEmail, code, newPassword,
                        newPasswordRepeat, context);
                  }),
                ),
                margin: const EdgeInsets.only(bottom: 30.0),
              ),
            ],
          );
        },
      ),
    );
  }

  Expanded inputField(
    String labelText,
  ) {
    return new Expanded(
      child: new Container(
        child: new TextFormField(
          decoration: new InputDecoration(
            labelText: labelText,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 40.0),
      ),
    );
  }

  void resetPassword(String userMail, String code, String newPassword,
      String newPasswordRepeat, BuildContext context) {
    if (newPasswordRepeat != newPassword) {
      Scaffold.of(context).showSnackBar(
            new SnackBar(
              content: new Text("Passwords must match!"),
            ),
          );
    } else {
      new Session().passwordReset(userMail, newPassword, code);
      //TODO show Snackbar based upon succes of passwordReset
    }
  }
}
