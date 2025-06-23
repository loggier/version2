import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//Widget para mostrar svg
class SvgIcon extends StatelessWidget {
  final String asset;
  final double? width;
  final Color? color;
  const SvgIcon({
    super.key, required this.asset, this.width, this.color
  });  

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset, 
      width: (width != null) ? width : 22, 
      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}