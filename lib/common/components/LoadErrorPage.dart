///@author ggq
///@description:
///@date :2019/9/8 10:42
part of "components.dart";

class LoadErrorPage extends StatelessWidget {
  final Function onRefreshCall;

  LoadErrorPage(this.onRefreshCall);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          FlatButton.icon(
            icon: Icon(Icons.refresh),
            label: Text("重新加载"),
            onPressed: () => onRefreshCall(),
          ),
        ],
      ),
    );
  }
}
