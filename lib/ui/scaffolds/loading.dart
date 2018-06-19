import 'package:courses_in_english/controller/content_controller.dart';
import 'package:courses_in_english/ui/scaffolds/bnb_home.dart';
import 'package:flutter/material.dart';

class LoadingScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    new ContentController().getContent().then(
          (content) => Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                  builder: (context) => new HomeScaffold(content),
                ),
              ),
        );
    return new Scaffold(
      body: new Center(
        child: new Image(image: new AssetImage("res/anim_cow.gif")),
      ),
    );
  }
}
