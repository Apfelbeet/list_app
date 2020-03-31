import 'package:flutter/cupertino.dart';
import 'package:list_app/blueprints.dart';
import 'package:provider/provider.dart';

import 'blueprints.dart';
import 'data.dart';

/// Display list of all content
class DefaultBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (content, data, child) {
        return ListView(
          children: mapDataModels(context, data),
        );
      },
    );
  }

  ///Converts a list of content models into a 300 entry list of corresponding flutter widgets
  List<Widget> mapDataModels(BuildContext context, Data data) {
    //list of empty entries
    List<Widget> empty =
        List.generate(300, (index) => EmptyDefaultCard(index: index));

    //replace empty entries with actual content
    data.content.forEach((element) {
      empty.removeAt(element.index);
      empty.insert(element.index, element.toWidget(context));
    });

    return empty;
  }
}
