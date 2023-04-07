import 'package:flutter/material.dart';

class PlayerButtonWidget extends StatelessWidget {
  final double size;
  final Widget icon;
  final void Function() onTap;
  const PlayerButtonWidget({
    this.size = 70,
    required this.icon,
    required this.onTap,
    super.key,
  });

  get center => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFF8F9F9),
          border: Border.all(
            color: Colors.black54,
            width: size * 0.0007,
          ),
        ),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    focal: Alignment.center,
                    radius: constraints.maxHeight * 0.01,
                    colors: const [
                      Color(0xFFF8F9F9),
                      Color(0xffEBEDEE),
                    ],
                  ),
                ),
                child: icon);
          },
        ),
      ),
    );
  }
}
