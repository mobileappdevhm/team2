import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class AnimatedImage extends StatefulWidget {
  /// Count of images in the folder.
  final int imageCount;

  /// Root folder of the animation images.
  /// e. g. "res/cool-animation"
  final String animationRootFolder;

  /// Prefix of the animation image files.
  /// e. g. "frame_1", "frame" is the prefix.
  final String animationImagePrefix;

  /// Duration of the animation.
  final Duration duration;

  AnimatedImage(
      {@required this.imageCount,
      @required this.animationRootFolder,
      @required this.animationImagePrefix,
      @required this.duration});

  @override
  State<StatefulWidget> createState() => new _AnimatedImageState(
      imageCount: imageCount,
      animationRootFolder: animationRootFolder,
      animationImagePrefix: animationImagePrefix,
      duration: duration);
}

class _AnimatedImageState extends State<AnimatedImage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> _animation;

  final String animationRootFolder;
  final String animationImagePrefix;

  _AnimatedImageState(
      {@required int imageCount,
      @required Duration duration,
      @required this.animationRootFolder,
      @required this.animationImagePrefix}) {
    _controller = new AnimationController(vsync: this, duration: duration)
      ..repeat();
    _animation = new IntTween(begin: 1, end: imageCount).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget child) {
          String frame = _animation.value.toString().padLeft(4, '0');
          return new Image.asset(
              "$animationRootFolder/$animationImagePrefix$frame.png",
              gaplessPlayback: true);
        });
  }
}
