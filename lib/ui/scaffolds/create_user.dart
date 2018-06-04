import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/user/user.dart';
import 'package:courses_in_english/ui/basic_components/my_dropdown_button.dart';
import 'package:courses_in_english/ui/basic_components/scenery_widget.dart';
import 'package:courses_in_english/ui/scaffolds/bnb_home.dart';
import 'package:flutter/material.dart';

typedef void SaveTo(String saveTo);

class CreateUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  List<Department> departments = new List<Department>();
  User newUser;
  Department userDepartment;
  String firstName;
  String lastName;
  String userName;
  String userDepartmentName;

  @override
  void initState() {
    new Data().departmentProvider.getDepartments().then((deps) {
      setState(() {
        departments.addAll(deps);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode node1 = new FocusNode();
    FocusNode node2 = new FocusNode();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Courses in English",
          style:
              new TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
        ),
        flexibleSpace: new SceneryWidget(false),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          inputRow("Username", new FocusNode(), node1, (String toSave) {
            this.userName = toSave;
          }),
          inputRow("First Name", node1, node2, (String toSave) {
            this.firstName = toSave;
          }),
          inputRow("Last Name", node2, new FocusNode(), (String toSave) {
            this.lastName = toSave;
          }),
          departmentSelector(),
          submitButton(),
        ],
      ),
    );
  }

  Expanded inputRow(
      String label, FocusNode ownNode, FocusNode nextNode, saveTo) {
    TextEditingController controller = new TextEditingController();
    controller.addListener(() {
      saveTo(controller.text.toString());
    });
    return new Expanded(
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              child: new TextFormField(
                decoration: new InputDecoration(labelText: label),
                onFieldSubmitted: (String input) {
                  saveTo(input);
                  FocusScope.of(context).requestFocus(nextNode);
                },
                focusNode: ownNode,
                //controller: controller,
              ),
              margin: new EdgeInsets.symmetric(horizontal: 30.0),
              alignment: Alignment.centerLeft,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Expanded departmentSelector() {
    return new Expanded(
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              child: new MyDropdownButton(
                hint: new SingleChildScrollView(
                  child: new Text(
                    "Select Department",
                    overflow: TextOverflow.fade,
                  ),
                  scrollDirection: Axis.horizontal,
                ),
                value: userDepartmentName,
                items: departments.map((Department department) {
                  return new MyDropdownMenuItem(
                    child: new SingleChildScrollView(
                      child: new Text(
                        department.name,
                        overflow: TextOverflow.fade,
                      ),
                      scrollDirection: Axis.horizontal,
                    ),
                    value: department.name,
                  );
                }).toList(),
                onChanged: ((department) {
                  setState(() {
                    this.userDepartmentName = department;
                  });
                }),
              ),
              margin: new EdgeInsets.symmetric(horizontal: 30.0),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }

  Expanded submitButton() {
    return new Expanded(
      child: new Row(
        children: <Widget>[
          new RaisedButton(
            onPressed: (() {
              for (Department department in departments) {
                if (userDepartmentName == department.name) {
                  userDepartment = department;
                }
              }

              if (userName != null &&
                  firstName != null &&
                  lastName != null &&
                  userDepartment != null) {
                new Data().userProvider.createUser(
                    userName, firstName, lastName, userDepartment.number);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new HomeScaffold()),
                );
              }
            }),
            child: new Text("Save"),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
