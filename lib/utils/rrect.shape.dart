import 'dart:math' as math;

import 'package:flutter/material.dart';

class RoundRectSliderThumbShape extends SliderComponentShape {
  /// Create a slider thumb that draws a circle.
  const RoundRectSliderThumbShape({
    this.enabledThumbWidth = 15.0,
    this.enabledThumbHeight = 20.0,
    this.disabledThumbHeight,
    this.disabledThumbWidth,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
  });

  /// The preferred width of the thumb shape when the slider is enabled.
  ///
  /// If it is not provided, then a default of 15 is used.
  final double enabledThumbWidth;

  /// The preferred height of the thumb shape when the slider is enabled.
  ///
  /// If it is not provided, then a default of 20 is used.
  final double enabledThumbHeight;

  /// The preferred width of the thumb shape when the slider is disabled.
  ///
  /// If no disabledRadius is provided, then it is equal to the
  /// [enabledThumbWidth]
  final double? disabledThumbWidth;
  double get _disabledThumbWidth => disabledThumbWidth ?? enabledThumbWidth;

  /// The preferred width of the thumb shape when the slider is disabled.
  ///
  /// If no disabledRadius is provided, then it is equal to the
  /// [enabledThumbHeight]
  final double? disabledThumbHeight;
  double get _disabledThumbHeight => disabledThumbHeight ?? enabledThumbHeight;

  /// The resting elevation adds shadow to the unpressed thumb.
  ///
  /// The default is 1.
  ///
  /// Use 0 for no shadow. The higher the value, the larger the shadow. For
  /// example, a value of 12 will create a very large shadow.
  ///
  final double elevation;

  /// The pressed elevation adds shadow to the pressed thumb.
  ///
  /// The default is 6.
  ///
  /// Use 0 for no shadow. The higher the value, the larger the shadow. For
  /// example, a value of 12 will create a very large shadow.
  final double pressedElevation;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
      isEnabled == true
          ? math.max(enabledThumbHeight, enabledThumbHeight)
          : math.max(_disabledThumbHeight, _disabledThumbHeight),
    );
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    assert(context != null);
    assert(center != null);
    assert(enableAnimation != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);

    final Canvas canvas = context.canvas;

    final Tween<double> widthTween = Tween<double>(
      begin: _disabledThumbWidth,
      end: enabledThumbWidth,
    );

    final Tween<double> heightTween = Tween<double>(
      begin: _disabledThumbHeight,
      end: enabledThumbHeight,
    );

    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final Color color = colorTween.evaluate(enableAnimation)!;
    final double width = widthTween.evaluate(enableAnimation);
    final double height = heightTween.evaluate(enableAnimation);

    final Tween<double> elevationTween = Tween<double>(
      begin: elevation,
      end: pressedElevation,
    );

    final double evaluatedElevation =
        elevationTween.evaluate(activationAnimation);
    final Path path = Path()
      ..addArc(
        Rect.fromCenter(
          center: center,
          width: 1.5 * width,
          height: 2 * height,
        ),
        0,
        math.pi * 2,
      );
    canvas.drawShadow(path, Colors.black, evaluatedElevation, true);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: width, height: height),
        const Radius.circular(3),
      ),
      Paint()..color = color,
    );
  }
}
