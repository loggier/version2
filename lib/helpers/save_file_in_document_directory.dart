// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';

// class PDFApi{  
//   static Future<File> safeFileInDocumentDirectory(String url, List<int> bytes) async {
//     final fileName = basename(url);
//     final dir = await getApplicationDocumentsDirectory();
  
//     final file = File('${dir.path}/$fileName');
//     await file.writeAsBytes(bytes, flush: true);
// print(file.path);
//     return file;
//   }
// }