import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:prosecat/controllers/map_record_controller.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:prosecat/models/alerts_response.dart';
import 'package:prosecat/models/device_details.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/ui/show_dialog.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HistoryDetails extends StatelessWidget {
  const HistoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final mapRecordController = Provider.of<MapRecordController>(context);
    final deviceProvider = Provider.of<DeviceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: const [
          SizedBox(
            width: 45,
          )
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (deviceProvider.deviceDetails != null)
                ? GestureDetector(
                    onTap: () => showPickerRange(
                        context,
                        deviceProvider.getDateFrom(),
                        deviceProvider.getDateTo(),
                        deviceProvider.getDeviceSelected),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${deviceProvider.getDateFrom()} - ${deviceProvider.getDateTo()}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        )),
                  )
                : Container()
          ],
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          //Mapa
          HistoryMap(
            deviceDetails: deviceProvider.deviceDetails,
            screenWidth: screenWidth,
          ),

          //Modal
          DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.2,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.grey[900],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(children: [
                      //Nombre del vehiculo
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Text(
                              (deviceProvider.deviceDetails != null)
                                  ? deviceProvider.deviceDetails!.device.name
                                  : '',
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade800
                                      : Colors.white,
                                  fontSize: 18),
                            ),
                            if (mapRecordController.getShowSpeedLines)
                              const Positioned(right: 10, child: JustToolTip())
                          ],
                        ),
                      ),

                      //Botones
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              iconSize: 40,
                              onPressed: () {
                                mapRecordController.playMarkerMovement();
                              },
                              icon: (mapRecordController.isPlay)
                                  ? const Icon(Icons.pause_circle)
                                  : const Icon(Icons.play_circle)),
                          IconButton(
                              iconSize: 40,
                              onPressed: () {
                                mapRecordController.stopMarkerMovement();
                              },
                              icon: const Icon(Icons.stop_circle)),
                        ],
                      ),

                      //Tabs
                      SizedBox(
                        width: screenWidth,
                        // margin: const EdgeInsets.symmetric(horizontal: 15),
                        height: (screenHeight * 80) / 100,
                        child: DefaultTabController(
                            length: 3,
                            child: Column(
                              children: [
                                TabBar(
                                    dividerColor: Colors.transparent,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    labelColor: Colors.black,
                                    unselectedLabelColor: Colors.grey,
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.5), // Color de la sombra
                                            spreadRadius:
                                                1, // Radio de propagación de la sombra
                                            blurRadius:
                                                5, // Radio de desenfoque de la sombra
                                            offset: const Offset(0,
                                                3), // Desplazamiento de la sombra en el eje Y
                                          )
                                        ]),
                                    tabs: [
                                      Tab(
                                        text: S.of(context).labelResumen,
                                      ),
                                      Tab(
                                        text: S.of(context).labelDetalle,
                                      ),
                                      Tab(
                                        text: S.of(context).labelAlertas,
                                      ),
                                    ]),
                                Expanded(
                                  child: (deviceProvider.deviceDetails != null)
                                      ? TabBarView(
                                          physics: const BouncingScrollPhysics(
                                              decelerationRate:
                                                  ScrollDecelerationRate.fast),
                                          children: [
                                              ResumenDispositivo(
                                                distanceSum: deviceProvider
                                                    .deviceDetails!.distanceSum,
                                                topSpeed: deviceProvider
                                                    .deviceDetails!.topSpeed,
                                                moveDuration: deviceProvider
                                                    .deviceDetails!
                                                    .moveDuration,
                                                stopDuration: deviceProvider
                                                    .deviceDetails!
                                                    .stopDuration,
                                              ),
                                              DetalleDispositivo(
                                                  listItem: deviceProvider
                                                      .deviceDetails!.items!),
                                              OverviewAlerts(
                                                  screenWidth: screenWidth,
                                                  alerts: deviceProvider
                                                      .alertsReponse!,
                                                  dateFrom: deviceProvider
                                                      .getDateFrom(),
                                                  dateTo: deviceProvider
                                                      .getDateTo(),
                                                  idDevice: deviceProvider
                                                      .getDeviceSelected),
                                            ])
                                      : Container(),
                                )
                              ],
                            )),
                      ),
                    ]),
                  ),
                );
              }),

          if (deviceProvider.getIsLoading)
            // loadingMapAnimation()
            buildLoadingSpin(),

          if (mapRecordController.getIsLoading) buildLoadingSpin(),
        ],
      )),
    );
  }

