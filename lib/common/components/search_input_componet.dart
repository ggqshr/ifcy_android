part of 'components.dart';

class SearchBarButton extends SearchDelegate<String> {
  List<String> inputHistory = ["1", "2", "3"];
  List<String> dataList = ["4", "5", "6"];

  @override
  String get searchFieldLabel => "输入设备号或类别";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      //如果查询不为空
      if (inputHistory.contains(query)) {
        //如果当前输入历史中存在结果
        if (inputHistory.indexOf(query) != inputHistory.length - 1) {
          //如果记录中的位置不在最后一个
          inputHistory.remove(query);
          inputHistory.add(query);
        }
      } else {
        //不存在就直接添加
        inputHistory.add(query);
      }
    }
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        List<Widget> historyTile = inputHistory.reversed.take(10).map((item) {
          return ListTile(
            onTap: () {
              query = item;
              showResults(context);
            },
            leading: Icon(Icons.history),
            title: Text(item),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                inputHistory.remove(item);
                setState(() {});
              },
            ),
          );
        }).toList();
        return ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                "搜索历史",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: FlatButton(
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    //todo 清空缓存中输入搜索记录
                    inputHistory.clear();
                    setState(() {});
                  },
                  child: Text(
                    "清空",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  )),
            ),
            Divider(
              color: Colors.grey,
            ),
            ...historyTile,
            if (historyTile.length != 0)
              Divider(
                color: Colors.grey,
              ),
            if (historyTile.length == 0)
              ListTile(
                title: Text("空"),
              )
          ],
        );
      },
    );
  }
}