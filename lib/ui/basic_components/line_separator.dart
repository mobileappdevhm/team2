import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class LineSeparator extends StatelessWidget {
  static const Color DEFAULT_COLOR = const Color(0xFFDDDDDD);
  static const Color DEFAULT_TEXT_COLOR = const Color(0xFF707070);
  static const double DEFAULT_THICKNESS = 1.0;
  static const double DEFAULT_PADDING = 0.0;

  final String _title;
  final Color _color;
  final Color _textColor;
  final double _thickness;
  final double _padding;

  LineSeparator(
      {String title, Color color = DEFAULT_COLOR, Color textColor = DEFAULT_TEXT_COLOR, double thickness = DEFAULT_THICKNESS, double padding = DEFAULT_PADDING})
      : _title = title,
        _color = color,
        _textColor = textColor,
        _thickness = thickness,
        _padding = padding;

  @override
  build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextSpan span = new TextSpan(style: new TextStyle(color: _textColor, fontSize: 20.0, fontWeight: FontWeight.w300, letterSpacing: 3.0), text: _title);
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();

    return new Container(child: new CustomPaint(painter: new _LineSeparatorPainter(tp, _thickness, _color, _textColor, _padding)), height: tp.height, width: size.width);
  }
}

class _LineSeparatorPainter extends CustomPainter {
  TextPainter tp;
  Color _color;
  Color _textColor;
  double _thickness;
  double _padding;

  _LineSeparatorPainter(this.tp, this._thickness, this._color, this._textColor, this._padding);

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;

    Paint paint = new Paint()..color = _color;

    double padding = _padding;
    double yOffset = rect.height / 2 - _thickness / 2;
    double insets = rect.width * 0.02;

    if (tp.text.text == null || tp.text.text.isEmpty) {
      insets = 0.0;
    }

    double textXOffset = rect.width / 2 - tp.width / 2;
    double textYOffset = rect.height / 2 - tp.height / 2;

    Rect leftRect = new Rect.fromPoints(new Offset(padding, yOffset), new Offset(textXOffset - insets, yOffset + _thickness));
    Rect rightRect = new Rect.fromPoints(new Offset(rect.width / 2 + tp.width / 2 + insets, yOffset), new Offset(rect.width - padding, yOffset + _thickness));

    canvas.drawRect(leftRect, paint);
    canvas.drawRect(rightRect, paint);

    tp.paint(canvas, new Offset(textXOffset, textYOffset));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
