import 'package:flutter/material.dart';

class CameraOverlayButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CameraOverlayButton({
  super.key,
  required this.onTap,
  required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: Colors.white.withOpacity(0.7),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(text, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
