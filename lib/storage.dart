import 'dart:io';

import 'package:path_provider/path_provider.dart';

///All function according to write or read permanent data
class Storage {

  ///get by os assigned path for this app
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  ///get storage file
  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/list.txt');
  }

  ///store json data in _localFile
  static void save(String jsonEncode) async{
    final f = await _localFile;
    f.writeAsString(jsonEncode);
  }

  ///read data from _localFile
  static Future<String> read() async {
    try{
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    }catch(e) {
      return "";
    }
  }
}