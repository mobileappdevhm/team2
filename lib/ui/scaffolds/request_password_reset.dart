import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:courses_in_english/ui/scaffolds/password_reset.dart';
import 'package:flutter/material.dart';

typedef void OnPressed();
typedef void OnChanged(String input);

class RequestPasswordReset extends StatelessWidget {
  static final String skipRequestText =
      "Already have a Reset-Code? Click here!";
  static final String requestResetText = "Request Reset Code";
  static final String wrongFormatSnack =
      "Please Enter a Valid E-Mail in the Format: abc@d.e";
  static final String descriptionText =
      "A reset Code will be sent to the E-Mail address entered below.";

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
              inputFieldAndDescription((input) {
                userEmail = input;
              }),
              new Expanded(
                child: new Column(
                  children: <Widget>[
                    requestButton(() {
                      if (userEmail != null &&
                          userEmail.contains("@") &&
                          userEmail.contains(".")) {
                        new Session().requestPasswordReset(userEmail);
                        //TODO show message if email is in database or not.
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return new AlertDialog(
                                title: new Text(
                                    "Check your Inbox & Spam for our Mail."),
                                actions: <Widget>[
                                  new FlatButton(onPressed: ((){
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                          new PasswordReset(userEmail)),
                                    );
                                  }), child: new Text("Continue"))
                                ],
                              );
                            });
                      } else {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                              content: new Text(
                                wrongFormatSnack,
                                textAlign: TextAlign.center,
                              ),
                              duration: new Duration(seconds: 3),
                            ));
                      }
                    }, context),
                    skipRequestButton((() {
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new PasswordReset(userEmail)),
                      );
                    }), context),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          );
        }));
  }

  Widget inputFieldAndDescription(OnChanged onChanged) {
    return new Expanded(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Text(
              descriptionText,
              style: TextStyle(fontSize: 18.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 40.0),
          ),
          new Container(
            child: new TextField(
              decoration: new InputDecoration(labelText: "Input E-Mail:"),
              onChanged: onChanged,
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40.0),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }

  Widget requestButton(OnPressed onPressed, BuildContext context) {
    return new Container(
      child: new RoundedButton(
        onPressed: onPressed,
        color: Colors.black,
        text: new Text(
          requestResetText,
          style: new TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      ),
      alignment: Alignment.center,
    );
  }

  Widget skipRequestButton(OnPressed onPressed, BuildContext context) {
    return new Container(
      child: new FlatButton(
        onPressed: onPressed,
        child: new Text(
          skipRequestText,
          style: TextStyle(
            color: Colors.grey.withOpacity(0.8),
          ),
        ),
      ),
      margin: const EdgeInsets.only(top: 30.0),
    );
  }
}
