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
        _newElement([
          new LineSeparator(
            title: 'General Settings',
            isBold: true,
          )
        ]),
        _newElement([
          new LineSeparator(
            title: 'Synchronisation Settings',
          )
        ]),
        _newElement([
          Text('Enable automatic sync'),
          Switch(value: false, onChanged: (bool changed) {}),
        ]),
        _newElement([
          new Text('Offline mode'),
          new Switch(value: false, onChanged: (bool changed) {})
        ]),
        _newElement([
          new LineSeparator(
            title: 'Secret Settings ;)',
          )
        ]),
        _newElement([
          new Text('Ficke deine Mutter'),
          new Switch(value: true, onChanged: (bool changed) {})
        ]),
        _newElement([
          new Text('Enable Secret 1'),
          new Switch(value: false, onChanged: (bool changed) {})
        ]),
        _newElement([
          new LineSeparator(
            title: 'UI Settings',
            isBold: true,
          )
        ]),
        _newElement([
          new Text('Use alternative layout'),
          new Switch(value: false, onChanged: (bool changed) {})
        ]),
        _newElement([
          new LineSeparator(
            title: 'Language Settings',
            isBold: true,
          )
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
}
