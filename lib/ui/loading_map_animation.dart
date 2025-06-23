import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget loadingMapAnimation(){
  return Center(
      child: Lottie.asset('assets/images/world_map_animation.zip', width: 200, height: 200));
}

