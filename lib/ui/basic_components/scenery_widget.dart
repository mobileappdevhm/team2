import 'dart:math';

import 'package:courses_in_english/ui/basic_components/hm_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


class SceneryWrapperWidget extends StatelessWidget {
  final Widget _child;

  SceneryWrapperWidget(this._child);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return new Column(children: <Widget>[new SizedBox(child: new SceneryWidget(true), height: size.height * 0.3, width: size.width), new Expanded(child: _child)]);
  }
}

///
///Scenery widget showing a nice and sound scenery for the user to enjoy themselves.
///
class SceneryWidget extends StatefulWidget {
  final bool _showLogo;

  SceneryWidget(this._showLogo);

  @override
  State<StatefulWidget> createState() => new _SceneryWidgetState(_showLogo);
}

///
///State of the beautiful scenery widget.
///
class _SceneryWidgetState extends State<SceneryWidget> with TickerProviderStateMixin {
  static const int MAX_DURATION = 30;
  static const int MIN_DURATION = 10;

  List<Animation<double>> anims = <Animation<double>>[];
  List<AnimationController> controllers = <AnimationController>[];

  final bool _showLogo;

  _SceneryWidgetState(this._showLogo);

  @override
  void initState() {
    super.initState();

    var rng = new Random();

    controllers.add(new AnimationController(vsync: this, duration: new Duration(seconds: max(MIN_DURATION, rng.nextInt(MAX_DURATION)))));
    anims.add(new Tween(begin: rng.nextDouble(), end: rng.nextDouble()).animate(controllers[0])
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controllers[0].reverse();
        } else if (status == AnimationStatus.dismissed) {
          controllers[0].forward();
        }
      }));

    controllers.add(new AnimationController(vsync: this, duration: new Duration(seconds: max(MIN_DURATION, rng.nextInt(MAX_DURATION)))));
    anims.add(new Tween(begin: rng.nextDouble(), end: rng.nextDouble()).animate(controllers[1])
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controllers[1].reverse();
        } else if (status == AnimationStatus.dismissed) {
          controllers[1].forward();
        }
      }));

    for (var c in controllers) {
      c.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
      double minSize = min(constraints.biggest.width, constraints.biggest.height);

      List<Widget> widgets = <Widget>[];

      widgets.add(new CustomPaint(painter: new _Sky()));
      widgets.add(new Container(child: new CloudWidget(minSize * 0.25, anims[0]), alignment: Alignment.centerLeft));

      if (_showLogo) {
        widgets.add(new HMLogoWidget(scale: 0.6));
      }

      widgets.add(new Container(child: new CloudWidget(minSize * 0.3, anims[1]), alignment: Alignment.centerLeft));

      return new Stack(children: widgets, fit: StackFit.expand);
    });
  }

  dispose() {
    for (var c in controllers) {
      c.dispose();
    }

    super.dispose();
  }
}

class CloudWidget extends StatefulWidget {
  final double _width;
  final Animation<double> _animation;

  CloudWidget(this._width, this._animation);

  @override
  State<StatefulWidget> createState() => new _CloudWidgetState(_width, _animation);
}

class _CloudWidgetState extends State<CloudWidget> {
  double width;
  Animation<double> animation;

  _CloudWidgetState(this.width, this.animation) {
    if (animation != null) {
      animation.addListener(() {
        setState(() {
          // Cause repaint.
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (animation == null) {
      return new CustomPaint(painter: new _Cloud(width));
    } else {
      Size size = MediaQuery.of(context).size;

      return new Container(child: new CustomPaint(painter: new _Cloud(width)), margin: new EdgeInsets.only(left: animation.value * (size.width - width)));
    }
  }
}

///
///Cloud canvas.
///
class _Cloud extends CustomPainter {
  static var cloudPaint = new Paint()..color = Colors.white;

  double width;

  _Cloud(this.width);

  @override
  void paint(Canvas canvas, Size size) {
    Rect s = Offset.zero & size;

    double h = width / 11 * 6;
    double baseW = width / 11 * 8;
    double baseH = h / 2;

    double x = s.left + baseH / 2;
    double y = s.top + width / 11 * 2.5;

    canvas.drawRect(new Rect.fromLTWH(x, y, baseW, baseH), cloudPaint);
    canvas.drawCircle(new Offset(x, y + baseH / 2), baseH / 2, cloudPaint);
    canvas.drawCircle(new Offset(x + baseW, y + baseH / 2), baseH / 2, cloudPaint);

    canvas.drawCircle(new Offset(x + baseW / 4 * 3, y), baseH / 6 * 5, cloudPaint);

    canvas.drawCircle(new Offset(x + baseH, y + baseH / 6), h / 3, cloudPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

///
///Sky canvas.
///
class _Sky extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;

    _drawSky(canvas, rect);
    _drawSun(canvas, rect);
  }

  void _drawSky(Canvas canvas, Rect rect) {
    var skyGradient = new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color.fromRGBO(135, 202, 255, 1.0), Color.fromRGBO(226, 242, 255, 1.0)],
        stops: [0.0, 1.0]);

    canvas.drawRect(
      rect,
      new Paint()..shader = skyGradient.createShader(rect),
    );
  }

  void _drawSun(Canvas canvas, Rect rect) {
    var gradient = new RadialGradient(center: const Alignment(0.2, -1.2), radius: 0.8, colors: [const Color(0xFFFFFF55), const Color(0x00FFFF00)]);

    canvas.drawRect(
      rect,
      new Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_Sky oldDelegate) => false;
}
