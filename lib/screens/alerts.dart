import 'package:flutter/material.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/models/alerts_response.dart';
import 'package:prosecat/search/alert_search_delegate.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class Alerts extends StatelessWidget {
  final bool? isFromPageView;
  const Alerts({super.key, this.isFromPageView});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: (isFromPageView ?? false) 
        ? null 
        : AppBar(
            title: Text(S.of(context).labelAlertas),
            actions: [
              SizedBox(
                width: (screenWidth * 30) / 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.warning_rounded),
                      onPressed: () => Navigator.pushNamed(context, 'check_alert'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        showSearch(context: context, delegate: AlertSearchDelegate());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
      body: PopScope(
        // ignore: deprecated_member_use
        onPopInvoked: (bool value){
          Provider.of<DeviceProvider>(context, listen: false).resume();          
        },
        child: SafeArea(
          child: Column(
            // alignment: Alignment.bottomCenter,
            children: [
              // GoogleMaps(mapKey: UniqueKey(),),
              SizedBox(
                  height: (screenHeight * 45) / 100,
                  child: const AlertsMap()),
              const Expanded(
                  // height: (screenHeight * 50) / 100,
                  child: DraggableAlerts()),
            ],
          ),
        ),
      ),
    );
  }
}

class DraggableAlerts extends StatelessWidget {
  const DraggableAlerts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black87,
      ),
      child: const BottomSheetItemsColumn(),
    );
  }
}

//Diseño del Modal
class BottomSheetItemsColumn extends StatefulWidget{
  const BottomSheetItemsColumn({super.key});

  @override
  State<BottomSheetItemsColumn> createState() => _BottomSheetItemsColumnState();
}

class _BottomSheetItemsColumnState extends State<BottomSheetItemsColumn> {
  AlertResponse? _alertsResponse;
  AlertResponse? _futureAlerts;
  ScrollController scrollController = ScrollController();
  bool hasData = false;
  bool isLoading = false;
  int page = 1;
  
  @override
  void initState() {
    super.initState();
    if (mounted) {
      _initData();      
    }
  }
  
  Future<void> _initData() async {
    await Future.microtask(() async{
            
      // ignore: use_build_context_synchronously
      _alertsResponse = await Provider.of<DeviceProvider>(context, listen: false).getAlerts();        
      

      if (_alertsResponse != null) {
        if (_alertsResponse!.items.data.isEmpty) {
          hasData = false;
        }else{
          hasData = true;
        }
      }
      if (mounted) {
        setState(() {});        
      }

    }).then((value) => scrollController.addListener(() {
      if ((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent) {
        if (_alertsResponse!.items.data.length >= 30 && _alertsResponse!.items.lastPage > page) {          
          fetchData();
        }
      }
    }));
  }

  Future fetchData() async {
    if (isLoading) return;
    
    isLoading = true;
    
    page++;

    setState(() {});

    _futureAlerts = await Provider.of<DeviceProvider>(context, listen: false).getAlerts(page: page);

    _alertsResponse!.items.data = [..._alertsResponse!.items.data, ..._futureAlerts!.items.data];

    isLoading = false;

    setState(() {});

    if (scrollController.position.pixels + 100 <= scrollController.position.maxScrollExtent) return;
    
    scrollController.animateTo(
      scrollController.position.pixels + 120, 
      duration: const Duration(milliseconds: 300), 
      curve: Curves.fastOutSlowIn
    );

  }

  @override
  void dispose() {
    scrollController.dispose();
    page = 1;
    _futureAlerts = null;
    hasData = false;
    isLoading = false;
    super.dispose();            
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [          
        
        if(!hasData && _alertsResponse != null)
          TextButton.icon(
            icon: const Icon(Icons.alarm_off_outlined),
            label: Text(S.of(context).labelSinAlertas),
            onPressed: (){}
          ),          

        RefreshIndicator(
          onRefresh: () async => await _initData(),
          child: Column(
            children: [
              //Titulos
              Container(
                width: double.infinity,
                // margin: const EdgeInsets.only(top: 15),
                color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black87,
                child: Row(
                  children: [
                    AlertasTitle(
                      titulo: S.of(context).labelTiempo.toUpperCase(),
                      isTitle: true,
                    ),
                    AlertasTitle(
                      titulo: S.of(context).labelDispositivo.toUpperCase(),
                      isTitle: true,
                    ),
                    AlertasTitle(
                      titulo: S.of(context).labelAlertas.toUpperCase(),
                      isTitle: true,
                    ),
                    AlertasTitle(
                      titulo: S.of(context).labelDireccion.toUpperCase(),
                      isTitle: true,
                    ),
                  ],
                ),
              ),
              
              //Lista de alertas
              Expanded(
                child: (_alertsResponse != null)  
                  ? AlertsList(
                      alerts: _alertsResponse!.items.data, 
                      scrollController: scrollController,
                    ) 
                  : const SizedBox(
                      width: double.infinity, 
                      child: SkeletonAvatar()
                    )                
              )
            ],
          ),
        ),          
                  
        if(isLoading)
          Positioned(
            bottom: 40,
            left: size.width * 0.5 - 25,
            child: const CircularProgressIndicator()
          ),      
        
      ],
    );
  } 
}
