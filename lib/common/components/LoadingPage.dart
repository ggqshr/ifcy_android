///@author ggq
///@description:
///@date :2019/9/8 10:45
part of "components.dart";

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          Text("加载中"),
        ],
      ),
    );
  }
}
