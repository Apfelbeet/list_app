import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'blueprints.dart';
import 'data.dart';
import 'models.dart';

///all menus for action the user might use
class Input {

  ///opens camera and applies the image to the ContentModel with the given index
  static void pickCameraImage(BuildContext context, int index) async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    Provider.of<Data>(context)
        .replaceOrAddNew(index, ImageModel(index: index, resource: image));
  }

  ///opens gallery and applies the chosen image to the ContentModel with the given index
  static void pickGalleryImage(BuildContext context, int index) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Provider.of<Data>(context)
        .replaceOrAddNew(index, ImageModel(index: index, resource: image));
  }

  ///opens a bottom-sheet with a textfield.
  ///If the user submits, the text will be applied to the ContentModel with the given index
  static void textInputModalBottomSheet(BuildContext context, int index) {
    ContentModel model = Provider.of<Data>(context).get(index);
    String text = model != null ? (model as TextModel).text : "";
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return DefaultModalBottomSheet(
            child: Padding(
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Enter a new text:")),
                  Card(
                    elevation: 2.0,
                    child: TextField(
                      controller: TextEditingController(text: text),
                      onChanged: (newText) {
                        text = newText;
                      },
                      autofocus: true,
                      minLines: 10,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      onSubmitted: (newText) {
                        Provider.of<Data>(context, listen: false).replaceOrAddNew(
                            index, new TextModel(index: index, text: newText));
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconMenuItem(
                      icon: Icon(Icons.arrow_forward),
                      name: "",
                      onTap: () {
                        Provider.of<Data>(context, listen: false).replaceOrAddNew(
                            index, new TextModel(index: index, text: text));
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.all(20.0),
            ),
          );
        });
  }

  ///opens an bottom-sheet with the option to choose between "camera" oder "gallery"
  static void chooseNewImageTypModalBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return DefaultModalBottomSheet(
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Wrap(
                    children: <Widget>[
                      IconMenuItem(
                          icon: Icon(Icons.camera),
                          name: "Camera",
                          onTap: () {
                            Navigator.of(context).pop();
                            pickCameraImage(context, index);
                          }),
                      IconMenuItem(
                          icon: Icon(Icons.photo),
                          name: "Gallery",
                          onTap: () {
                            Navigator.of(context).pop();
                            pickGalleryImage(context, index);
                          }),
                    ],
                  )));
        });
  }

  ///opens a bottom-sheet with the options "text" or "picture"
  static void chooseNewEntryTypModalBottomSheet(context, index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return DefaultModalBottomSheet(
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Wrap(
                    children: <Widget>[
                      IconMenuItem(
                          icon: Icon(Icons.text_fields),
                          name: "Text",
                          onTap: () {
                            Navigator.of(context).pop();
                            textInputModalBottomSheet(
                                context, index);
                          }),
                      IconMenuItem(
                          icon: Icon(Icons.photo),
                          name: "Picture",
                          onTap: () {
                            Navigator.of(context).pop();
                            chooseNewImageTypModalBottomSheet(context, index);
                          }),
                    ],
                  )));
        });
  }
}