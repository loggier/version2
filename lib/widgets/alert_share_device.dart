import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/preferences/preference.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/ui/ui.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share_plus/share_plus.dart';

onBasicAlertPressed(context, String name, int id) {
  final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);

  String? lang;

  lang = Preferences.idioma == ''
      ? Localizations.localeOf(context).toString()
      : Preferences.idioma.toString();

  var alertStyle = AlertStyle(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade100
          : Colors.grey.shade900,
      animationType: AnimationType.grow,
      isCloseButton: false,
      // isOverlayTapDismiss: false,
      descStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      animationDuration: const Duration(milliseconds: 200),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      buttonAreaPadding: EdgeInsets.zero,
      // constraints: BoxConstraints.expand(width: 300),
      //First to chars "55" represents transparency of color
      overlayColor: const Color(0x55000000),
      alertElevation: 0,
      alertAlignment: Alignment.center);
  Alert(
      style: alertStyle,
      context: context,
      title: "${S.of(context).tituloCompartir} $name",
      desc: S.of(context).labelSeleccioneLaFechaVigente,
      content: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            DateTimeFormField(
              dateFormat: DateFormat.yMMMd(lang),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              initialValue: deviceProvider.selectedDate,
              decoration: DateTimeDecorationUi.dateTimeDecorationAll(
                  suffixIcon: const Icon(Icons.calendar_month)),
              mode: DateTimeFieldPickerMode.date,
              autovalidateMode: AutovalidateMode.always,
              onChanged: (DateTime? value) {
                if (value != null) {
                  deviceProvider.setDate = value;
                }
              },
            ),
            DateTimeFormField(
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              initialValue: deviceProvider.selectedTime,
              decoration: DateTimeDecorationUi.dateTimeDecorationAll(
                  suffixIcon: const Icon(Icons.access_time)),
              mode: DateTimeFieldPickerMode.time,
              autovalidateMode: AutovalidateMode.always,
              // validator: (e) => (e?.day ?? 0) == 1 ? S.of(context).errorNoElPrimerDia : null,
              onChanged: (DateTime? value) {
                if (value != null) {
                  deviceProvider.setTime = value;
                }
              },
            ),
          ],
        ),
      ),
      buttons: [
        DialogButton(
          color: Colors.grey.shade100,
          onPressed: () => Navigator.pop(context),
          child: Text(
            S.of(context).labelCancelar,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        DialogButton(
          color: Colors.grey.shade100,
          onPressed: () async {
            final link = await deviceProvider.shareDevice(id);

            if (link == null) {
              Navigator.pop(context);
              return;
            }

            Navigator.pop(context);
            sharePressed(link);
          },
          child: Text(
            S.of(context).labelGenerarLink,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ]).show();
}

void sharePressed(String link) {
  Share.share(link);
}
