import 'package:flutter/cupertino.dart';

class StatusWidget extends StatelessWidget {
  final Color color;

  StatusWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return new CustomPaint(painter: new _StatusPainter(color));
  }
}

class _StatusPainter extends CustomPainter {
  final Color color;

  _StatusPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(new Offset(size.width / 2, size.height / 2), size.height / 2, new Paint()..color = color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
