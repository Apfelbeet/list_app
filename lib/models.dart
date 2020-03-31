import 'dart:io';
import 'blueprints.dart';
import 'package:flutter/cupertino.dart';
import 'package:list_app/blueprints.dart';

import 'input.dart';


///ContentModel describes all Data, that should be displayed for the User.
///Every ContentModel has an index, that specifies where in the list it will be displayed
abstract class ContentModel {

  ///position in the list
  int index;

  ContentModel({@required this.index});

  ///convert data of this model into an actual displayable widget.
  ///this widget will be displayed in a ListView:
  ///make sure the returned widget is compatible
  Widget toWidget(BuildContext context);

  ///convert model data to json
  Map<String, dynamic> toJson();

  ///create ContenModel of jsonData
  ///null will be returned if the type is unknown
  static ContentModel ofJson(Map<String, dynamic> json) {
    if(json['type'] == 'text') {
      return TextModel(index: json['index'], text: json['text']);
    }else if(json['type'] == 'image') {
      return ImageModel(index: json['index'], resource: File(json['resource']));
    }else
    {
      return null;
    }
  }
}

///TextModel is a ContentModel, that manages text input
class TextModel extends ContentModel {

  String text;

  TextModel({@required index, @required this.text}): super(index: index);
  
  @override
  Widget toWidget(BuildContext context) {
    return DefaultCard(
      index: this.index,
      child: Padding(
        child: Text(this.text),
        padding: EdgeInsets.all(4.0),
      ),
      onTap: (context) {Input.textInputModalBottomSheet(context, this.index);},
    );
  }

  Map<String, dynamic> toJson() => {
    'index': index,
    'type': "text",
    'text': text,
  };
}

///ImageModel manages images from the gallery or camera and stores the according path
class ImageModel extends ContentModel {

  File resource;

  ImageModel({@required index, this.resource}): super(index: index);

  @override
  Widget toWidget(BuildContext context) {
    return DefaultCard(
      index: this.index,
      child: resource != null ? Image.file(resource)
          : Text("loading error"),
      onTap: (context) {Input.chooseNewImageTypModalBottomSheet(context, this.index);},
    );
  }

  Map<String, dynamic> toJson() => {
    'index': index,
    'type': "image",
    'resource': resource.path,
  };
}