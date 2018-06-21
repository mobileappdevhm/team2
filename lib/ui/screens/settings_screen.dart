import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/model/user/user_settings.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<bool> _states = [false, true];
  List<String> _info = [
    "This will stop automatic syncing of your files to our server",
    "This will allow us to collect data on what features you use most to improve the app",
    "This button backs up your favorites on our server",
    "This button will take the favorites you have previously pushed to our servers and import them to your favorites tab",
    "This button will pull the courses that you have gotten into with the lottery system and out them into your favorites tab",
    "Continuing will delete all user data from your local device and close the application, are you sure you want to continue?"
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (!new Injector().sessionController.isLoggedIn) {
      return notLoggedInView();
    } else {
      return loggedInView(width);
    }
  }

  ListView notLoggedInView() {
    return new ListView(
      children: <Widget>[
        new Padding(padding: new EdgeInsets.all(4.0)),
        _newElement([
          new LineSeparator(
            title: 'General Settings',
            isBold: true,
          )
        ]),
        new Padding(padding: new EdgeInsets.all(6.0)),
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[new Text("Guest Users can't save settings")],
        )
      ],
    );
  }

  ListView loggedInView(double width) {
    return new ListView(
      children: <Widget>[
        new Padding(padding: new EdgeInsets.all(4.0)),
        _newElement([
          new LineSeparator(
            title: 'General Settings',
            isBold: true,
          )
        ]),
        _newElement([
          new Text(
            'Offline mode',
            style: new TextStyle(fontSize: 16.0),
          ),
          IconButton(
            onPressed: () => _showAlert(0),
            icon: new Icon(
              Icons.info,
              size: 28.0,
            ),
          ),
          new Switch(
              value: _states[0],
              onChanged: (bool onChanged) => _doClick("offlineMode", onChanged))
        ]),
        _newElement([
          new Text(
            'Feedback mode',
            style: new TextStyle(fontSize: 16.0),
          ),
          IconButton(
            onPressed: () => _showAlert(1),
            icon: new Icon(
              Icons.info,
              size: 28.0,
            ),
          ),
          new Switch(
              value: _states[1],
              onChanged: (bool onChanged) =>
                  _doClick("feedbackMode", onChanged))
        ]),
        _newElement([
          new LineSeparator(
            title: 'Sync Options',
            isBold: true,
          )
        ]),
        new Padding(padding: new EdgeInsets.all(6.0)),
        _newWideElement([
          RoundedButton(
              minwidth: 160.0,
              text: new Text(
                "Push favorites",
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              onPressed: () => _showDeleteAlert(5)),
          IconButton(
            onPressed: () => _showAlert(2),
            icon: new Icon(
              Icons.info,
              size: 28.0,
            ),
          ),
        ]),
        new Padding(padding: new EdgeInsets.all(6.0)),
        _newWideElement([
          new RoundedButton(
            minwidth: 160.0,
            text: new Text(
              "Sync favorites",
              style: new TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            onPressed: () => _showDeleteAlert(5),
          ),
          IconButton(
            onPressed: () => _showAlert(3),
            icon: new Icon(
              Icons.info,
              size: 28.0,
            ),
          ),
        ]),
        new Padding(padding: new EdgeInsets.all(6.0)),
        _newWideElement([
          RoundedButton(
              minwidth: 160.0,
              text: new Text(
                "Sync Lottery",
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              onPressed: () => _showDeleteAlert(5)),
          IconButton(
            onPressed: () => _showAlert(4),
            icon: new Icon(
              Icons.info,
              size: 28.0,
            ),
          ),
        ]),
        new Padding(padding: new EdgeInsets.all(6.0)),
        _newWideElement([
          new RoundedButton(
              text: new Text(
                "Delete application data",
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              onPressed: () => _showDeleteAlert(5)),
        ]),
      ],
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  Widget _newElement(var children) {
    if (children[0] is LineSeparator) {
      return new Row(
        children: children,
      );
    } else {
      return Container(
        child: Row(
          children: children,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
      );
    }
  }

  Widget _newWideElement(var children) {
    if (children[0] is LineSeparator) {
      return new Row(
        children: children,
      );
    } else {
      return Container(
        child: Row(
          children: children,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      );
    }
  }

  void _doClick(String toggle, var value) {
    setState(() {
      switch (toggle) {
        case "offlineMode":
          _states[0] = value;
          return;
        case "feedbackMode":
          _states[1] = value;
          return;
      }
      new Injector().settingsController.setSettings(
          new UserSettings(offlineMode: _states[0], feedbackMode: _states[1]));
    });
  }

  void _showAlert(int index) {
    if (_info[index] == null) return;

    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
        _info[index],
        style: new TextStyle(fontSize: 16.0),
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () => Navigator.pop(context), child: new Text("close"))
      ],
    );

    showDialog(context: context, builder: (context) => alertDialog);
  }

  void _showDeleteAlert(int index) {
//    int length = _info.length;
    if (_info[index] == null) return;

    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
        _info[index],
        style: new TextStyle(fontSize: 16.0),
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () => Navigator.pop(context),
            child: new Text("No, Cancel")),
        new FlatButton(
            onPressed: () => clearApp(), child: new Text("Yes, Delete"))
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  @override
  void initState() {
    super.initState();
    initSettings();
  }

  void initSettings() async {
    /* TODO Use settingscontroller
    Session s = new Session();
    if (s.settings != null) {
      _states[0] = s.settings.offlineMode;
      _states[1] = s.settings.feedbackMode;
      setState(() {});
    }
    */
  }

  // TODO Use settingscontroller
  void clearApp() => throw new UnimplementedError();
}
