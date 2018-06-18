import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return new File('$path/CiE.ics');
}

void writeFile(String s) async {
  final file = await _localFile;
  file.writeAsString(s);
}