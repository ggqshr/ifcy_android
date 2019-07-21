import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialogAction {
  BuildContext context;

  LoadingDialogAction(this.context);

  showLoadingDialog([String text2show = ""]) {
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
    Navigator.of(context).pop();
  }
}

LoadingDialogAction loadingDialogAction;
