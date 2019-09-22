///@author ggq
///@description:
///@date :2019/9/22 20:47
part of "components.dart";

class BlankPage extends StatelessWidget {
  final Function onRefreshCall;
  final String showText;

  BlankPage({this.onRefreshCall, this.showText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(showText),
          RaisedButton.icon(
            onPressed: () => onRefreshCall(),
            icon: Icon(Icons.refresh),
            label: Text("刷新"),
          )
        ],
      ),
    );
  }
}
