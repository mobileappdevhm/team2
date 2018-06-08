import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:flutter/material.dart';
import 'package:courses_in_english/ui/screens/cie_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<bool> _states = [false, false, false, true];

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        _newElement([
          new LineSeparator(
            title: 'General Settings',
            isBold: true,
          )
        ]),
        new RawMaterialButton(
          constraints: new BoxConstraints(minWidth: 180.0, minHeight: 48.0),
          onPressed: _profilePage,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(100000.0)),
          fillColor: Colors.red,
          child: new Text(
            "Profile",
            style: new TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
        _newElement([
          new LineSeparator(
            title: 'Synchronisation Settings',
          )
        ]),
        _newElement([
          Text('Enable automatic sync'),
          Switch(
              value: _states[0],
              onChanged: (bool onChanged) => _doClick("autoSync", onChanged)),
        ]),
        _newElement([
          new Text('Offline mode'),
          new Switch(
              value: _states[1],
              onChanged: (bool onChanged) => _doClick("offlineMode", onChanged))
        ]),
        _newElement([
          new LineSeparator(
            title: 'UI Settings',
            isBold: true,
          )
        ]),
        _newElement([
          new Text('Use alternative layout'),
          new Switch(
              value: _states[2],
              onChanged: (bool onChanged) => _doClick("altLayout", onChanged))
        ]),
        _newElement([
          new LineSeparator(
            title: 'Language Settings',
            isBold: true,
          )
        ]),
        _newElement([
          new LineSeparator(
            title: 'Secret Settings ;)',
          )
        ]),
        _newElement([
          new Text('Secret 1'),
          new Switch(
              value: _states[3],
              onChanged: (bool onChanged) => _doClick("secret1", onChanged))
        ]),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

  Data _data = new Data();

  void _doClick(String toggle, var value) {
    setState(() {
      switch (toggle) {
        case "autoSync":
          _data.settingsProvider.getCurrentSettings().autoSync = value;
          _states[0] = value;
          return;
        case "offlineMode":
          _data.settingsProvider.getCurrentSettings().offlineMode = value;
          _states[1] = value;
          return;
        case "altLayout":
          _data.settingsProvider.getCurrentSettings().usesDrawer = value;
          _states[2] = value;
          return;
        case "language":
          _data.settingsProvider.getCurrentSettings().language = value;
          return;
        case "secret1":
          _data.settingsProvider.getCurrentSettings().secret1 = value;
          _states[3] = value;
          return;
      }
    });
  }

  void _profilePage() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new CieScreen()),
    );
  }
}
