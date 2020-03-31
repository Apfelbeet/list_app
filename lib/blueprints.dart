import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:list_app/models.dart';
import 'package:provider/provider.dart';

import 'data.dart';
import 'input.dart';

///default Card that manages user gestures
///and is supposed to be the underlying widget for widget that display a ContentModel
class DefaultCard extends StatelessWidget {

  ///widget that will be displayed inside of the card
  final Widget child;

  ///index of the corresponding ContentModel
  final int index;

  ///will be called if the user tapped on the card
  final Function onTap;

  DefaultCard({
    @required this.index,
    @required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap(context);
        },
        child: Card(
            color: getColorByIndex(),
            elevation: 2.0,
            child: ListTile(
              leading: Text(index.toString()),
              title: child,
            )));
  }

  Color getColorByIndex() {
    switch (index % 3) {
      case 0:
        return Colors.white;
      case 1:
        return Colors.red;
      case 2:
        return Colors.blue;
      default:
        return Colors.white;
    }
  }
}

///Template-Card that indicates that there is no entry with the corresponding id
class EmptyDefaultCard extends DefaultCard {
  EmptyDefaultCard({@required index})
      : super(
          index: index,
          child: Text("No Entry"),
          onTap: (context) {
            Input.chooseNewEntryTypModalBottomSheet(context, index);
          },
        );
}

///Template for a round Icon with an descriptive text.
///icon, text and an ontap-action are assignable
class IconMenuItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final Function onTap;

  IconMenuItem({@required this.icon, @required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          width: 50,
          child: Column(
            children: <Widget>[
              Container(
                child: InkWell(
                  child: icon,
                  onTap: onTap,
                ),
                width: 50,
                height: 50,
                decoration: new BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
              ),
              Text(name, textAlign: TextAlign.center)
            ],
          ),
        ));
  }
}

///Template for an basic BottomSheet
class DefaultModalBottomSheet extends StatelessWidget {
  final Widget child;

  const DefaultModalBottomSheet({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: this.child));
  }
}




