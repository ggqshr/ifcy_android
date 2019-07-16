import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/module1/model/Moudle1Model.dart';
import 'package:redux/redux.dart';
import 'package:ifcy/module1/thunk/MoudleThunkAction.dart';

class AsyncPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StoreConnector<Moudle1Model, AsyncModel>(
        converter: (Store<Moudle1Model> store) {
          return AsyncModel(
              showText: store.state.showText,
              getDelayDataCall: () {
                store.dispatch(GetdelayDataAction);
              },
              text2show: store.state.text2show);
        },
        builder: (_, AsyncModel model) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("点击按钮后，5秒后才拿到数据"),
              model.showText
                  ? Text(model.text2show)
                  : LinearProgressIndicator(
                      backgroundColor: Colors.blue,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
              RaisedButton(
                child: Text("点击开始请求"),
                onPressed: () => model.getDelayDataCall(),
              )
            ],
          );
        },
      ),
    );
  }
}
