import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircularColorButton extends StatelessWidget {
  const CircularColorButton({
    super.key,
    required this.size, required this.color, this.svgImage, this.image, this.onTap, this.border,
  });

  final double size;
  final Color color;
  final BoxBorder? border;
  final String? svgImage, image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: border
          ),
          width: size,
          height: size,
          padding: const EdgeInsets.all(4),
          child: svgImage != null 
            ? SvgPicture.asset(
                svgImage!, 
                width: size / 2,
                height: size / 2,
              )
            : Image.asset(
                image!, 
                width: 1,
                height: 1,
              )
        )
      ),
    );
  }
}