//Calendario de rangos
  Future<dynamic> showPickerRange(
      BuildContext context, String dateFrom, String dateTo, String deviceId) {
    DateTime startDate = DateTime.parse(dateFrom);
    DateTime endDate = DateTime.parse(dateTo);
    final mapRecordController =
        Provider.of<MapRecordController>(context, listen: false);
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(S.of(context).labelSeleccioneUnaFecha),
            content: SizedBox(
              width: 500,
              height: 300,
              child: SfDateRangePicker(
                initialSelectedRange: PickerDateRange(startDate, endDate),
                selectionMode: DateRangePickerSelectionMode.range,
                monthViewSettings:
                    const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                confirmText: S.of(context).labelConfirmar,
                cancelText: S.of(context).labelCancelar,
                onSubmit: (Object? value) async {
                  Navigator.pop(context);

                  deviceProvider.setIsLoading = true;

                  try {
                    DateTime startDate = DateTime.now();
                    DateTime endDate = DateTime.now();
                    if (value is PickerDateRange) {
                      startDate = value.startDate!;
                      if (value.endDate != null) {
                        endDate = value.endDate!;
                      } else {
                        endDate = value.startDate!;
                      }
                    }
                    final stringStartDate = DateHelper.dateToString(startDate);
                    final stringEndDate = DateHelper.dateToString(endDate);

                    final stringStartHour = DateHelper.timeToString(startDate);
                    final stringEndHour = DateHelper.timeToString(endDate);

                    final newDeviceDetails =
                        await deviceProvider.getRecordByDevice(
                            stringStartDate,
                            stringStartHour,
                            stringEndDate,
                            stringEndHour,
                            deviceId);

                    //Mostrar alerta
                    if (newDeviceDetails == null) {
                      deviceProvider.setIsLoading = false;

                      return await showMyDialog(
                          navigatorKey.currentContext!,
                          S.current.mensaje,
                          S.current.errorSinDatos,
                          S.current.aceptarMensaje);
                    } else {
                      //Actualizar datos de las alertas
                      await deviceProvider.getAlerts(
                        from: stringStartDate,
                        to: stringEndDate,
                        deviceId: deviceProvider.deviceSelected,
                      );
                      deviceProvider.page = 1;

                      //Actualizar datos
                      deviceProvider.setDateFrom = startDate;
                      deviceProvider.setDateTo = endDate;

                      await mapRecordController.handleItems(newDeviceDetails);

                      deviceProvider.setIsLoading = false;
                    }
                  } catch (e) {
                    deviceProvider.setIsLoading = false;
                  }
                },
                onCancel: () {
                  Navigator.pop(context);
                },
                showActionButtons: true,
              ),
            ),
          );
        });
  }
}

//ToolTip
class JustToolTip extends StatelessWidget {
  const JustToolTip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      isModal: true,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black87,
      shadow: BoxShadow(
        color: Colors.black.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(2, 2), // Desplazamiento de la sombra en el eje Y
      ),
      content: Container(
        padding: const EdgeInsets.all(8.0),
        height: 100,
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.show_chart_rounded,
                  color: Colors.green,
                ),
                Text('${S.of(context).labelLineaVerde} 30 km/h'),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.show_chart_rounded,
                  color: Colors.yellow,
                ),
                Text('${S.of(context).labelLineaAmarilla} 80 km/h'),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.show_chart_rounded,
                  color: Colors.red,
                ),
                Text('${S.of(context).labelLineaRoja} 80 km/h'),
              ],
            ),
          ],
        ),
      ),
      child: const Icon(
        Icons.help,
      ),
    );
  }
}

//Alertas
class OverviewAlerts extends StatefulWidget {
  const OverviewAlerts({
    super.key,
    required this.screenWidth,
    required this.alerts,
    required this.dateFrom,
    required this.dateTo,
    required this.idDevice,
  });

  final double screenWidth;
  final AlertResponse alerts;
  final String dateFrom;
  final String dateTo;
  final String idDevice;

  @override
  State<OverviewAlerts> createState() => _OverviewAlertsState();
}

class _OverviewAlertsState extends State<OverviewAlerts> {
  AlertResponse? _futureAlerts;
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  DeviceProvider? deviceProvider;
  int page = 1;

  @override
  void initState() {
    super.initState();
    deviceProvider = context.read<DeviceProvider>();

    _initData();
  }

