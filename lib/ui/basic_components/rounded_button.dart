import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef void Callback();

class RoundedButton extends StatelessWidget {
  final Color color;
  final Callback onPressed;
  final Text text;
  final double maxwidth;
  final double maxheight;
  final double minwidth;

  RoundedButton({
    @required Text text,
    Color color = Colors.red,
    Callback onPressed,
    double maxwidth = double.infinity,
    double maxheight = double.infinity,
    double minwidth = 0.0,
  })  : this.color = color,
        this.onPressed = onPressed,
        this.text = text,
        this.maxwidth = maxwidth,
        this.maxheight = maxheight,
        this.minwidth = minwidth;

  @override
  Widget build(BuildContext context) {
    double potminwidth = text.style.fontSize / 1.8 * text.data.length + 10;
    return new RawMaterialButton(
        constraints: new BoxConstraints(
            minHeight: text.style.fontSize + 20.0,
            minWidth: (minwidth != 0.0)
                ? minwidth
                : (maxwidth > potminwidth) ? potminwidth : maxwidth,
            maxHeight: maxheight,
            maxWidth: maxwidth),
        onPressed: () => onPressed,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(100000.0)),
        fillColor: Colors.red,
        child: text);
  }
}
