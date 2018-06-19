import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  final String _userEmail;

  ResetPassword(String email) : _userEmail = email;

  @override
  State<StatefulWidget> createState() => _ResetPasswordState(_userEmail);
}

class _ResetPasswordState extends State<ResetPassword> {
  String _code;
  String _newPassword;
  String _newPasswordRepeat;
  String _userEmail;
  TextEditingController codeController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordRepeatController = new TextEditingController();

  _ResetPasswordState(String string) : _userEmail = string;

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
              inputField("Password", _newPassword, passwordController,
                  passwordNode, repeatNode, true, context),
              inputField("Repeat Password", _newPasswordRepeat,
                  passwordRepeatController, repeatNode, null, true, context),
              resetButton(),
            ],
          );
        },
      ),
    );
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

  Widget resetButton() {
    return new Container(
      child: new RoundedButton(
        text: new Text("Reset Password",
            style: new TextStyle(fontSize: 18.0, color: Colors.white)),
        onPressed: (() {
          resetPassword(
              _userEmail, _code, _newPassword, _newPasswordRepeat, context);
        }),
        color: Colors.black,
      ),
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      alignment: Alignment.center,
    );
  }
}
