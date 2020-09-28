import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/main_app/blocs/login/bloc.dart';
import 'package:ifcy/main_app/blocs/main_app_blocs.dart';
import 'package:ifcy/main_app/blocs/remember_bloc/remember_bloc.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';

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
  RememberBloc rememberBloc;

  bool isLoginButtonEnable(LoginState state) =>
      state.isPasswordValid && state.isUserNameValid;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc(
        userLoginRepositories:
            RepositoryProvider.of<UserLoginRepositories>(context),
        authorizationBloc: BlocProvider.of<AuthorizationBloc>(context));
    rememberBloc =
        RememberBloc(RepositoryProvider.of<UserLoginRepositories>(context));
    passWordController = TextEditingController()..addListener(_changePW);
    userNameController = TextEditingController()..addListener(_changeUN);
    userNameFocusNode = new FocusNode();
    passWordFocusNode = new FocusNode();
  }

  void _changePW() {
    loginBloc.add(PasswordChanged(password: passWordController.text));
  }

  void _changeUN() {
    loginBloc.add(UserNameChanged(userName: userNameController.text));
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
      body: SingleChildScrollView(
        child: BlocListener<LoginBloc, LoginState>(
          bloc: loginBloc,
          listener: (context, state) {
            if (state.isFailure) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('登录失败'), Icon(Icons.error)],
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
                        Text('登录中'),
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                        ),
                        Image.asset(
                          "images/app_icon.png",
                          width: 100,
                          height: 100,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                        ),
                        TextFormField(
                          autofocus: true,
                          controller: userNameController,
                          focusNode: userNameFocusNode,
                          decoration: InputDecoration(
                            labelText: "请输入用户名",
                            hintText: "用户名",
                            prefixIcon: Icon(Icons.verified_user),
                            errorStyle:
                                TextStyle(color: Colors.red, fontSize: 18),
                            suffixIcon:
                                BlocBuilder<RememberBloc, RememberState>(
                              bloc: rememberBloc
                                ..add(FetchUserLoginInfosEvent()),
                              // ignore: missing_return
                              builder: (context, state) {
                                if (state is RememberInitial) {
                                  return DropdownButton(
                                    items: [],
                                    onChanged: null,
                                  );
                                }
                                if (state is RememberLoadedState) {
                                  return DropdownButton(
                                    underline: Container(),
                                    items: state.infos
                                        .map<DropdownMenuItem>(
                                            (item) => DropdownMenuItem(
                                                  value: item.username,
                                                  child: Text(item.username),
                                                ))
                                        .toList(),
                                    onChanged: (value) {
                                      int thisIndex = state.infos.indexWhere(
                                          (item) => item.username == value);
                                      LoginUserInfo thisInfo =
                                          state.infos[thisIndex];
                                      userNameController.text =
                                          thisInfo.username;
                                      passWordController.text =
                                          thisInfo.password;
                                      loginBloc.add(SelectExistsInfo(thisInfo));
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          validator: (_) =>
                              state.isUserNameValid ? null : "请输入用户名",
                          keyboardType: TextInputType.text,
                          autovalidate: true,
                        ),
                        TextFormField(
                          autovalidate: true,
                          focusNode: passWordFocusNode,
                          controller: passWordController,
                          obscureText: state.passwordVisible,
                          decoration: InputDecoration(
                            labelText: "请输入密码",
                            hintText: "密码",
                            prefixIcon: Icon(Icons.vpn_key),
                            errorStyle:
                                TextStyle(color: Colors.red, fontSize: 18),
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                //更新状态控制密码显示或隐藏
                                loginBloc.add(ChangePasswordShow());
                              },
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (_) =>
                              state.isPasswordValid ? null : "请输入密码",
                        ),
                        new Container(
                          height: 45.0,
                          margin: EdgeInsets.only(top: 40.0),
                          child: new SizedBox.expand(
                            child: new RaisedButton(
                              onPressed: isLoginButtonEnable(state)
                                  ? () {
                                      userNameFocusNode.unfocus();
                                      passWordFocusNode.unfocus();
                                      loginBloc.add(LoginWithCredentialsPressed(
                                          username: userNameController.text,
                                          password: passWordController.text));
                                    }
                                  : null,
                              color: Color.fromARGB(255, 61, 203, 128),
                              child: new Text(
                                '登录',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(45.0)),
                            ),
                          ),
                        ),
                      ],
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
//                height: double.maxFinite,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