  Future<void> _initData() async {
    if (widget.alerts.items.data.isNotEmpty) {
      scrollController.addListener(() {
        if ((scrollController.position.pixels + 200) >=
            scrollController.position.maxScrollExtent) {
          if (widget.alerts.items.data.length >= 30 &&
              widget.alerts.items.lastPage > deviceProvider!.page) {
            fetchData();
          }
        }
      });
    }
  }

  Future fetchData() async {
    if (isLoading) return;

    isLoading = true;

    deviceProvider!.page++;

    setState(() {});

    _futureAlerts = await Provider.of<DeviceProvider>(context, listen: false)
        .getAlerts(
            from: widget.dateFrom,
            to: widget.dateTo,
            deviceId: widget.idDevice,
            page: deviceProvider!.page);

    widget.alerts.items.data = [
      ...widget.alerts.items.data,
      ..._futureAlerts!.items.data
    ];

    isLoading = false;

    setState(() {});

    if (scrollController.position.pixels + 100 <=
        scrollController.position.maxScrollExtent) return;

    scrollController.animateTo(scrollController.position.pixels + 120,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    scrollController.dispose();
    deviceProvider!.page = 1;
    _futureAlerts = null;
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mapRecordController = context.read<MapRecordController>();

    return (widget.alerts.items.data.isEmpty)
        ? Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sd_card_alert_outlined,
                size: (widget.screenWidth * 30) / 100,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(S.of(context).labelSinAlertas)),
            ],
          )
        : Stack(
            children: [
              CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                      // you could add any widget
                      child: Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        overviewAlertsText(S.of(context).labelAlerta, context,
                            isTitle: true),
                        overviewAlertsText(S.of(context).labelFecha, context,
                            isTitle: true),
                        overviewAlertsText(
                            S.of(context).labelDireccion, context,
                            isTitle: true),
                      ],
                    ),
                  )),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return InkWell(
                          onTap: () {
                            final LatLng position = LatLng(
                                widget.alerts.items.data[index].latitude,
                                widget.alerts.items.data[index].longitude);

                            //Agregar nuevo markador seleccionado
                            mapRecordController.setAlertSelected(
                                widget.alerts.items.data[index].id.toString());

                            //Mover posición de la camara
                            mapRecordController.moveCameraPosition(position);

                            //Abrir marcador
                            mapRecordController.addCustomInfoWindow(position,
                                speed: widget.alerts.items.data[index].speed
                                    .toString(),
                                altitude:
                                    widget.alerts.items.data[index].altitude,
                                time: widget.alerts.items.data[index].time);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: (mapRecordController.getAlertSelected ==
                                      widget.alerts.items.data[index].id
                                          .toString())
                                  ? Colors.green
                                  : null,
                            ),
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                overviewAlertsText(
                                    widget.alerts.items.data[index].message,
                                    context),
                                overviewAlertsText(
                                    widget.alerts.items.data[index].time,
                                    context),
                                overviewAlertsText(
                                    widget.alerts.items.data[index].address ??
                                        '',
                                    context),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: widget.alerts.items.data.length,
                    ),
                  ),
                ],
              ),
              if (isLoading)
                Positioned(
                    bottom: 40,
                    left: size.width * 0.5 - 25,
                    child: const CircularProgressIndicator()),
            ],
          );
  }

  SizedBox overviewAlertsText(String title, BuildContext context,
      {bool isTitle = false}) {
    return SizedBox(
        width: (widget.screenWidth * 30) / 100,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: (isTitle) ? FontWeight.bold : FontWeight.normal),
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          textAlign: (isTitle) ? TextAlign.center : null,
        ));
  }
}

//Detalles
class DetalleDispositivo extends StatelessWidget {
  const DetalleDispositivo({
    super.key,
    required this.listItem,
  });
  final List<DeviceDetailsItem> listItem;

