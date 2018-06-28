import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
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
  final formKey5 = new GlobalKey<FormState>();
  List<Widget> tl = [];
  String tempName = "";
  String tempLecturerName = "";
  String tempRoom = "";
  String tempDay = "";
  String tempTime = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return loggedInView(width);
  }

  Scaffold loggedInView(double width) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text("Add Custom Course"),
      ),
      body: new ListView(
        children: <Widget>[
          new Column(
            children: tl,
          ),
          tempNameField(null),
          tempLecturerNameField(null),
          tempRoomField(null),
          tempDayField(null),
          tempTimeField(null),
          new Padding(
            padding: new EdgeInsets.all(8.0),
          ),
        ],
//        mainAxisAlignment: MainAxisAlignment.start,
      ),
      floatingActionButton: new FloatingActionButton(onPressed: _onFloatingActionButtonPressed, child: Icon(Icons.save), heroTag: "addCourse",),
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

  Container tempRoomField(double width) {
    TextEditingController controller = new TextEditingController();
    controller.addListener(() {
      tempRoom = controller.text.toString();
    });
    return new Container(
      child: new Form(
        key: formKey3,
        child: new TextFormField(
          onSaved: (val) => tempRoom = val,
          decoration: new InputDecoration(
              labelText: "Input Room",
              labelStyle: new TextStyle(fontSize: 18.0)),
        ),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      width: width,
    );
  }

  Container tempDayField(double width) {
    TextEditingController controller = new TextEditingController();
    controller.addListener(() {
      tempDay = controller.text.toString();
    });
    return new Container(
      child: new Form(
        key: formKey4,
        child: new TextFormField(
          onSaved: (val) => tempDay = val,
          decoration: new InputDecoration(
              labelText: "Input Day",
              labelStyle: new TextStyle(fontSize: 18.0)),
        ),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      width: width,
    );
  }

  Container tempTimeField(double width) {
    TextEditingController controller = new TextEditingController();
    controller.addListener(() {
      tempTime = controller.text.toString();
    });
    return new Container(
      child: new Form(
        key: formKey5,
        child: new TextFormField(
          onSaved: (val) => tempTime = val,
          decoration: new InputDecoration(
              labelText: "Input Time as HH:MM",
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
    final form5 = formKey5.currentState;

    setState(() {
      form.save();
      form2.save();
      form3.save();
      form4.save();
      form5.save();
    });
    tl.clear();
    // TODO waiting on the timetablecontroller
    if (tempName == "" ||
        tempLecturerName == "" ||
        tempRoom == "") {
      showMessage("Fields must be filled with proper types");
      return;
    }
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
}
