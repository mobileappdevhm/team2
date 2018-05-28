import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          child: new Row(
            children: <Widget>[
              new Text('Hi'),
              new Switch(value: true, onChanged: (bool status) {})
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          padding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
        ),
        new Row(
          children: <Widget>[
            new LineSeparator(title: 'Other Settings')
          ],
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
