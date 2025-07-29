import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransparentInsectAnimation extends ConsumerStatefulWidget {
  final int insectCount;

  const TransparentInsectAnimation({super.key, this.insectCount = 5});

  @override
  ConsumerState<TransparentInsectAnimation> createState() =>
      _TransparentInsectAnimationState();
}

class _TransparentInsectAnimationState extends ConsumerState<TransparentInsectAnimation>
    with SingleTickerProviderStateMixin {
  final Random _random = Random();
  late List<Insect> _insects;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _insects = List.generate(widget.insectCount, (_) => _createInsect());
    _controller =
        AnimationController(vsync: this, duration: const Duration(days: 1))
          ..addListener(() => setState(() {}))
          ..repeat();
  }

  Insect _createInsect() {
    return Insect(
      x: _random.nextDouble(),
      y: _random.nextDouble(),
      direction: _random.nextDouble() * 2 * pi,
      speed: 0.3 + _random.nextDouble() * 1.7,
      size: 8.0 + _random.nextDouble() * 24.0,
      type: _random.nextInt(3),
      isAlive: true,
    );
  }

  void _handleTapDown(TapDownDetails details, Size size) {
    final clickX = details.localPosition.dx / size.width;
    final clickY = details.localPosition.dy / size.height;

    setState(() {
      // Find insects in exact click position
      final killedIndices = <int>[];
      final hitAreaMultiplier = 1.3;

      for (int i = 0; i < _insects.length; i++) {
        final insect = _insects[i];
        if (!insect.isAlive) continue;

        // Calculate distance from click to insect center
        final distance = sqrt(
          pow(insect.x - clickX, 2) + pow(insect.y - clickY, 2),
        );

        // Only kill if click is within insect body (considering size)
        final insectRadius = (insect.size / size.width / 2) * hitAreaMultiplier;
        if (distance <= insectRadius) {
          insect.isAlive = false;
          killedIndices.add(i);
        }
      }

      // Remove dead insects after delay
      if (killedIndices.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              for (var index in killedIndices.reversed) {
                _insects.removeAt(index);
              }
            });
          }
        });
      }
    });
  }

  // void _handleSecondaryTapDown(TapDownDetails details, Size size) {
  //   final clickX = details.localPosition.dx / size.width;
  //   final clickY = details.localPosition.dy / size.height;
  //
  //   setState(() {
  //     // Find the closest insect
  //     Insect? closestInsect;
  //     double closestDistance = double.infinity;
  //
  //     for (final insect in _insects.where((i) => i.isAlive)) {
  //       final distance = sqrt(
  //           pow(insect.x - clickX, 2) + pow(insect.y - clickY, 2));
  //       if (distance < closestDistance && distance < insect.size / 100) {
  //         closestDistance = distance;
  //         closestInsect = insect;
  //       }
  //     }
  //
  //     if (closestInsect != null) {
  //       // Create 1-3 new insects near the clicked one
  //       final count = 1 + _random.nextInt(3);
  //       for (int i = 0; i < count; i++) {
  //         _insects.add(Insect(
  //           x: (closestInsect.x + (_random.nextDouble() - 0.5) * 0.1).clamp(
  //               0.0, 1.0),
  //           y: (closestInsect.y + (_random.nextDouble() - 0.5) * 0.1).clamp(
  //               0.0, 1.0),
  //           direction: closestInsect.direction +
  //               (_random.nextDouble() - 0.5) * pi / 2,
  //           speed: closestInsect.speed * (0.8 + _random.nextDouble() * 0.4),
  //           size: closestInsect.size * (0.7 + _random.nextDouble() * 0.6),
  //           type: closestInsect.type,
  //           isAlive: true,
  //         ));
  //       }
  //     }
  //   });
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: (event) {},
          child: GestureDetector(
            onTapDown: (details) =>
                _handleTapDown(details, constraints.biggest),
            // onSecondaryTapDown: (details) {
            //   // Prevent default behavior
            //   _handleSecondaryTapDown(details, constraints.biggest);
            // },
            behavior: HitTestBehavior.opaque,
            child: CustomPaint(
              painter: InsectPainter(
                insects: _insects,
                random: _random,
                time: DateTime.now().millisecondsSinceEpoch,
              ),
              willChange: true,
              size: constraints.biggest,
            ),
          ),
        );
      },
    );
  }
}

