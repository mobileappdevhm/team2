import 'package:courses_in_english/connect/dataprovider/cie/mock/sqlite_cie_provider.dart';
import 'package:courses_in_english/connect/dataprovider/department/sqlite_department_provider.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/ui/basic_components/cie_list_entry.dart';
import 'package:courses_in_english/ui/screens/add_cie_screen.dart';
import 'package:flutter/material.dart';

class CieScreen extends StatefulWidget {
  CieScreen({Key key, this.title}) : super(key: key);

  static const String routeName = "/CieScreen";

  final String title;

  @override
  CieScreenState createState() => new CieScreenState();
}

/// // 1. After the page has been created, register it with the app routes
/// routes: <String, WidgetBuilder>{
///   CieScreen.routeName: (BuildContext context) => new CieScreen(title: "CieScreen"),
/// },
///
/// // 2. Then this could be used to navigate to the page.
/// Navigator.pushNamed(context, CieScreen.routeName);
///

class CieScreenState extends State<CieScreen> {
  List<Widget> cieWidgets = [];
  String userName = "TempUser";
  double totalEcts = 0.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "CIE Profile",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.add), onPressed: _addCie)
        ],
      ),
      body: new Container(
        constraints: new BoxConstraints.expand(),
        alignment: Alignment.center,
        child: new ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          Icons.account_circle,
                          size: 70.0,
                        )
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(8.0),
                        ),
                        new Row(
                          children: <Widget>[
                            new Text(
                              "Logged in as " + userName,
                              style: new TextStyle(fontSize: 18.0),
                            ),
//                            new Padding(
//                              padding: new EdgeInsets.all(4.0),
//                            ),
                          ],
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(8.0),
                        ),
                        new RawMaterialButton(
                          onPressed: null,
                          shape: new RoundedRectangleBorder(
                              borderRadius:
                                  new BorderRadius.circular(100000.0)),
                          fillColor: Colors.red,
                          child: new Text(
                            "Logout",
                            style: new TextStyle(
                                fontSize: 16.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                new Padding(
                  padding: new EdgeInsets.all(10.0),
                ),
                new Text("CIE Progress: " + totalEcts.toString() + " / 50",
                    style: new TextStyle(fontSize: 18.0)),
                new Container(
                  padding: new EdgeInsets.all(32.0),
                  child: new LinearProgressIndicator(
                    value: totalEcts / 50.0,
                  ),
                ),
              ],
            ),
            new Divider(
              color: Colors.black,
            ),
//            new ListView(
//              children: <Widget>[
            new Column(
              children: cieWidgets,
            )
//              ],

//            ),
          ],
        ),
      ),
    );
  }

  void courseItems() async {
    List<Widget> tempWidgets = new List<Widget>();
    SqliteCieProvider sqlitecieprovider = new SqliteCieProvider();
    SqliteDepartmentProvider sqlitedepartmentprovider =
        new SqliteDepartmentProvider();

//    List<Department> departments = [];
//    departments.add(new Department(1, "Architecture", const Color(0xFF014085)));
//    departments.add(new Department(2, "Civil Engineering", const Color(0xFF008db8)));
//    departments.add(new Department(3, "Mechanical, Automotive and Aeronautical Engineering", const Color(0xFF018bc9)));
//    departments.add(new Department(4, "Electrical Engineering and Information Technology", const Color(0xFF0198ab)));
//    departments.add(new Department(5, "Building Services Engineering, Paper and Packaging Technology and Print and Media Technology", const Color(0xFF016fb2)));
//    departments.add(new Department(6, "Applied Sciences and Mechatronics", const Color(0xFF04539d)));
//    departments.add(new Department(7, "Computer Science and Mathematics", const Color(0xFF029fd0)));
//    departments.add(new Department(8, "Geoinformatics", const Color(0xFF018a8a)));
//    departments.add(new Department(9, "Engineering and Management", const Color(0xFF018e62)));
//    departments.add(new Department(10, "Business Administration", const Color(0xFF028d7c)));
//    departments.add(new Department(11, "Applied Social Sciences", const Color(0xFFed7406)));
//    departments.add(new Department(12, "Design", const Color(0xFF0f3647)));
//    departments.add(new Department(13, "General and Interdisciplinary Studies", const Color(0xFFbf0179)));
//    departments.add(new Department(14, "Tourism", const Color(0xFFa41948)));
//    await sqlitedepartmentprovider.putDepartments(departments);

//    List<Department> d = await sqlitedepartmentprovider.getDepartments();

    List<Cie> cieList = await sqlitecieprovider.getCies();

    double tempTotalEcts = 0.0;

    for (Cie cie in cieList) {
      Department department =
          await sqlitedepartmentprovider.getDepartmentByNumber(cie.department);
      tempWidgets
          .add(new CieListEntry(cie, department, onPressedButton: _setMyState));

      ///TODO: fix the null
      tempTotalEcts += cie.ects;
    }

    cieWidgets = tempWidgets;
    totalEcts = tempTotalEcts;

    setState(() {});
  }

  void _addCie() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new AddCieScreen(
                onPressedButton: _setMyState,
              )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    courseItems();
  }

  void _setMyState() {
    courseItems();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
