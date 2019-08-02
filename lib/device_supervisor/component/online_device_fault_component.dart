part of "device_supervisor_component.dart";

class OnlineDeviceFalutComponent extends StatefulWidget {
  @override
  _OnlineDeviceFalutComponentState createState() =>
      _OnlineDeviceFalutComponentState();
}

class _OnlineDeviceFalutComponentState extends State<OnlineDeviceFalutComponent>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: ChangeFaultState(_tabController),
        ),
        SliverFillRemaining(
          child: Container(
            child: TabBarView(
              children: [
                getUnconfirmedDeviceFault(),
                getConfirmedDeviceFault(),
              ],
              controller: _tabController,
            ),
          ),
        )
      ],
    );
  }

  //table单元格子
  Widget _buildTableCell(String label) {
    return new Container(
      //单元格内小部件对齐方式
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(5.0),
      //文本小部件
      child: new Text(
        label,
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.black87, fontSize: 12.0),
        maxLines: 3,
        softWrap: true,
      ),
//      height: height,
//      width: width,
    );
  }

  //待确认线上设备
  getUnconfirmedDeviceFault() {
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
                    color: Colors.red,
                    fontSize: 13,
                  ),
                ),
                leading: Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                backgroundColor: Colors.white,
                initiallyExpanded: true,
                //默认是否展开
                children: <Widget>[
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    children: <Widget>[
                      new SizedBox(
                        width: 68,
                      ),
                      Container(
                        child: Text(
                          "--------------------------详情---------------------",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                        padding: EdgeInsets.all(5.0),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "设备名称:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                      new SizedBox(
                        width: 48,
                      ),
                      Container(
                        child: Text(
                          "烟感设备",
                          style: TextStyle(
                            color: Colors.black,
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
                          "故障设备位置:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                      new SizedBox(
                        width: 25,
                      ),
                      Container(
                        child: Text(
                          "XX大厦一楼",
                          style: TextStyle(
                            color: Colors.black,
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
                          "首次报警时间:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                      new SizedBox(
                        width: 25,
                      ),
                      Container(
                        child: Text(
                          "2019-07-18 08:30:21",
                          style: TextStyle(
                            color: Colors.black,
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
                          "最后一次报警时间:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                      new SizedBox(
                        width: 3,
                      ),
                      Container(
                        child: Text(
                          "2019-07-18 08:30:21",
                          style: TextStyle(
                            color: Colors.black,
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
                          "人员确认:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                      new SizedBox(
                        width: 50,
                      ),
                      Container(
                        child: Text(
                          "2019-07-18 08:30:21",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                    ],
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
                              return new PersonnelListComponent();
                            },
                          ));
                        },
                        child: Text("委派确认"),
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

  //已确认线上设备
  getConfirmedDeviceFault() {
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
                  new Table(
                    border: new TableBorder.all(
                        width: 5.0, color: Colors.transparent),
                    children: <TableRow>[
                      //初始化一行widget
                      new TableRow(
                        children: <Widget>[
                          new TableCell(child: _buildTableCell('反馈:')),
                          new TableCell(child: _buildTableCell('确定故障')),
                        ],
                      ),
                      new TableRow(
                        children: <Widget>[
                          //在一行中初始化一个单元格
                          new TableCell(child: _buildTableCell('处理人:')),
                          new TableCell(child: _buildTableCell('张三')),
                        ],
                      ),
                      new TableRow(
                        children: <Widget>[
                          //在一行中初始化一个单元格
                          new TableCell(child: _buildTableCell('处理时间:')),
                          new TableCell(
                              child: _buildTableCell('2019-07-31 09:11')),
                        ],
                      ),
                      new TableRow(
                        children: <Widget>[
                          //在一行中初始化一个单元格
                          new TableCell(child: _buildTableCell('设备故障原因:')),
                          new TableCell(
                              child: _buildTableCell(
                                  '原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因')),
                        ],
                      ),
                      new TableRow(
                        children: <Widget>[
                          //在一行中初始化一个单元格
                          new TableCell(child: _buildTableCell('故障设备图片:')),
                          new TableCell(
                            child: new Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3caBRRBaDBug3hDSSgLFtlu5QkAE_dsc366ScpKc4ZvhilCbMDg',
                              scale: 0.5,
                            ),
                          )
                        ],
                      ),
                      new TableRow(
                        children: <Widget>[
                          //在一行中初始化一个单元格
                          new TableCell(child: _buildTableCell('备注说明')),
                          new TableCell(child: _buildTableCell('备故障描述')),
                        ],
                      ),
                    ],
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
                  ),
                ],
              ),
            ),
          ]));
    });
  }
}

class ChangeFaultState extends SliverPersistentHeaderDelegate {
  TabController _tabController;

  ChangeFaultState(this._tabController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return TabBar(
      indicatorColor: Colors.green,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorPadding: new EdgeInsets.only(top: 30.0),
//      indicator: new ShapeDecoration(shape: new Border.all(color: Colors.green, width: 1.0)),
      tabs: <Widget>[
        Tab(
          child: Text('待确认'),
        ),
        Tab(
          child: Text('已确认'),
        ),
      ],
      controller: _tabController,
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
