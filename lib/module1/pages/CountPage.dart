import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/module1/model/Moudle1Model.dart';
import 'package:redux/redux.dart';

import 'AsyncPage.dart';

class CountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: StoreConnector<Moudle1Model, int>(
          converter: (Store<Moudle1Model> store) {
            return store.state.count;
          },
          builder: (context, count) {
            return Text("you hit me $count times");
          },
        ),
      ),
    );
  }
}
