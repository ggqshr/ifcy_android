import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialogAction {
  BuildContext context;

  LoadingDialogAction(this.context);

  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          children: <Widget>[
            Container(
              child: SpinKitPouringHourglass(color: Colors.blue),
            )
          ],
          shape: CircleBorder(),
        );
      },
    );
  }

  cancleLoadingDialog() {
    Navigator.of(context).pop();
  }
}

LoadingDialogAction loadingDialogAction;
