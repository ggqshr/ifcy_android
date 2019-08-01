part of "device_supvisor_pages.dart";

class SupervisorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarComponent(),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Divider(
              height: 1.0,
            ),
          ),
          SliverToBoxAdapter(
            child: SearchInputComponent(),
          ),
          SupervisorListComponent()
        ],
      ),
    );
  }

  Widget getConfirmedDeviceFault() {
    return ListView.builder(itemBuilder: (context, index) {
      return Card(
          elevation: 5,
          margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Flexible(
              flex: 2,
              child: ExpansionTile(
                title: Text(
                  "2019-07-03 19:02 XX大厦烟感设备故障报警",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                leading: Icon(
                  Icons.warning,
                  color: Colors.grey,
                ),
                backgroundColor: Colors.white,
                initiallyExpanded: true,
                //默认是否展开
                children: <Widget>[
                  Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text('反馈'),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "反馈:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                      new SizedBox(
                        width: 40,
                      ),
                      Container(
                        child: Text(
                          "确认故障",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "处理人:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                      new SizedBox(
                        width: 26,
                      ),
                      Container(
                        child: Text(
                          "张三",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "处理时间:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                      new SizedBox(
                        width: 18,
                      ),
                      Container(
                        child: Text(
                          "2019-07-18 08:30:21",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: new Text(
                      '设备故障原因:    Flutter 是一个用一套代码就可以构建高性能安卓和苹果应用的移动应用 SDK。卓和苹果应用的移卓和苹果应用的移卓和苹果应用的移 ',
                      style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "故障设备照片:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                      new SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: new Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3caBRRBaDBug3hDSSgLFtlu5QkAE_dsc366ScpKc4ZvhilCbMDg',
                          scale: 1.0,
                        ),
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                  Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: new Text(
                      '备注说明:    Flutter 是一个用一套代码就可以构建高性能安卓和苹果应用的移动应用 SDK。卓和苹果应用的移卓和苹果应用的移卓和苹果应用的移 ',
                      style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  new SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.black87,
                  ),
                  Row(
                    children: <Widget>[
                      new SizedBox(
                        width: 280,
                      ),
                      FlatButton(
                        onPressed: () {
                          print('FloatingActionButton');
                          Navigator.push(context, new MaterialPageRoute(
                            builder: (context) {
                              return new SupervisorListPage();
                            },
                          ));
                        },
                        child: Text("申报维修"),
                        color: Colors.green,
                        textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]));
    });
  }
}
