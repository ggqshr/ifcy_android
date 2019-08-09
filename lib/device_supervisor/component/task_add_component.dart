part of 'device_supervisor_component.dart';

class TaskAddComponent extends StatefulWidget {
  @override
  _TaskAddComponentState createState() => _TaskAddComponentState();
}

class _TaskAddComponentState extends State<TaskAddComponent> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _taskContent;
  String _taskType;
  String _taskPeriod;
  String _executor;
  String startTime = '开始时间';
  String endTime = '结束时间';
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Text(
          "工作安排",
          style: TextStyle(fontSize: 16.0),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
      body: new SingleChildScrollView(
          child: new Container(
              //height: 600,
              padding: const EdgeInsets.all(30.0),
              margin: EdgeInsets.all(10.0),
              color: Color(0xFFdeecff),
              child: new Form(
                key: _formKey,
                child: new Column(
                  children: <Widget>[
                    RadioComponent(),
                    Row(
                      children: <Widget>[
                        Text("任务内容:"),
                      ],
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      //controller: _controller,
                      //initialValue: '请输入任务内容',
                      decoration: new InputDecoration(
                        labelText: '请输入任务内容:',
//                      border: InputBorder.none,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      onSaved: null,
                    ),
                    taskCircleChooseComponent(),
                    buildingChooseComponent(),
                    DatePickerComponent(timeType: startTime),
                    SizedBox(
                      height: 10,
                    ),
                    DatePickerComponent(timeType: endTime),
                    Row(
                      children: <Widget>[
                        Text('选择人员:'),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.people_outline,
                            color: Colors.lightGreen,
                          ),
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                              builder: (context) {
                                return new PersonnelListComponent();
                              },
                            ));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }
}

//下拉选择任务周期组件
class taskCircleChooseComponent extends StatefulWidget {
  @override
  _taskCircleChooseComponentState createState() =>
      _taskCircleChooseComponentState();
}

class _taskCircleChooseComponentState extends State<taskCircleChooseComponent> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskAddViewModel>(
        distinct: true,
        converter: (Store<AppState> store) {
          DeviceSupervisorModel model = store.state.deviceSupervisorModel;
          return TaskAddViewModel(
              taskCycleList: model.taskCycleMessages,
              onRefreshCall: () async {
                await Future.delayed(Duration(seconds: 2));
              });
        },
        builder: (BuildContext context, TaskAddViewModel vm) {
          print(vm.taskCycleList);
          List<String> taskCircleItems = vm.taskCycleList.map((i) {
            return i.item.toString();
          }).toList();
          return Row(
            children: <Widget>[
              Text('任务周期:        '),
              SizedBox(
                width: 8,
              ),
              DropdownButton<String>(
                style: TextStyle(
                  fontFamily: 'Arapey',
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                  fontSize: 15,
                ),
                hint: Text('下拉选择任务周期'),
                onChanged: (String newVal) {
                  setState(() {
                    selectedIndex = taskCircleItems.indexOf(newVal);
                    print(selectedIndex);
                  });
                },
                items: taskCircleItems
                    .map<DropdownMenuItem<String>>((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(
                      dropDownStringItem,
                      style: TextStyle(
                        fontFamily: 'Arapey',
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  );
                }).toList(),
                value: taskCircleItems[selectedIndex],
              )
            ],
          );
        });
  }
}

////下拉选择建筑和楼层组件
class buildingChooseComponent extends StatefulWidget {
  @override
  _buildingChooseComponentState createState() =>
      _buildingChooseComponentState();
}

class _buildingChooseComponentState extends State<buildingChooseComponent> {
  int selectedIndex = 0;
  List<FloorMessage> floorList;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskAddViewModel>(
        distinct: true,
        converter: (Store<AppState> store) {
          DeviceSupervisorModel model = store.state.deviceSupervisorModel;
          return TaskAddViewModel(
              buildingFloorList: model.buildingFloorList,
              onRefreshCall: () async {
                await Future.delayed(Duration(seconds: 2));
              });
        },
        builder: (BuildContext context, TaskAddViewModel vm) {
          List<String> buildingFloorItems = vm.buildingFloorList.map((i) {
            return i.buildName.toString();
          }).toList();
          return Container(

              padding: EdgeInsets.all(2.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("选择建筑："),
                      SizedBox(
                        width: 25,
                      ),
                      DropdownButton<String>(
                        elevation: 24,
                        style: TextStyle(
                          fontFamily: 'Arapey',
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        hint: Text('下拉选择巡检建筑'),
                        items: buildingFloorItems.map<DropdownMenuItem<String>>(
                            (String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem+"         "),
                          );
                        }).toList(),
                        value: buildingFloorItems[selectedIndex],
                        onChanged: (String newVal) {
                          setState(() {
                            selectedIndex = buildingFloorItems.indexOf(newVal);
                            print(selectedIndex);
                          });
                        },
                      ),
                    ],
                  ),
                  Container(
                    height: 100,
                    width: 180,
                    child: new ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: floorList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new ListTile(
                            title: Text("${floorList[index].floorName}",style: TextStyle(fontSize: 14),),
                            trailing: IconButton(icon: Icon(Icons.check_circle,color: Colors.green,size: 14,), onPressed: null),
                          );
                        }),
                  ),
                ],
              ));
        });
  }

  buildFloorTile() {
    floorList.map((item) {
      print(item);
      return ListTile(
        title: Text("${item.floorName.toString()}"),
        //trailing: ,
      );
    });
  }
}
