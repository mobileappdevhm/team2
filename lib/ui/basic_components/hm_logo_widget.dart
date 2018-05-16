import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

typedef Offset Transform(Offset toTransform);

///
/// The HM Logo.
///
class HMLogoWidget extends StatelessWidget {

  ///
  /// By which factor the logo is scaled.
  ///
  final double _scale;


  HMLogoWidget({double scale = 1.0}):_scale=scale;

  @override
  Widget build(BuildContext context) {
    return new CustomPaint(
        painter: new HMLogoPainter(_scale)
    );
  }

}

///
///Class containing the HM Logo data.
///
class HMLogoPainter extends CustomPainter {

  static const List<Offset> HM_LOGO_POINTS = const <Offset>[
    const Offset(0.6213973799126637, 0.0),
    const Offset(0.0, 0.26430131004366814),
    const Offset(0.1888646288209607, 0.7084061135371179),
    const Offset(0.5775109170305677, 0.7084061135371179),
    const Offset(0.8525109170305677, 0.5914847161572052),
    const Offset(0.853056768558952, 0.6131004366812227),
    const Offset(0.8503275109170305, 0.6543668122270742),
    const Offset(0.8483624454148472, 0.6777292576419214),
    const Offset(0.8465065502183405, 0.6907205240174673),
    const Offset(0.8419213973799127, 0.6993449781659389),
    const Offset(0.8295851528384279, 0.7026200873362446),
    const Offset(0.8295851528384279, 0.7081877729257643),
    const Offset(0.875764192139738, 0.7081877729257643),
    const Offset(0.875764192139738, 0.7026200873362446),
    const Offset(0.8617903930131005, 0.6995633187772925),
    const Offset(0.857532751091703, 0.6903930131004367),
    const Offset(0.8574235807860262, 0.6771834061135371),
    const Offset(0.8580786026200873, 0.6575327510917031),
    const Offset(0.8610262008733625, 0.6009825327510917),
    const Offset(0.8614628820960699, 0.6009825327510917),
    const Offset(0.9058951965065501, 0.7068777292576419),
    const Offset(0.909825327510917, 0.7068777292576419),
    const Offset(0.9581877729257643, 0.5982532751091703),
    const Offset(0.9589519650655022, 0.5982532751091703),
    const Offset(0.9597161572052402, 0.6791484716157206),
    const Offset(0.9574235807860262, 0.6983624454148473),
    const Offset(0.9429039301310044, 0.7028384279475982),
    const Offset(0.9429039301310044, 0.7084061135371179),
    const Offset(0.9951965065502184, 0.7084061135371179),
    const Offset(0.9951965065502184, 0.708296943231441),
    const Offset(0.9951965065502184, 0.7027292576419214),
    const Offset(0.9796943231441048, 0.6982532751091703),
    const Offset(0.9767467248908297, 0.6790393013100436),
    const Offset(0.975, 0.6072052401746726),
    const Offset(0.9772925764192141, 0.5889737991266376),
    const Offset(0.9932314410480348, 0.5848253275109171),
    const Offset(0.9932314410480348, 0.5792576419213974),
    const Offset(0.9594978165938864, 0.5792576419213974),
    const Offset(0.9135371179039301, 0.6786026200873363),
    const Offset(0.8683406113537118, 0.5792576419213974)
  ];

  static const double HM_LOGO_MAX_HEIGHT = 0.7084061135371179;
  static const double HM_LOGO_ASPECT_RATIO = 1.4066339066339;

  ///
  ///The red gradient of the HM Logo.
  ///
  static const LinearGradient logoGradient = const LinearGradient(
      begin: Alignment.centerLeft, end: Alignment.centerRight, colors: const [const Color.fromRGBO(154, 16, 51, 1.0), const Color.fromRGBO(228, 0, 0, 1.0)], stops: const [0.0, 1.0]);

  double _scale;

  HMLogoPainter(this._scale);

  ///
  ///Get hm logo polygon points transformed with the passed function.
  ///
  List<Offset> transformed(Transform transformFct) {
    List<Offset> newPoints = new List<Offset>();

    for (Offset p in HM_LOGO_POINTS) {
      newPoints.add(transformFct.call(p));
    }

    return newPoints;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;

    double logoWidth = min(rect.height, rect.width) * HM_LOGO_ASPECT_RATIO * _scale;
    double yOffset = rect.height - HM_LOGO_MAX_HEIGHT * logoWidth;
    double xOffset = rect.width / 2 - logoWidth / 2;

    canvas.drawPath(new Path()..addPolygon(transformed((offset) => new Offset(offset.dx * logoWidth + xOffset, offset.dy * logoWidth + yOffset)), true),
        new Paint()..shader = logoGradient.createShader(rect));
  }

  ///
  ///HM Logo should not be redrawn since it is not chaning during its
  ///lifetime.
  ///
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}