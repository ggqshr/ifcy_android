import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/main_app/pages/select_project_page.dart';
import 'package:ifcy/main_app/thunk/main_app_thunk.dart';
import 'package:ifcy/common/utils/loading.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatelessWidget {
  FocusNode userNameFocusNode;
  FocusNode passWordFocusNode;
  String userName;
  String passWord;
  TextEditingController userNameController;
  TextEditingController passWordController;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginPageModel>(
      converter: (Store<AppState> store) {
        return LoginPageModel(
          submitCall: (userName, passWord) {
            store.dispatch(loginSubmitAction(
              userName,
              passWord,
              () => Application.router.navigateTo(context, Routes.selectPage),
            ));
          },
          alertText: store.state.alertText,
        );
      },
      onInit: (store) {
        passWordController = TextEditingController()
          ..addListener(() {
            passWord = passWordController.text;
          });
        userNameController = TextEditingController()
          ..addListener(() {
            userName = userNameController.text;
          });
        userNameFocusNode = new FocusNode();
        passWordFocusNode = new FocusNode();
      },
      onDispose: (store) {
        passWordController.dispose();
        userNameController.dispose();
        userNameFocusNode.dispose();
        passWordFocusNode.dispose();
      },
      builder: (BuildContext context, vm) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            userNameFocusNode.unfocus();
            passWordFocusNode.unfocus();
          },
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  controller: userNameController,
                  focusNode: userNameFocusNode,
                  decoration: InputDecoration(
                    labelText: "请输入用户名",
                    hintText: "用户名",
                    prefixIcon: Icon(Icons.verified_user),
                    errorText: vm.alertText,
                    errorStyle: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  focusNode: passWordFocusNode,
                  controller: passWordController,
                  decoration: InputDecoration(
                    labelText: "请输入密码",
                    hintText: "密码",
                    prefixIcon: Icon(Icons.vpn_key),
                    errorText: vm.alertText,
                    errorStyle: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onSubmitted: (_) {
                    userNameFocusNode.unfocus();
                    passWordFocusNode.unfocus();
                    loadingDialogAction.showLoadingDialog();
                    vm.submitCall(userName, passWord);
                  },
                ),
                RaisedButton(
                  child: Text("登陆"),
                  onPressed: () {
                    userNameFocusNode.unfocus();
                    passWordFocusNode.unfocus();
                    loadingDialogAction.showLoadingDialog();
                    vm.submitCall(userName, passWord);
                  },
                ),
              ],
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            height: double.maxFinite,
          ),
        );
      },
    );
  }
}
