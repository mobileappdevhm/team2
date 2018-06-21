import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GdprNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Gdpr Notice"),),
        body: new Container(
          child: new SingleChildScrollView(
            child: new Text(
              "1 Description that is too long in text format(Here Data is coming from API) jdlksaf j klkjjflkdsjfkddfdfsdfds " +
                  "2 Description that is too long in text format(Here Data is coming from API) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d " +
                  "3 Description that is too long in text format(Here Data is coming from API)  adfsfdsfdfsdfdsf   dsf dfd fds fs" +
                  "4 Description that is too long in text format(Here Data is coming from API) dsaf dsafdfdfsd dfdsfsda fdas dsad" +
                  "5 Description that is too long in text format(Here Data is coming from API) dsfdsfd fdsfds fds fdsf dsfds fds " +
                  "6 Description that is too long in text format(Here Data is coming from API) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf" +
                  "7 Description that is too long in text format(Here Data is coming from API) df dsfdsfdsfdsfds df dsfds fds fsd" +
                  "8 Description that is too long in text format(Here Data is coming from API)" +
                  "9 Description that is too long in text format(Here Data is coming from API)" +
                  "10 Description that is too long in text format(Here Data is coming from API)",
              style: new TextStyle(
                fontSize: 10.0,
                color: Colors.black,
              ),
            ),
          ),
          padding: new EdgeInsets.all(12.0),
        ), 
    );
  }
}
