import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/navigator_key.dart';
import 'package:prosecat/system/global.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({super.key, required this.filePath, required this.name});
  final String filePath;
  final String name;
  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final appName = GlobalVariables().appName;
  bool loading = false;
  double progress = 0;
  final Dio dio = Dio();

  Future<bool> saveFile(String url, String fileName) async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();

          String newPath = '';
          List<String> folders = directory!.path.split("/");
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != 'Android') {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/Download";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      if (await directory.exists()) {
        var time = DateTime.now().microsecondsSinceEpoch;
        File saveFile = File("${directory.path}/report $time.pdf");

        await dio.download(url, saveFile.path,
            onReceiveProgress: (downloaded, totalSize) {
          setState(() {
            progress = downloaded / totalSize;
          });
        });

        return true;
      }
    } catch (e) {
      return true;
    }
    return false;
  }

  //Pedir permiso de almacenamiento al usuario
  Future<bool> _requestPermission(Permission permission) async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;

    if (await permission.isGranted) {
      return true;
    } else {
      //Si el sdk version es mayor a 32 pedir permiso de fotos que incluye el almacenamiento ya que stora es deprecated
      if (deviceInfo.version.sdkInt > 32) {
        var result = await Permission.photos.request();

        if (result.isGranted) {
          return true;
        } else {
          return false;
        }
      } else {
        var result = await Permission.storage.request();
        if (result.isGranted) {
          return true;
        } else {
          return false;
        }
      }
    }
  }

  downloadFile() async {
    setState(() {
      loading = true;
    });

    bool downloaded = await saveFile(widget.filePath, widget.name);

    if (downloaded) {
      final snackBar = SnackBar(content: Text(S.current.archivoDescargado));
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
    } else {
      final snackBar =
          SnackBar(content: Text(S.current.problemasAlDescargarElArchivo));
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Stack(
        children: [
          const PDF(
            swipeHorizontal: true,
          ).cachedFromUrl(
              maxAgeCacheObject: const Duration(days: 1), widget.filePath),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: downloadFile,
          child: loading
              ? const CircularProgressIndicator()
              : const Icon(Icons.download_rounded)),
    );
  }
}
