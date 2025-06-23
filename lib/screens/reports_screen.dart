// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/navigator_key.dart';
import 'package:prosecat/models/models.dart';
import 'package:prosecat/providers/providers.dart';
import 'package:prosecat/providers/reports_provider.dart';
import 'package:prosecat/screens/pdf_viewer_page.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import '../preferences/preference.dart';
import '../ui/ui.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<int> validReportIds = [1, 3, 4, 5, 31];
    double screenWidth = MediaQuery.of(context).size.width;
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    final reportsProvider = Provider.of<ReportsProvider>(context);

    List<Item> items = [];

    for (var value in deviceProvider.devicesResponse) {
      for (var element in value.items) {
        items.add(element);
      }
    }

    String? lang;

    lang = Preferences.idioma == ''
        ? Localizations.localeOf(context).toString()
        : Preferences.idioma.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).informe),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: reportsProvider.recordKey,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: (screenWidth * 90) / 100,
                    // height: (screenHeight * 25) / 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Seleccionar tipo de informe
                        FutureBuilder(
                            future: deviceProvider.getReports(),
                            builder: (context, asyncSnapshot) {
                              if (asyncSnapshot.hasData) {
                                final typeReports =
                                    asyncSnapshot.data!.reportItems!.types;
                                return DropdownButtonFormField<String>(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  value: reportsProvider.getReportTypeSelected,
                                  isExpanded: true,
                                  hint: Text(S.of(context).tipoDeInforme),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: S.of(context).tipoDeInforme,
                                      labelStyle: TextStyle(
                                          color: Colors.grey.shade700)),
                                  items: [
                                    ...typeReports!
                                        .where((report) =>
                                            validReportIds.contains(report.id))
                                        .map((report) => DropdownMenuItem(
                                            value: report.id.toString(),
                                            child:
                                                Text(report.title.toString())))
                                  ],
                                  onChanged: (value) {
                                    if (value != null) {
                                      reportsProvider.reportTypeSelected =
                                          value;
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return S
                                          .of(context)
                                          .errorSeleccioneUnInforme;
                                    }
                                    return null;
                                  },
                                );
                              } else if (asyncSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SkeletonLine();
                              } else {
                                return Text(
                                    S.of(context).errorAlObtenerLosInformes);
                              }
                            }),

                        const Divider(),

                        //Limite de velocidad
                        reportsProvider.getReportTypeSelected == '5'
                            ? TextFormField(
                                initialValue: '100',
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                decoration:
                                    DecorationInputs.authDecorationInput(
                                        context,
                                        labelText:
                                            S.of(context).labelVelocidadMaxima,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none),
                                onChanged: (value) =>
                                    reportsProvider.setSpeedLimit = value,
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return S.of(context).ingreseUnValor;
                                  }
                                  return null;
                                },
                              )
                            : const SizedBox(),

                        reportsProvider.getReportTypeSelected == '5'
                            ? const Divider()
                            : const SizedBox(),

                        //Geocercas
                        reportsProvider.getReportTypeSelected == '31'
                            ? FutureBuilder(
                                future: deviceProvider.getGeofences(),
                                builder: (context, asyncSnapshot) {
                                  if (asyncSnapshot.hasData) {
                                    final Map<int, Map<String, dynamic>> data =
                                        asyncSnapshot.data!;

                                    return DropdownButtonFormField<String>(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      // value: reportsProvider.getReportTypeSelected,
                                      isExpanded: true,
                                      hint: Text(S.of(context).labelRutas),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: S.of(context).labelRutas,
                                          labelStyle: TextStyle(
                                              color: Colors.grey.shade700)),
                                      items: data.entries
                                          .map<DropdownMenuItem<String>>(
                                              (entry) {
                                        final Map<String, dynamic> value =
                                            entry.value;
                                        return DropdownMenuItem(
                                            value: value['id'].toString(),
                                            child: Text(value['name']));
                                      }).toList(),
                                      onChanged: (value) =>
                                          reportsProvider.setGeofence = value,
                                      validator: (value) {
                                        if (value == null) {
                                          return S
                                              .of(context)
                                              .seleccioneUnValor;
                                        }
                                        return null;
                                      },
                                    );
                                  } else if (asyncSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SkeletonLine();
                                  } else {
                                    return Text(S
                                        .of(context)
                                        .errorAlObtenerLosInformes);
                                  }
                                })
                            : const SizedBox(),

                        reportsProvider.getReportTypeSelected == '31'
                            ? const Divider()
                            : const SizedBox(),

                        //Tipo de documento
                        DropdownButtonFormField<String>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          value: '0',
                          isExpanded: false,
                          hint: Text(S.of(context).tipoDeDocumento),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: S.of(context).tipoDeDocumento,
                              labelStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                          items: const [
                            DropdownMenuItem(value: '0', child: Text('PDF')),
                            DropdownMenuItem(value: '1', child: Text('HTML'))
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              reportsProvider.documentTypeSelected = value;
                            }
                          },
                          validator: (value) {
                            if (value == null) {
                              return S.of(context).errorSeleccioneUnDocumento;
                            }
                            return null;
                          },
                        ),

                        const Divider(),

                        //Seleccionar un dispositivo
                        DropdownButtonFormField<String>(
                          value: reportsProvider.getDeviceSelected,
                          autovalidateMode: AutovalidateMode.always,
                          isExpanded: false,
                          hint: Text(S.of(context).vehiculos),
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
                              reportsProvider.deviceSelected = value;
                            }
                          },
                        ),

                        const Divider(),
                        //Seleccionar fecha inicial
                        DateTimeField(
                          dateFormat: DateFormat('d MMM y HH:mm', lang),
                          style: const TextStyle(fontSize: 15),
                          decoration:
                              DateTimeDecorationUi.dateTimeDecorationAll(
                            labelText: S.of(context).labelDesde,
                          ),
                          mode: DateTimeFieldPickerMode.dateAndTime,
                          initialPickerDateTime:
                              DateTime.parse(reportsProvider.getDateFrom()),
                          onChanged: (value) {
                            final dateFormatter =
                                DateFormat('yyyy-MM-dd HH:mm:ss');

                            DateTime parsedDateTo = dateFormatter
                                .parse(reportsProvider.getDateTo());
                            DateTime parsedDateFrom = dateFormatter
                                .parse(reportsProvider.getDateFrom());

                            if (value != parsedDateFrom) {
                              reportsProvider.setDateFrom = value!;
                            }

                            parsedDateTo = DateTime(
                                parsedDateTo.year,
                                parsedDateTo.month,
                                parsedDateTo.day,
                                parsedDateTo.hour,
                                parsedDateTo.minute,
                                parsedDateTo.second);

                            if (value!.isAfter(parsedDateTo)) {
                              reportsProvider.setDateTo = DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                59, // Hora
                                59, // Minuto
                                00, // Segundo
                              );
                            }

                            reportsProvider.setDateFrom = value;
                          },
                        ),
                        const Divider(),

                        //Seleccionar fecha final
                        DateTimeField(
                          dateFormat: DateFormat('d MMM y HH:mm', lang),
                          style: const TextStyle(fontSize: 15),
                          initialPickerDateTime:
                              DateTime.parse(reportsProvider.getDateTo()),
                          decoration:
                              DateTimeDecorationUi.dateTimeDecorationAll(
                            labelText: S.of(context).labelHasta,
                          ),
                          mode: DateTimeFieldPickerMode.dateAndTime,
                          onChanged: (value) {
                            final dateFormatter =
                                DateFormat('yyyy-MM-dd HH:mm:ss');

                            DateTime parsedDateFrom = dateFormatter
                                .parse(reportsProvider.getDateFrom());
                            DateTime parsedDateTo = dateFormatter
                                .parse(reportsProvider.getDateTo());

                            if (value != parsedDateTo) {
                              reportsProvider.setDateTo = value!;
                            }

                            if (value!.isBefore(parsedDateFrom)) {
                              // Establecer DateFrom a la fecha actual con hora 00:00
                              reportsProvider.setDateFrom = DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                0, // Hora
                                0, // Minuto
                                0, // Segundo
                              );

                              // Establecer DateTo a la fecha actual con hora 23:59
                              reportsProvider.setDateTo = DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                23, // Hora
                                59, // Minuto
                                59, // Segundo
                              );
                              return;
                            }
                            reportsProvider.setDateTo = value;
                          },
                        ),
                        const Divider(),

                        const SizedBox(height: 20),

                        CustomMaterialButton(
                            label: S.of(context).consultar,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            onPressed: (reportsProvider.getIsLoading)
                                ? null
                                : () async {
                                    if (!reportsProvider.isValidForm()) return;

                                    reportsProvider.setIsLoading = true;
                                    try {
                                      final response =
                                          await deviceProvider.generateReports(
                                              reportsProvider.getDeviceSelected,
                                              reportsProvider.dateFrom,
                                              reportsProvider.dateTo,
                                              reportsProvider
                                                  .getReportTypeSelected!,
                                              reportsProvider
                                                  .getDocumentTypeSelected,
                                              speedLimit: reportsProvider
                                                          .getReportTypeSelected ==
                                                      '5'
                                                  ? reportsProvider
                                                      .getSpeedLimit
                                                  : null,
                                              geofence: reportsProvider
                                                          .getReportTypeSelected ==
                                                      '31'
                                                  ? reportsProvider.getGeofence
                                                  : null);

                                      if (response.status != 3) {
                                        reportsProvider.setIsLoading = false;
                                        return await showMyDialog(
                                            navigatorKey.currentContext!,
                                            S.current.mensaje,
                                            S.current.errorSinDatos,
                                            S.current.aceptarMensaje);
                                      }
                                      Navigator.of(navigatorKey.currentContext!)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  PdfViewerPage(
                                                    filePath: response.url!,
                                                    name:
                                                        reportsProvider
                                                                .getDeviceSelected +
                                                            '(' +
                                                            reportsProvider
                                                                .dateFrom
                                                                .toString() +
                                                            ')' +
                                                            reportsProvider
                                                                .dateTo
                                                                .toString(),
                                                  )));
                                      // await launchUrlToExternalApp(response.url!);
                                      // final file = await PDFApi.safeFileInDocumentDirectory(response.url!, response.bytes);

                                      // file.rename(reportsProvider.getDeviceSelected + '(' + reportsProvider.dateFrom.toString() + ')' + reportsProvider.dateTo.toString());

                                      // openPDF(navigatorKey.currentContext!, file.path);

                                      reportsProvider.setIsLoading = false;
                                    } catch (e) {
                                      reportsProvider.setIsLoading = false;
                                    }
                                  }),

                        const SizedBox(height: 10),

                        CustomMaterialButton(
                          label: S.of(context).labelCancelar,
                          backgroundColor: Colors.grey.shade800,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (reportsProvider.getIsLoading) buildLoadingSpin()
          ],
        ),
      ),
    );
  }

  // openPDF(BuildContext context, String filePath){
  //   return Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => PdfViewerPage(filePath: filePath)
  //     )
  //   );

  // }
}
