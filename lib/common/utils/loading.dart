import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ifcy/common/utils/utils.dart';

class LoadingDialogAction {
  BuildContext context;

  LoadingDialogAction(this.context);

  ///用来显示加载过度框的方法，
  ///[text2show]参数是显示在进度条下方的文字
  ///[newContext]用来更新context,为了应对之前初始化时的context已经不可用，在能够传入context时可以传入进行更新
  showLoadingDialog({String text2show = "", BuildContext newContext}) {
    if (newContext != null) {
      context = newContext;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: SpinKitPouringHourglass(color: Colors.blue),
                ),
                text2show == ""
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(text2show),
                      ),
              ],
              mainAxisSize: MainAxisSize.min,
            )
          ],
          shape: text2show == "" ? CircleBorder() : Border.all(),
        );
      },
    );
  }

  cancleLoadingDialog() {
    Application.navigatorKey.currentState.pop();
  }
}

LoadingDialogAction loadingDialogAction;
