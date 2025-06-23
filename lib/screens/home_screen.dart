import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:prosecat/providers/pages_provider.dart';
import 'package:prosecat/screens/alerts.dart';
import 'package:prosecat/screens/devices.dart';
import 'package:prosecat/screens/history.dart';
import 'package:prosecat/screens/map_screen.dart';
import 'package:prosecat/search/search.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/widgets.dart' as flutter_icon;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<String>? notificationSubscription;

  @override
  void initState() {
    super.initState();

    // PushNotificationService.initializeApp();
    notificationSubscription =
        PushNotificationService.messagesStream.listen((message) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
    });

    showToast();
  }

  @override
  void dispose() {
    //Error al cambiar entre pantalla
    if (notificationSubscription != null && mounted) {
      notificationSubscription!.cancel();
    }
    super.dispose();
  }

  Future<void> showToast() async {
    final countDevices =
        await Provider.of<DeviceProvider>(context, listen: false)
            .getCountDevicesToExpire();
    if (countDevices > 0) {
      Fluttertoast.showToast(
          msg: S.current.labelDispositivoPorVencer(countDevices));
    }
  }

  @override
  Widget build(BuildContext context) {
    final pagesProvider = Provider.of<PagesProvider>(context);
    final device = Provider.of<DeviceProvider>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    List<Widget> actions = [
      CountersButtons(screenWidth: screenWidth),
      IconButton(
        icon: const flutter_icon.Icon(Icons.search),
        onPressed: () {
          DeviceSearchDelegate searchDelegate =
              DeviceSearchDelegate(device: device, isFromPageView: true);
          showSearch(context: context, delegate: searchDelegate);
        },
      ),
      SizedBox(
        width: (screenWidth * 30) / 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const flutter_icon.Icon(Icons.warning_rounded),
              onPressed: () => Navigator.pushNamed(context, 'check_alert'),
            ),
            IconButton(
              icon: const flutter_icon.Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: AlertSearchDelegate());
              },
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(pagesProvider.getTitle),
        centerTitle: true,
        actions: [
          (pagesProvider.getShowActions)
              ? actions[pagesProvider.getActionIndex]
              : Container()
        ],
      ),
      drawer: const AppDrawer(),
      body: PageView(
          onPageChanged: (int index) => pagesProvider.appBarController(index),
          controller: pagesProvider.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            MapScreen(),
            // TestMarker(),
            Devices(isFromPageView: true),
            Alerts(isFromPageView: true),
            History(isFromPageView: true)
          ]),
      bottomNavigationBar: const AnimatedButtonNavbar(),
    );
  }
}

class CountersButtons extends StatelessWidget {
  const CountersButtons({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DeviceProvider>(context);

    deviceProvider.getAllDevice();
    final countStatus = getCountStatus(deviceProvider.devicesResponse);

    return SizedBox(
      width: (screenWidth * 30) / 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.green,
            child: Text(countStatus['green'].toString()),
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.yellow,
            child: Text(
              countStatus['yellow'].toString(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.red,
            child: Text(countStatus['red'].toString()),
          ),
        ],
      ),
    );
  }
}
