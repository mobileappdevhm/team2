import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
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
        body: new Builder(builder: (BuildContext context) {
          return new Column(
            children: <Widget>[
              topHalf(userEmail),
              lowerHalf(userEmail, context),
            ],
          );
        }));
  }

  Widget topHalf(String userEmail) {
    return new Expanded(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Text(
              "A reset Code will be sent to the E-Mail address entered below.",
              style: TextStyle(fontSize: 18.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 40.0),
          ),
          new Container(
            child: new TextField(
              decoration: new InputDecoration(labelText: "Input E-Mail:"),
              onChanged: (input) {
                userEmail = input;
              },
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40.0),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }

  Widget lowerHalf(String userEmail, context) {
    return new Expanded(
      child: new Column(
        children: <Widget>[
          requestButton(userEmail, context),
          skipRequest(userEmail, context),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget requestButton(String userEmail, BuildContext context) {
    return new Container(
      child: new RoundedButton(
        onPressed: (() {
          if (userEmail != null &&
              userEmail.contains("@") &&
              userEmail.contains(".")) {
            new Session().requestPasswordReset(userEmail);
            //TODO show message if email is in database or not.
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ResetPassword(userEmail)),
            );
          } else {
            Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text(
                    "Please Enter a Valid E-Mail in the Format: abc@d.e",
                    textAlign: TextAlign.center,
                  ),
                  duration: new Duration(seconds: 3),
                ));
          }
        }),
        color: Colors.black,
        text: new Text(
          "Request Reset Code",
          style: new TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      ),
      alignment: Alignment.center,
    );
  }

  Widget skipRequest(String userEmail, BuildContext context) {
    return new Container(
      child: new FlatButton(
        onPressed: (() {
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (context) => new ResetPassword(userEmail)),
          );
        }),
        child: new Text(
          "Already have a Reset-Code? Click here!",
          style: TextStyle(
            color: Colors.grey.withOpacity(0.8),
          ),
        ),
      ),
      margin: const EdgeInsets.only(top: 30.0),
    );
  }
}
