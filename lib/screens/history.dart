// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/navigator_key.dart';
import 'package:prosecat/models/models.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../preferences/preference.dart';
import '../ui/ui.dart';

class History extends StatelessWidget {
  final bool? isFromPageView;
  const History({super.key, this.isFromPageView});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final DeviceProvider device = Provider.of<DeviceProvider>(context);

    List<Item> items = [];

    for (var value in device.devicesResponse) {
      for (var element in value.items) {
        items.add(element);
      }
    }

    String? lang;

    lang = Preferences.idioma == ''
        ? Localizations.localeOf(context).toString()
        : Preferences.idioma.toString();

    return Scaffold(
      appBar: (isFromPageView ?? false)
          ? null
          : AppBar(
              title: GestureDetector(
                  onTap: () {
                    device.getRecordByDevice(
                        '2023-06-16', '00:00', '2023-06-16', '00:00', '3770');
                  },
                  child: Text(S.of(context).labelHistorial)),
            ),
      body: PopScope(
        onPopInvoked: (bool value) {
          Provider.of<DeviceProvider>(context, listen: false).resume();
        },
        child: SafeArea(
          child: Stack(
            children: [
              Form(
                key: device.recordKey,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: (screenWidth * 90) / 100,
                    // height: (screenHeight * 25) / 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Seleccionar un dispositivo
                        DropdownButtonFormField<String>(
                          // value: device.getDeviceSelected,
                          autovalidateMode: AutovalidateMode.always,
                          isExpanded: false,
                          hint: Text(S.of(context).labelDispositivos),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          items: [
                            for (var item in items)
                              DropdownMenuItem(
                                  value: item.id.toString(),
                                  child: Text(item.name)),
                          ],
                          validator: (value) {
                            if (value == null) {
                              return S.of(context).errorSeleccioneUnVehiculo;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null) {
                              device.setDeviceSelected = value;
                            }
                          },
                        ),
                        const Divider(),

                        //Seleccionar día
                        DropdownButtonFormField<String>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          value: device.getDaySelected,
                          isExpanded: false,
                          hint: Text(S.of(context).labelMostrarDia),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: S.of(context).labelMostrarDia,
                              labelStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                          items: [
                            DropdownMenuItem(
                                value: '0',
                                child: Text(S.of(context).haceSieteDias)),
                            DropdownMenuItem(
                                value: '1',
                                child: Text(S.of(context).haceTresDias)),
                            DropdownMenuItem(
                                value: '2', child: Text(S.of(context).ayer)),
                            DropdownMenuItem(
                                value: '3', child: Text(S.of(context).hoy)),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              device.setDaySelected = value;
                            }
                          },
                        ),
                        const Divider(),

                        //Seleccionar fecha inicial
                        DateTimeField(
                          dateFormat: DateFormat('d MMM y HH:mm', lang),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                          initialPickerDateTime:
                              DateTime.parse(device.getDateFrom()),
                          decoration:
                              DateTimeDecorationUi.dateTimeDecorationAll(
                            labelText: S.of(context).labelDesde,
                          ),
                          mode: DateTimeFieldPickerMode.dateAndTime,
                          value: DateTime.parse(device.getDateFrom()),
                          onChanged: (value) {
                            final dateFormatter =
                                DateFormat('yyyy-MM-dd HH:mm:ss');

                            DateTime parsedDateTo =
                                dateFormatter.parse(device.getDateTo());
                            DateTime parsedDateFrom =
                                dateFormatter.parse(device.getDateFrom());

                            if (value != parsedDateFrom) {
                              device.setDateFrom = value!;
                            }

                            parsedDateTo = DateTime(
                                parsedDateTo.year,
                                parsedDateTo.month,
                                parsedDateTo.day,
                                parsedDateTo.hour,
                                parsedDateTo.minute,
                                parsedDateTo.second);

                            if (value!.isAfter(parsedDateTo)) {
                               device.setDateTo = DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                59, // Hora
                                59, // Minuto
                                00, // Segundo
                              );
                            }

                            device.setDateFrom = value;
                          },
                        ),
                        const Divider(),

                        //Seleccionar fecha final
                        DateTimeField(
                          dateFormat: DateFormat('d MMM y HH:mm', lang),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                          initialPickerDateTime:
                              DateTime.parse(device.getDateTo()),
                          decoration:
                              DateTimeDecorationUi.dateTimeDecorationAll(
                            labelText: S.of(context).labelHasta,
                          ),
                          mode: DateTimeFieldPickerMode.dateAndTime,
                          value: DateTime.parse(device.getDateTo()),
                          onChanged: (value) {
                            final dateFormatter =
                                DateFormat('yyyy-MM-dd HH:mm:ss');

                            DateTime parsedDateFrom =
                                dateFormatter.parse(device.getDateFrom());
                            DateTime parsedDateTo =
                                dateFormatter.parse(device.getDateTo());

                            if (value != parsedDateTo) {
                              device.setDateTo = value!;
                            }

                            if (value!.isBefore(parsedDateFrom)) {
                              // Establecer DateFrom a la fecha actual con hora 00:00
                              device.setDateFrom = DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                0, // Hora
                                0, // Minuto
                                0, // Segundo
                              );

                              // Establecer DateTo a la fecha actual con hora 23:59
                              device.setDateTo = DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                23, // Hora
                                59, // Minuto
                                59, // Segundo
                              );
                              return;
                            }
                            device.setDateTo = value;
                          },
                        ),
                        const Divider(),

                        //Seleccionar ajustar a la carretera
                        DropdownButtonFormField<String>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          value: (device.getIsSetToRoad) ? '1' : '0',
                          isExpanded: false,
                          hint: Text(S.of(context).labelAjustarCarretera),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: S.of(context).labelAjustarCarretera),
                          items: [
                            DropdownMenuItem(
                                value: '0', child: Text(S.of(context).no)),
                            DropdownMenuItem(
                                value: '1', child: Text(S.of(context).si)),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              device.setIsSetToRoad = value;
                            }
                          },
                        ),
                        const Divider(),

                        const SizedBox(height: 20),

                        CustomMaterialButton(
                            label: S.of(context).labelMostrarHistorial,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            onPressed: (device.getIsLoading)
                                ? null
                                : () async {
                                    if (!device.isValidForm()) return;

                                    device.setIsLoading =
                                        true; // Inicia el loading

                                    try {
                                      // Preparar los parámetros
                                      String dateFrom =
                                          device.getDateOnlyFrom();
                                      String hourFrom = device.getHourFrom();
                                      String dateTo = device.getDateOnlyTo();
                                      String hourTo = device.getHourTo();
                                      String deviceSelected =
                                          device.getDeviceSelected;

                                      // Llamar al request principal
                                      final response =
                                          await device.getRecordByDevice(
                                        dateFrom,
                                        hourFrom,
                                        dateTo,
                                        hourTo,
                                        deviceSelected,
                                      );

                                      // Manejar respuesta nula (sin datos)
                                      if (response == null) {
                                        await showMyDialog(
                                          navigatorKey.currentContext!,
                                          S.current.mensaje,
                                          S.current.errorSinDatos,
                                          S.current.aceptarMensaje,
                                        );
                                      } else {
                                        // Llamar a la función getAlerts si hay datos
                                        await device.getAlerts(
                                          from: dateFrom,
                                          to: dateTo,
                                          deviceId: deviceSelected,
                                        );

                                        // Navegar a otra pantalla
                                        Navigator.pushNamed(
                                            navigatorKey.currentContext!,
                                            'history_details');
                                      }
                                    } catch (e, stackTrace) {
                                      print("Error al obtener datos: $e");
                                      print("Stack trace: $stackTrace");
                                    } finally {
                                      // Detener el loading al final del proceso, éxito o error
                                      device.setIsLoading = false;
                                    }
                                  }),

                        const SizedBox(height: 10),

                        CustomMaterialButton(
                          label: S.of(context).labelCancelar,
                          backgroundColor: Colors.grey.shade800,
                          onPressed: () {
                            device.deviceSelected = null;
                            device.setIsLoading = false;
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: IconButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, 'reports_screen'),
                              icon: Column(
                                children: [
                                  SvgIcon(
                                    asset: 'assets/icon/report.svg',
                                    width: 28,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? null
                                        : Colors.white,
                                  ),
                                  Text(S.of(context).generarInforme),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (device.getIsLoading) buildLoadingSpin()
            ],
          ),
        ),
      ),
    );
  }
}
