import 'package:flutter/material.dart';

class CaptureButton extends StatefulWidget {
  final VoidCallback onClick;

  const CaptureButton({super.key, required this.onClick});

  @override
  State<CaptureButton> createState() => _CaptureButtonState();
}

class _CaptureButtonState extends State<CaptureButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.4,
      lowerBound: 0,
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
        widget.onClick();
      },
      child: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          builder: (_, Widget? child) {
            return Transform.scale(
              //To switch lower bound and upper bound
              scale: 1 - _controller.value,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
