part of "main_app_thunk.dart";

ThunkAction<AppState> loginSubmitAction(String userName, String passWord) {
  return (Store<AppState> store) async {
    await Future.delayed(Duration(seconds: 2));
    store.dispatch(LoginSuccessAction(userName, ["test"]));
    loadingDialogAction.cancleLoadingDialog();
  };
}
