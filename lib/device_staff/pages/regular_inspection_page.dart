///@author ggq
///@description:
///@date :2019/8/3 11:34
part of 'device_staff_pages.dart';

class RegularInspectionPage extends StatefulWidget {
  @override
  _RegularInspectionPageState createState() => _RegularInspectionPageState();
}

class _RegularInspectionPageState extends State<RegularInspectionPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation =
        CurvedAnimation(parent: _animationController, curve: Curves.decelerate);
    animation = Tween(begin: 0.0, end: 0.5).animate(animation);
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: null,
            icon: Icon(FontAwesomeIcons.filter),
          ),
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: SearchBarButton()),
            icon: Tooltip(
              message: "搜索",
              child: Icon(Icons.search),
            ),
          ),
        ],
        title: Text("工作台"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("扫码"),
        icon: Icon(FontAwesomeIcons.qrcode),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: TaskStateHeader(animation),
          ),
          SliverAppBar(
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Text("待检查设备总数:6"),
                          SizedBox(
                            width: 20,
                          ),
                          Text("已检查设备:6"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Text("剩余待检查设备:6"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            expandedHeight: 60,
            automaticallyImplyLeading: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ExpansionTile(
                title: Text("title$index"),
                children: <Widget>[
                  Text("哈哈"),
                  Text("哈哈"),
                  Text("哈哈"),
                  Text("哈哈"),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

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

class TaskStateHeader extends SliverPersistentHeaderDelegate {
  final Animation<double> animation;

  TaskStateHeader(this.animation);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                return Container(
                  width: constraints.maxWidth,
                  height: 25,
                  child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: animation.value,
                        );
                      }),
                );
              },
            ),
            Text("当前进度: %50"),
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => 25.0;

  @override
  double get minExtent => 25.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
