import 'package:flutter/material.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/models/alerts_list.dart';
import 'package:prosecat/services/device_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class CheckAlert extends StatefulWidget {
  const CheckAlert({super.key});

  @override
  State<CheckAlert> createState() => _CheckAlertState();
}

class _CheckAlertState extends State<CheckAlert> {
  Alerts? _alertsFuture;
  Alerts? _alertsResponse;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  
  Future<void> _fetchData() async {
    _alertsFuture = await Provider.of<DeviceProvider>(context, listen: false).getAlertsList();
    final value = _alertsFuture;
    setState(() {      
      _alertsResponse = value;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).labelAlertas),
        actions: [
          IconButton(
            onPressed: () => _fetchData(), 
            icon: const Icon(Icons.restore_outlined),
          )
        ],
      ),
      
      body: (_alertsResponse != null)
        ? ListView.builder(
            itemCount: _alertsResponse!.items.alerts.length,
            itemBuilder: (_, index){
              return CheckboxListTile(
                activeColor: Theme.of(context).colorScheme.primary,                
                checkboxShape: const CircleBorder(),
                controlAffinity: ListTileControlAffinity.leading,
                value: _alertsResponse!.items.alerts[index].active == 1 ? true : false, 
                title: Text(_alertsResponse!.items.alerts[index].name),
                onChanged: (newValue) async {
                  setState(() {
                    _alertsResponse!.items.alerts[index].active =
                        _alertsResponse!.items.alerts[index].active == 1 ? 0 : 1;
                  });

                  await deviceProvider.changeActiveAlert(
                    _alertsResponse!.items.alerts[index].id.toInt(),
                    _alertsResponse!.items.alerts[index].active
                  );
                  // _fetchData();
                }
              );
            }
          )
        : SkeletonListView()
    );
  }
}