import 'package:courses_in_english/controller/cie_controller.dart';
import 'package:flutter/material.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/model/department/department.dart';

class CieListEntry extends StatelessWidget {
  static const Color GREEN = const Color(0xFF83D183);
  static const Color YELLOW = const Color(0xFFFFCC66);
  static const Color RED = const Color(0xFFFF3366);
  static const Color HEART = const Color(0xFFFFA1A1);

  final Cie cie;
  final Department department;

  CieListEntry(this.cie, this.department);

  void _toggle() async => new CieController().removeCie(cie);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double vw = size.width / 100;

    return new Material(
      child: new InkWell(
          onTap: null,
          child: new Container(
              child: new Column(children: <Widget>[
                new Row(children: <Widget>[
                  new Expanded(
                      child: new Text(cie.name,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: new TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 1.2)),
                  new Container(
                    child: new IconButton(
                        padding: new EdgeInsets.all(0.0),
                        icon: new Icon(Icons.clear),
                        iconSize: 9 * vw,
                        color: Colors.black12,
                        onPressed: () {
                          _toggle();
                        }),
                  ),
                ]),
                new Row(children: <Widget>[
                  new Expanded(
                      child: new Container(
                          child: new Text(cie.lecturerName,
                              style: new TextStyle(
                                  color: const Color(0xFF707070),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0)),
                          padding: new EdgeInsets.only(bottom: vw * 2.2))),
                ]),
                new Row(children: <Widget>[
                  new Expanded(
                    child: new Align(
                      child: new Text(
                        "Department " + cie.department.toString(),
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: department != null
                              ? new Color(department.color)
                              : Colors.grey,
                        ),
                        textScaleFactor: 1.2,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  new Container(
                    child: new Text("ECTS: " + cie.ects.toString()),
                  )
                ])
              ]),
              decoration: new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(
                          color: new Color(0xFFDDDDDD), width: 1.0))),
              padding: new EdgeInsets.only(
                  left: 3 * vw, top: 0.1 * vw, right: 3 * vw, bottom: 1 * vw))),
    );
  }
}
