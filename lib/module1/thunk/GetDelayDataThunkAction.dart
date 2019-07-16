part of "MoudleThunkAction.dart";

void GetdelayDataAction(Store<Moudle1Model> store) async {
  store.dispatch(ChangeShowTextStateAction());
  await Future.delayed(Duration(seconds: 5)); // 等待5秒，模拟异步的请求
  store.dispatch(GetDelayDataAction("here data come!"));
  store.dispatch(ChangeShowTextStateAction());
}
