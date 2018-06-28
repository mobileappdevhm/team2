import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:flutter/material.dart';

class AddCustomCourseScaffold extends StatefulWidget {
  AddCustomCourseScaffold({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddCieCustomCourseState createState() => new _AddCieCustomCourseState();
}

class _AddCieCustomCourseState extends State<AddCustomCourseScaffold> {
  final formKey = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();
  final formKey4 = new GlobalKey<FormState>();
  List<Widget> tl = [];
  String tempName = "";
  String tempLecturerName = "";
  double tempEcts = -1.0;
  int tempDepartment = -1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return loggedInView(width);
  }

  Scaffold loggedInView(double width) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text("Add C.I.E."),
      ),
      body: new ListView(
        children: <Widget>[
          new Column(
            children: tl,
          ),
          tempNameField(null),
          tempLecturerNameField(null),
          tempEctsField(null),
          tempDepartmentField(null),
          new Padding(
            padding: new EdgeInsets.all(8.0),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.all(8.0),
              ),
              new RawMaterialButton(
                constraints: new BoxConstraints(
                    minWidth: 180.0,
                    minHeight: 48.0,
                    maxWidth: width - 30,
                    maxHeight: 50.0),
                onPressed: _onFloatingActionButtonPressed,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(100000.0)),
                fillColor: Colors.red,
                child: new Text(
                  "Add",
                  style: new TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.all(8.0),
              ),
            ],
          ),
          new Padding(
            padding: new EdgeInsets.all(8.0),
          ),
        ],
//        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }

  Container tempNameField(double width) {
    TextEditingController controller = new TextEditingController();
    controller.addListener(() {
      tempName = controller.text.toString();
    });
    return new Container(
      child: new Form(
        key: formKey,
        child: new TextFormField(
          onSaved: (val) => tempName = val,
          decoration: new InputDecoration(
              labelText: "Input Name",
              labelStyle: new TextStyle(fontSize: 18.0)),
        ),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      width: width,
    );
  }

  Container tempLecturerNameField(double width) {
    TextEditingController controller = new TextEditingController();
    controller.addListener(() {
      tempLecturerName = controller.text.toString();
    });
    return new Container(
      child: new Form(
        key: formKey2,
        child: new TextFormField(
          onSaved: (val) => tempLecturerName = val,
          decoration: new InputDecoration(
              labelText: "Input Lecturer Name",
              labelStyle: new TextStyle(fontSize: 18.0)),
        ),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      width: width,
    );
  }

  Container tempEctsField(double width) {
    TextEditingController controller = new TextEditingController();
    controller.addListener(() {
      tempEcts = tryCatchDub(controller.text.toString());
    });
    return new Container(
      child: new Form(
        key: formKey3,
        child: new TextFormField(
          onSaved: (val) => tempEcts = tryCatchDub(val),
          decoration: new InputDecoration(
              labelText: "Input Ects (Decimal)",
              labelStyle: new TextStyle(fontSize: 18.0)),
        ),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      width: width,
    );
  }

  Container tempDepartmentField(double width) {
    TextEditingController controller = new TextEditingController();
    controller.addListener(() {
      tempDepartment = tryCatchInt(controller.text.toString());
    });
    return new Container(
      child: new Form(
        key: formKey4,
        child: new TextFormField(
          onSaved: (val) => tempDepartment = tryCatchInt(val),
          decoration: new InputDecoration(
              labelText: "Input Department (Integer)",
              labelStyle: new TextStyle(fontSize: 18.0)),
        ),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      width: width,
    );
  }

  void _onFloatingActionButtonPressed() async {
    final form = formKey.currentState;
    final form2 = formKey2.currentState;
    final form3 = formKey3.currentState;
    final form4 = formKey4.currentState;

    setState(() {
      form.save();
      form2.save();
      form3.save();
      form4.save();
    });
    tl.clear();
    if (tempEcts == -1 ||
        tempDepartment == -1 ||
        tempName == "" ||
        tempLecturerName == "") {
      showMessage("Fields must be filled with proper types");
      return;
    }
    new Injector()
        .cieController
        .enterCie(new Cie(tempName, tempDepartment, tempLecturerName, tempEcts))
        .then((result) {
      if (result != 0) {
        showMessage("Error: Could not add \"$tempName\"");
      } else {
        showMessage("Succesfully added \"$tempName\"");
      }
    });
  }

  void showMessage(String msg) {
    setState(() {
      tl.add(new Padding(padding: new EdgeInsets.all(8.0)));
      tl.add(new Container(
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(100000.0),
            color: Colors.red),
        child: new Text(
          msg,
          style: new TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ));
    });
  }

  int tryCatchInt(String stringToInt) {
    int tempInt = -1;
    try {
      tempInt = int.parse(stringToInt);
    } catch (e) {
      tempInt = -1;
    }
    return tempInt;
  }

  double tryCatchDub(String stringToInt) {
    double tempInt = -1.0;
    try {
      tempInt = double.parse(stringToInt);
    } catch (e) {
      tempInt = -1.0;
    }
    return tempInt;
  }
}
