import 'package:flutter/material.dart';
import 'package:prosecat/providers/map_screen_provider.dart';
import 'package:provider/provider.dart';

class ButtonHandlerStyleMap extends StatelessWidget {
  const ButtonHandlerStyleMap({super.key});


  @override
  Widget build(BuildContext context) {
    final mapScreenProvider = Provider.of<MapScreenProvider>(context, listen: false);
    return Positioned(
        right: 0,
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          margin: const EdgeInsets.only(top: 10, right: 10),
          child: IconButton(
            
            onPressed: (){
              mapScreenProvider.handlerMapTypeInOverview();
            }, 
            icon: const Icon(Icons.map, size: 35, color: Colors.black,)
          ),
        )
      );
  }
}