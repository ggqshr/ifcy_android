part of "device_supervisor_component.dart";

class OfflineDeviceFaultComponent extends StatefulWidget {
  OfflineDeviceFaultComponent({Key, key}) : super(key: key);

  @override
  _OfflineDeviceFaultComponentState createState() =>
      _OfflineDeviceFaultComponentState();
}

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
  );
}

class _OfflineDeviceFaultComponentState
    extends State<OfflineDeviceFaultComponent> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (context, Store<AppState> store) {
      var offlineDeviceFaultList = store.state.deviceSupervisorModel.offlineDeviceFaultList;
      return Container(child: ListView.builder(itemBuilder: (context, index) {
        return Card(
            elevation: 5,
            margin: EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Flexible(
                flex: 2,
                child: ExpansionTile(
                  title: Text(
                    "2019-07-03 19:02 XX大厦烟感设备故障报警",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13,
                    ),
                  ),
                  leading: Icon(
                    Icons.warning,
                    color: Colors.redAccent,
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
                          width: 2.0, color: Colors.transparent),
                      children: <TableRow>[
                        new TableRow(
                          children: <Widget>[
                            new TableCell(child: _buildTableCell('设备名称:')),
                            new TableCell(child: _buildTableCell(offlineDeviceFaultList[index].deviceName)),
                          ],
                        ),
                        new TableRow(
                          children: <Widget>[
                            new TableCell(child: _buildTableCell('设备类型:')),
                            new TableCell(child: _buildTableCell(offlineDeviceFaultList[index].deviceType)),
                          ],
                        ),
                        new TableRow(
                          children: <Widget>[
                            new TableCell(child: _buildTableCell('设备故障描述:')),
                            new TableCell(child: _buildTableCell(offlineDeviceFaultList[index].deviceFaultDes)),
                          ],
                        ),
                        new TableRow(
                          children: <Widget>[
                            new TableCell(child: _buildTableCell('故障设备位置:')),
                            new TableCell(child: _buildTableCell(offlineDeviceFaultList[index].deviceLocation)),
                          ],
                        ),
                        new TableRow(
                          children: <Widget>[
                            //在一行中初始化一个单元格
                            new TableCell(child: _buildTableCell('检报人员:')),
                            new TableCell(child: _buildTableCell(offlineDeviceFaultList[index].deviceFaultExcutor)),
                          ],
                        ),
                        new TableRow(
                          children: <Widget>[
                            //在一行中初始化一个单元格
                            new TableCell(child: _buildTableCell('检报时间:')),
                            new TableCell(
                                child: _buildTableCell(offlineDeviceFaultList[index].faultDeclareTime.toString().substring(1,20))),
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
                            new TableCell(child: _buildTableCell(offlineDeviceFaultList[index].remarks)),
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
      }));
    });
  }
}