  @override
  Widget build(BuildContext context) {
    final mapRecordController =
        Provider.of<MapRecordController>(context, listen: false);
    return Scrollbar(
      interactive: true,
      child: ListView.builder(
          primary: true,
          shrinkWrap: true,
          itemCount: listItem.length,
          itemBuilder: (_, index) {
            String status = '';
            String asset = '';

            switch (listItem[index].status) {
              case 1:
                status = S.of(context).labelConduccion;
                asset = 'assets/icon/status/route_drive.png';
                break;
              case 2:
                status = S.of(context).labelParada;
                asset = 'assets/icon/status/route_stop.png';
                break;
              case 3:
                status = S.of(context).labelInicio;
                asset = 'assets/icon/status/route_start.png';
                break;
              case 4:
                status = S.of(context).labelFinDeConduccion;
                asset = 'assets/icon/status/route_end.png';
                break;
              case 5:
                status = S.of(context).labelEvento;
                asset = 'assets/icon/status/route_event.png';
                break;
              default:
            }
            return GestureDetector(
              onTap: () {
                final LatLng position = LatLng(
                    listItem[index].items[0].lat, listItem[index].items[0].lng);

                //Agregar nuevo markador seleccionado
                mapRecordController
                    .setElementSelected(listItem[index].items[0].id.toString());

                //Mover posición de la camara
                mapRecordController.moveCameraPosition(position);

                //Abrir marcador
                mapRecordController.addCustomInfoWindow(position,
                    speed: listItem[index].items[0].speed.toString(),
                    altitude: listItem[index].items[0].altitude,
                    driver: listItem[index].driver,
                    showTime: listItem[index].show,
                    leftTime: listItem[index].left,
                    time: listItem[index].time);
              },
              child: Container(
                // margin: const EdgeInsets.only(bottom: 5,),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: (mapRecordController.getElementSelected ==
                          listItem[index].items[0].id.toString())
                      ? Colors.green
                      : Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.grey[900],
                  border: const Border(
                    // top: BorderSide(width: 1.0, color: Colors.grey),
                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailsText(
                        title: status,
                        suFix: '',
                        fontSize: 4,
                        asset: asset,
                        position: LatLng(listItem[index].items[0].lat,
                            listItem[index].items[0].lng)),

                    (listItem[index].time != null)
                        ? Text(
                            '${S.of(context).labelTiempo}: ${listItem[index].time}')
                        : Container(),

                    DetailsText(
                      title: S.of(context).labelDistancia,
                      val: '${listItem[index].distance}',
                      suFix: 'km',
                    ),

                    (listItem[index].show.isNotEmpty)
                        ? DetailsText(
                            title: S.of(context).labelInicio,
                            val: listItem[index].show,
                            suFix: '')
                        : Container(),

                    (listItem[index].left != null)
                        ? (listItem[index].rawTime.isNotEmpty)
                            ? DetailsText(
                                title: S.of(context).labelFinalizo,
                                val: listItem[index].left,
                                suFix: '')
                            : Container()
                        : Container(),

                    (listItem[index].message != null)
                        ? (listItem[index].rawTime.isNotEmpty)
                            ? DetailsText(
                                title: S.of(context).mensaje,
                                val: listItem[index].message,
                                suFix: '')
                            : Container()
                        : Container(),

                    // const Divider()
                  ],
                ),
              ),
            );
          }),
    );
  }
}

//Resumen
class ResumenDispositivo extends StatelessWidget {
  const ResumenDispositivo({
    super.key,
    required this.topSpeed,
    required this.distanceSum,
    required this.stopDuration,
    required this.moveDuration,
  });

  final String topSpeed;
  final String distanceSum;
  final String stopDuration;
  final String moveDuration;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      // color: Colors.black12,
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ResumenItem(
                asset: 'assets/icon/dashboard.svg',
                title: topSpeed,
                subTitle: S.of(context).labelVelocidadMaxima,
                color: Theme.of(context).brightness == Brightness.light
                    ? null
                    : Colors.white,
              ),
              ResumenItem(
                asset: 'assets/icon/line-chart.svg',
                title: distanceSum,
                subTitle: S.of(context).labelDistancia,
                color: Theme.of(context).brightness == Brightness.light
                    ? null
                    : Colors.white,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ResumenItem(
                asset: 'assets/icon/engine_off.svg',
                title: stopDuration,
                subTitle: S.of(context).labelMotorInactivo,
                color: Theme.of(context).brightness == Brightness.light
                    ? null
                    : Colors.white,
              ),
              ResumenItem(
                asset: 'assets/icon/043-steering wheel.svg',
                title: moveDuration,
                subTitle: S.of(context).labelConductor,
                color: Theme.of(context).brightness == Brightness.light
                    ? null
                    : Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ResumenItem extends StatelessWidget {
  const ResumenItem({
    super.key,
    required this.asset,
    required this.title,
    required this.subTitle,
    this.color,
  });
  final String asset;
  final String title;
  final String subTitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: (screenWidth * 45) / 100,
      // color: Colors.amber.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgIcon(
            asset: asset,
            width: 30,
            color: color,
          ),
          Column(
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                subTitle,
              ),
              const Divider()
            ],
          ),
        ],
      ),
    );
  }
}
