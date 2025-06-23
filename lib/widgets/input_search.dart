import 'package:flutter/material.dart';
import 'package:prosecat/search/device_search_delegate.dart';

import '../ui/ui.dart';

class InputSearchStyle {  
  static PreferredSize inputSearchDecoration({
    required String hintText,
    required double screenWidth,
    required BuildContext context,
  }){
    return PreferredSize(           
      
      preferredSize: const Size.fromHeight(60.0),
      child: Container(
        width: (screenWidth * 80) / 100,
        margin: const EdgeInsets.only(bottom: 8),
        child: TextFormField(
          readOnly: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          keyboardType: TextInputType.none,
          decoration: SearchDecoration.searchDecorationAll(hintText: hintText),
          onChanged: (value){
          },
          onTap: () => showSearch(context: context, delegate: DeviceSearchDelegate()),
        ),
      ),
    );
  }
}