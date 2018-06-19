import 'package:courses_in_english/controller/cie_controller.dart';
import 'package:courses_in_english/controller/session_controller.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/ui/basic_components/cie_list_entry.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/scaffolds/add_cie.dart';
import 'package:flutter/material.dart';

// TODO handle null department
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
class CieScreenState extends State<CieScreen> implements CieListObserver {
  List<Cie> cies = [];
  String userName = "N/a";
  double totalEcts = 0.0;

  CieScreenState() {
    new CieController().addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (!new SessionController().isLoggedIn) {
      return notLoggedInView();
    } else {
      return loggedInView(width);
    }
  }

  ListView notLoggedInView() {
    return new ListView(
      children: <Widget>[
        new Padding(padding: new EdgeInsets.all(4.0)),
        new Row(
          children: <Widget>[
            new LineSeparator(
              title: 'User Profile',
              isBold: true,
            )
          ],
        ),
        new Padding(padding: new EdgeInsets.all(6.0)),
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[new Text("Guest Users don't have profiles")],
        )
      ],
    );
  }

  Widget loggedInView(double width) {
    try {
      userName = new SessionController().user.lastName;
    } catch (e) {}
    return new Container(
      constraints: new BoxConstraints.expand(),
      alignment: Alignment.center,
      child: new Column(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Padding(padding: new EdgeInsets.all(12.0)),
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
                      new Row(
                        children: <Widget>[
                          new Text(
                            "Logged in as " + userName,
                            style: new TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new RawMaterialButton(
                        onPressed: null,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100000.0)),
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
          new Expanded(
            child: new ListView(
              children: <Widget>[
                new Column(
                  children: mapCiesToWidgets(cies),
                ),
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
                      onPressed: _addCie,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100000.0)),
                      fillColor: Colors.red,
                      child: new Text(
                        "Add CIE",
                        style:
                            new TextStyle(fontSize: 18.0, color: Colors.white),
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
            ),
          ),
        ],
      ),
    );
  }

  void _addCie() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new AddCieScaffold()),
    );
  }

  List<Widget> mapCiesToWidgets(List<Cie> cies) =>
      cies.map((cie) => new CieListEntry(cie, null)).toList();

  @override
  void onCieListUpdate(List<Cie> cies) => setState(() {
        this.cies = cies;
        this.totalEcts =
            cies.length > 0 // There must be at least one element for reducing
                ? cies.map((cie) => cie.ects).reduce((a, b) => a + b)
                : 0.0;
      });
}
