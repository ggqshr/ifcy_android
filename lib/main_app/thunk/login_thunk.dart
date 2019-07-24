part of "main_app_thunk.dart";

ThunkAction<AppState> loginSubmitAction(
    String userName, String passWord, Function navigatorCall) {
  return (Store<AppState> store) async {
    await Future.delayed(Duration(seconds: 1));
    store.dispatch(LoginSuccessAction(
      userName,
      ["test", "test1", "test2"],
      {"test": "1", "test1": "2", "test2": "3"},
      0,
    ));
    store.dispatch(InitPageStateAction.init());
    loadingDialogAction.cancleLoadingDialog();
    navigatorCall();
  };
}