class Insect {
  double x, y;
  double direction;
  double speed;
  double size;
  int type;
  bool isAlive;
  double legPhase;

  Insect({
    required this.x,
    required this.y,
    required this.direction,
    required this.speed,
    required this.size,
    required this.type,
    required this.isAlive,
  }) : legPhase = Random().nextDouble() * 2 * pi;
}

class InsectPainter extends CustomPainter {
  final List<Insect> insects;
  final Random random;
  final int time;

  InsectPainter({
    required this.insects,
    required this.random,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final insect in insects) {
      if (!insect.isAlive) {
        _drawDeadInsect(canvas, insect, size);
        continue;
      }

      _updateInsect(insect, size);
      _drawInsect(canvas, insect, size);
    }
  }

  void _updateInsect(Insect insect, Size size) {
    insect.x += cos(insect.direction) * insect.speed / 1000;
    insect.y += sin(insect.direction) * insect.speed / 1000;

    if (random.nextDouble() < 0.02) {
      insect.direction += (random.nextDouble() - 0.5) * pi / 4;
    }

    if (insect.x < 0) {
      insect.x = 0;
      insect.direction = pi - insect.direction;
    } else if (insect.x > 1) {
      insect.x = 1;
      insect.direction = pi - insect.direction;
    }

    if (insect.y < 0) {
      insect.y = 0;
      insect.direction = -insect.direction;
    } else if (insect.y > 1) {
      insect.y = 1;
      insect.direction = -insect.direction;
    }

    insect.legPhase += 0.1;
  }

  void _drawInsect(Canvas canvas, Insect insect, Size size) {
    final x = insect.x * size.width;
    final y = insect.y * size.height;
    final bodyPaint = Paint()
      ..color = _getInsectColor(insect.type)
      ..style = PaintingStyle.fill;

    // Draw body
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(insect.direction);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: insect.size,
        height: insect.size * 0.6,
      ),
      bodyPaint,
    );
    canvas.restore();

    // Draw legs
    final legPaint = Paint()
      ..color = _getInsectColor(insect.type)
      ..strokeWidth = insect.size * 0.08
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 6; i++) {
      final legAngle = insect.direction + (i - 2.5) * 0.5;
      final legLength = insect.size * 0.7;
      final legWave = sin(insect.legPhase + i * 0.5) * 0.3;

      canvas.drawLine(
        Offset(x, y),
        Offset(
          x + cos(legAngle + legWave) * legLength,
          y + sin(legAngle + legWave) * legLength,
        ),
        legPaint,
      );
    }
  }

  void _drawDeadInsect(Canvas canvas, Insect insect, Size size) {
    final x = insect.x * size.width;
    final y = insect.y * size.height;
    final paint = Paint()
      ..color = _getInsectColor(insect.type).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw X mark
    canvas.drawLine(
      Offset(x - insect.size / 2, y - insect.size / 2),
      Offset(x + insect.size / 2, y + insect.size / 2),
      paint,
    );
    canvas.drawLine(
      Offset(x + insect.size / 2, y - insect.size / 2),
      Offset(x - insect.size / 2, y + insect.size / 2),
      paint,
    );
  }

  Color _getInsectColor(int type) {
    return [
      const Color(0xFF8B4513).withOpacity(0.9),
      const Color(0xFF000000).withOpacity(0.9),
      const Color(0xFF556B2F).withOpacity(0.9),
    ][type];
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
