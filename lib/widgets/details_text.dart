import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosecat/helpers/helpers.dart';

class DetailsText extends StatelessWidget {
  const DetailsText({
    super.key, 
    required this.title, 
    this.val, 
    required this.suFix, 
    this.fontSize, 
    this.asset, 
    this.position,
  });

  final String title;
  final String? val;
  final String suFix;
  final double? fontSize;
  final String? asset;
  final LatLng? position;
  
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 15 + (fontSize ?? 0.0));

    return (val != null)
      ? Text('$title: $val $suFix', style: style,)
      : Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              (asset != null && asset != '')
                ? Image.asset(asset!)
                : Container(),
              Text(title, style: style, textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),),
            ],
          ),
          (position != null)
            ? IconButton(
                iconSize: 25,
                onPressed: () async{                    
                  final String url = 'https://www.google.com/maps/@${position!.latitude.toString()},${position!.longitude.toString()},3a,75y,89.25h,93.76t/data=!3m4!1e1!3m2!1sAF1QipP9GGgMpHEJ9R6z3oNrHQwP9e5RQqHBZQapagzR!2e10';
                  launchUrlToExternalApp(url);
                },
                icon: Image.asset('assets/images/google_map.png', width: 25, fit: BoxFit.contain,),
              )
            : Container()
          
        ],
      );
  }
}