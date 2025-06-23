import 'package:flutter/material.dart';
import 'package:prosecat/widgets/svg_icon.dart';

class TargetInformation extends StatelessWidget {
  final String? title;
  final String text;
  final String? asset;
  final String? assetImage;
  const TargetInformation({
    super.key, this.title, required this.text, this.asset, this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    String name = '';

    title != null ? name = '$title: ' : '';

    return Container(
      // color: Colors.amber,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,        
        children: [
          if(asset != null)
            SvgIcon(asset: asset!, width: 17,),
          if(assetImage != null)
            Image.asset(assetImage!, width: 17,),
          if(assetImage != null || asset != null)
            const SizedBox(width: 8,),
            
          SizedBox(
            width: (width * 80) / 100,
            child: Text('$name$text', style: TextStyle(
              color: (text != 'offline') 
                ? Theme.of(context).brightness == Brightness.light ? Colors.grey[700] : Colors.white 
                : Colors.red, 
              fontSize: 14, ),
            ),
          ),       
        ],        
      ),
    );
  }
}