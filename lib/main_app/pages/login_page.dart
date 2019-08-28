import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/main_app/blocs/login/bloc.dart';
import 'package:ifcy/main_app/blocs/main_app_blocs.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/main_app/pages/select_project_page.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
import 'package:ifcy/main_app/thunk/main_app_thunk.dart';
import 'package:ifcy/common/utils/loading.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode userNameFocusNode;
  FocusNode passWordFocusNode;
  TextEditingController userNameController;
  TextEditingController passWordController;
  LoginBloc loginBloc;

  bool isLoginButtonEnable(LoginState state) =>
      state.isPasswordValid && state.isUserNameValid;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc(
        userLoginRepositories:
            RepositoryProvider.of<UserLoginRepositories>(context),
        authorizationBloc: BlocProvider.of<AuthorizationBloc>(context));
    passWordController = TextEditingController()..addListener(_changePW);
    userNameController = TextEditingController()..addListener(_changeUN);
    userNameFocusNode = new FocusNode();
    passWordFocusNode = new FocusNode();
  }

  void _changePW() {
    loginBloc.dispatch(PasswordChanged(password: passWordController.text));
  }

  void _changeUN() {
    loginBloc.dispatch(UserNameChanged(userName: userNameController.text));
  }

  @override
  void dispose() {
    super.dispose();
    passWordController.dispose();
    userNameController.dispose();
    userNameFocusNode.dispose();
    passWordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Login Failure'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Logging In...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: loginBloc,
          builder: (context, state) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                userNameFocusNode.unfocus();
                passWordFocusNode.unfocus();
              },
              child: Container(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        autofocus: true,
                        controller: userNameController,
                        focusNode: userNameFocusNode,
                        decoration: InputDecoration(
                          labelText: "请输入用户名",
                          hintText: "用户名",
                          prefixIcon: Icon(Icons.verified_user),
                          errorStyle: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                        validator: (_) => state.isUserNameValid ? null : "请输入用户名",
                        keyboardType: TextInputType.text,
                        autovalidate: true,
                      ),
                      TextFormField(
                        autovalidate: true,
                        focusNode: passWordFocusNode,
                        controller: passWordController,
                        decoration: InputDecoration(
                          labelText: "请输入密码",
                          hintText: "密码",
                          prefixIcon: Icon(Icons.vpn_key),
                          errorStyle: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (_) => state.isPasswordValid ? null : "请输入密码",
                      ),
                      RaisedButton(
                        child: Text("登陆"),
                        onPressed: isLoginButtonEnable(state)
                            ? () {
                          userNameFocusNode.unfocus();
                          passWordFocusNode.unfocus();
                          loginBloc.dispatch(LoginWithCredentialsPressed(
                              username: userNameController.text,
                              password: passWordController.text));
                        }
                            : null,
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                height: double.maxFinite,
              ),
            );
          },
        ),
      ),
    );
  }
}
