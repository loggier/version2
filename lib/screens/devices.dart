// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:prosecat/models/models.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:prosecat/search/device_search_delegate.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart'  as flutter_icon;

class Devices extends StatefulWidget {
  const Devices({super.key, this.isFromPageView});
  final bool? isFromPageView;

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices>{
  @override
  Widget build(BuildContext context) {  
    double screenWidth = MediaQuery.of(context).size.width;
    
    final device = Provider.of<DeviceProvider>(context);   

    StatusDevice devicesStatus = getStatusDevice(device.devicesResponse);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: (widget.isFromPageView ?? false) 
          ? null
          : AppBar(
              title: Text(S.of(context).labelDispositivos),
              actions: [
              IconButton(
                icon: const flutter_icon.Icon(Icons.search),
                onPressed: (){
                  DeviceSearchDelegate searchDelegate = DeviceSearchDelegate(device: device, isFromPageView: widget.isFromPageView);
                  showSearch(context: context, delegate: searchDelegate);
                }, 
              ),
            ],
          ),
        body: PopScope(
          onPopInvoked: (bool value){
            Provider.of<DeviceProvider>(context, listen: false).resume();
          },
          child: SafeArea(
            child: Column(
              children: [
                TabBar(
                  labelColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  tabs: [
                    Tab(text: S.of(context).labelTodos.toUpperCase(),),
                    Tab(text: S.of(context).labelEnLinea.toUpperCase(),),
                    Tab(text: S.of(context).labelFueraLinea.toUpperCase(),),
                  ]
                ),
                Expanded(
                  child: TabBarView(
                    children: [        
                      AllDevicesLayout(screenWidth: screenWidth, deviceResponse: devicesStatus.devices, isFromPageView: widget.isFromPageView ?? false,),
                      AllDevicesLayout(screenWidth: screenWidth, deviceResponse: devicesStatus.devicesOnline, isFromPageView: widget.isFromPageView ?? false,),
                      AllDevicesLayout(screenWidth: screenWidth, deviceResponse: devicesStatus.devicesOffline, isFromPageView: widget.isFromPageView ?? false,),                          
                      ]
                    ),
                )
              ],
            ),                
          ),
        ),
      ),
    );
  }
  
}

class AllDevicesLayout extends StatelessWidget {
  const AllDevicesLayout({super.key,      
    required this.screenWidth, required this.deviceResponse, required this.isFromPageView,  
    
  });
  final bool isFromPageView;
  final double screenWidth;
  final Map<String, List<Item>> deviceResponse;
  
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 23),
      child: RefreshIndicator(
        onRefresh: ()async{
          await Provider.of<DeviceProvider>(context, listen: false).getAllDevice(reload: true);   
          return Future.delayed(const Duration(seconds: 2));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
             for(var value in deviceResponse.entries)
              (value.value.isNotEmpty) 
                ? ExpansionTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    initiallyExpanded: true,
                    title: Text(
                      '${value.key} - (${value.value.length})', 
                      style: Theme.of(context).textTheme.bodyLarge,
                      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                    ),
                    leading: const SvgIcon(asset: 'assets/icon/dont_disturb.svg',),
                    textColor: Colors.black,
                    // backgroundColor: Colors.grey[300],
                    iconColor: Colors.black,
                    children: [
                        GroupItem(grupo: value.value, isFromSearch: false, isFromPageView: isFromPageView,),
                    ],
                  )
                : Container()
            ],
          ),
        ),
      ),
    );
  }
}