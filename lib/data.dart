import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:list_app/models.dart';
import 'package:list_app/storage.dart';


///Runtime database:
/// - Loads all stored data at the beginning
/// - Stores all new data in a permanently file (JSON)
/// - Notifies all important GUI-components if the data changes
class Data extends ChangeNotifier {

  ///List of content
  List<ContentModel> content = <ContentModel>[];

  ///Load storage file and convert all json objects into DataModels
  Data() {

    Storage.read().then((value) {

      content = (jsonDecode(value) as List)
          .map((e) => ContentModel.ofJson(e))
          .where((e) => e != null).toList();

      refresh();
    });
  }

  ///Finds in the content list the actual index of the object,
  ///which has the given index
  int findListIndex(int index) {
    return content.indexWhere((e) => e.index == index);
  }

  ///Replaces an existing contentModel at the given list index with new content
  ///and stores the new data permanently
  replace(int listIndex, ContentModel model) {
    content[listIndex] = model;
    refresh();
  }

  ///Replaces an existing contentModel with the given index with new content,
  ///if there is no content with this index, the new content will just stored.
  ///All new data will be stored permanently
  replaceOrAddNew(int index, ContentModel model) {
    int i = findListIndex(index);
    if (i == -1) {
      content.add(model);
      refresh();
    } else
      replace(i, model);
  }


  ///Removes the content model with the given index
  remove(int index) {
    int i = findListIndex(index);
    content.removeAt(i);
    refresh();
  }


  ///Returns the content model with the given index,
  ///if there is no content model with this id, null will be returned.
  ContentModel get(int index) {
    int i = findListIndex(index);
    return i == -1 ? null : content[i];
  }


  ///Notifies all Consumer-Widgets and stores data as json in storage-file
  refresh() {
    notifyListeners();
    Storage.save(jsonEncode(content));
  }
}
