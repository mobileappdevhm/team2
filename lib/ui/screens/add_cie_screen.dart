import 'package:courses_in_english/connect/dataprovider/cie/mock/sqlite_cie_provider.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:flutter/material.dart';

class AddCieScreen extends StatefulWidget {
  AddCieScreen({Key key, this.title, this.onPressedButton}) : super(key: key);

  static const String routeName = "/CieScreen";
  final VoidCallback onPressedButton;
  final String title;

  @override
  _AddCieScreenState createState() => new _AddCieScreenState();
}

class _AddCieScreenState extends State<AddCieScreen> {
  final formKey = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();
  final formKey4 = new GlobalKey<FormState>();
  List<Widget> tl = [];
  String tempName = "";
  String tempLecturerName = "";
  String tempDescription = "";
  double tempEcts = -1.0;
  int tempDepartment = -1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text("Add C.I.E."),
      ),
      body: new Column(
        children: <Widget>[
          new Column(
            children: tl,
          ),
          tempNameField(),
          tempLecturerNameField(),
          tempEctsField(),
          tempDepartmentField(),
          new Padding(
            padding: new EdgeInsets.all(8.0),
          ),
          new RawMaterialButton(
            constraints: new BoxConstraints(minWidth: 180.0, minHeight: 48.0),
            onPressed: _onFloatingActionButtonPressed,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(100000.0)),
            fillColor: Colors.red,
            child: new Text(
              "Add CIE",
              style: new TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.all(8.0),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }

  Container tempNameField() {
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
              labelText: " Input Name",
              labelStyle: new TextStyle(fontSize: 18.0)),
        ),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    );
  }

  Container tempLecturerNameField() {
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
              labelText: " Input Lecturer Name",
              labelStyle: new TextStyle(fontSize: 18.0)),
        ),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    );
  }

  Container tempEctsField() {
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
              labelText: " Input Ects (Decimal)",
              labelStyle: new TextStyle(fontSize: 18.0)),
        ),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    );
  }

  Container tempDepartmentField() {
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
              labelText: " Input Department (Integer)",
              labelStyle: new TextStyle(fontSize: 18.0)),
        ),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
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
      tl.add(new Padding(padding: new EdgeInsets.all(8.0)));
      tl.add(new Container(
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(100000.0),
            color: Colors.red),
        child: new Text(
          "Feilds must be filled with proper types",
          style: new TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ));
      return;
    }

    SqliteCieProvider sqlitecieprovider = new SqliteCieProvider();
    int result = await sqlitecieprovider.putCie(new Cie(
        tempName, tempDepartment, tempLecturerName, tempEcts, tempDescription));

    if (result != 0) {
      tl.add(new Padding(padding: new EdgeInsets.all(8.0)));
      tl.add(new Container(
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(100000.0),
            color: Colors.red),
        child: new Text(
          "Error: Could not add \"" + tempName + "\"",
          style: new TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ));
      setState(() {});
      return;
    } else {
      tl.add(new Padding(padding: new EdgeInsets.all(8.0)));
      tl.add(new Container(
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(100000.0),
            color: Colors.red),
        child: new Text(
          "Succesfully added \"" + tempName + "\"",
          style: new TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ));
    }

    setState(() {});
    widget.onPressedButton();
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
