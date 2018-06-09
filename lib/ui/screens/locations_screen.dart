import 'package:courses_in_english/model/campus/campus.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Location screen showing the different campuses of the munich university of applied sciences.
class LocationScreen extends StatefulWidget {
  final List<Campus> campuses;

  LocationScreen(this.campuses);

  @override
  State<StatefulWidget> createState() => new _LocationState(this.campuses);
}

class _LocationState extends State<LocationScreen> {
  /// List of campuses displayed.
  List<Campus> _campuses;

  _LocationState(this._campuses);

  @override
  Widget build(BuildContext context) {
    if (_campuses != null) {
      return new ListView.builder(
        padding: new EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index) {
          double width = MediaQuery.of(context).size.width;

          Campus campus = _campuses[index];
          return new Container(
              child: new GestureDetector(
                  onTap: () {
                    goToMaps(
                        'https://www.google.com/maps/place/University+of+Applied+Science+Munich/@48.1542311,11.5570298,17.62z/data=!4m8!1m2!2m1!1shochschule+m%C3%BCnchen!3m4!1s0x0:0x18bfe7f8741350da!8m2!3d48.1548088!4d11.5561071');
                    //goToMaps(campus.mapUrl); TODO: Uncomment and delete line above
                  },
                  child: new Stack(
                    children: <Widget>[
                      new Image.asset(
                        campus.image,
                        height: width / 2,
                        width: width,
                        fit: BoxFit.fitWidth,
                      ),
                      new Container(
                        child: new Text(
                          campus.name,
                          style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                          ),
                          textScaleFactor: 3.0,
                        ),
                        color: new Color(0xCCFFFFFF),
                      )
                    ],
                    fit: StackFit.loose,
                    alignment: Alignment.center,
                  )),
              padding: new EdgeInsets.all(10.0));
        },
        itemCount: _campuses.length,
      );
    } else {
      return new Center(
          child: new Image(image: new AssetImage("res/anim_cow.gif")));
    }
  }

  goToMaps(String mapUrl) async {
    if (await canLaunch(mapUrl)) {
      launch(mapUrl);
    } else {
      throw 'Could not launch $mapUrl';
    }
  }
}
