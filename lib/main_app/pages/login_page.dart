import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/main_app/pages/select_project_page.dart';
import 'package:ifcy/main_app/thunk/main_app_thunk.dart';
import 'package:ifcy/common/utils/loading.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusNode userNameFocusNode = new FocusNode();
    FocusNode passWordFocusNode = new FocusNode();
    String userName;
    String passWord;

    return StoreConnector<AppState, LoginPageModel>(
      converter: (Store<AppState> store) {
        return LoginPageModel(
          submitCall: (userName, passWord) {
            store.dispatch(loginSubmitAction(
                userName,
                passWord,
                () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return SelectProjectPage();
                    }))));
          },
          alertText: store.state.alertText,
        );
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
                  onChanged: (v) {
                    userName = v;
                  },
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
                  onChanged: (v) {
                    passWord = v;
                  },
                  focusNode: passWordFocusNode,
                  decoration: InputDecoration(
                    labelText: "请输入密码",
                    hintText: "密码",
                    prefixIcon: Icon(Icons.vpn_key),
                    errorText: vm.alertText,
                    errorStyle: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onSubmitted: (_) => vm.submitCall(userName, passWord),
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
