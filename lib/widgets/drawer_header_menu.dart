import 'package:flutter/material.dart';
import 'package:prosecat/providers/providers.dart';
import 'package:provider/provider.dart';

class DrawerHead extends StatelessWidget {
  const DrawerHead({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<SetProfileProvider>(context, listen: false);
    if (profileProvider.getEmail == '') {
      profileProvider.setEmail();
    }
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(120),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              width: 120,
            ),
          ),
          FutureBuilder(
              future: profileProvider.getE(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  final email = asyncSnapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FittedBox(
                      child: Text(
                        email ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: 14),
                      ),
                    ),
                  );
                }
                return Container();
              }),
        ],
      ),
    );
  }
}
