import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  static final String resetPasswordButton = "Reset Password";
  static final String passwordsNoMatchSnack = "Passwords must match!";

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
                inputField("Password", _newPassword, passwordController,
                    passwordNode, repeatNode, true, context),
                inputField("Repeat Password", _newPasswordRepeat,
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

  void resetPassword(String userMail, String code, String newPassword,
      String newPasswordRepeat, BuildContext context) {
    //TODO reinstantiate pw length.
    if (newPasswordRepeat != newPassword || newPassword.length < 1) {
      Scaffold.of(context).showSnackBar(
            new SnackBar(
              content: new Text(
                PasswordReset.passwordsNoMatchSnack,
                style: new TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
            ),
          );
    } else {
      //TODO do passwordReset stuff..
      //new Session().passwordReset(userMail, newPassword, code);
      //TODO show Snackbar based upon succes of passwordReset
    }
  }

  Widget resetButton(BuildContext context) {
    return new Container(
      child: new RoundedButton(
        text: new Text(PasswordReset.resetPasswordButton,
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
