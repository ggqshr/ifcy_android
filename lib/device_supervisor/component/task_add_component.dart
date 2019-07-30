part of 'device_supervisor_component.dart';

class TaskAddComponent extends StatefulWidget {
  @override
  _TaskAddComponentState createState() => _TaskAddComponentState();
}

class _TaskAddComponentState extends State<TaskAddComponent> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _taskContent;
  String _taskType;
  DateTime _taskStartDate = DateTime.now();
  DateTime _taskEndDate = DateTime.now();
  String _taskPeriod;
  String _executor;

  List<DropdownMenuItem> getListData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem1 = new DropdownMenuItem(
      child: new Text('1'),
      value: '1',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: new Text('2'),
      value: '2',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3 = new DropdownMenuItem(
      child: new Text('3'),
      value: '3',
    );
    items.add(dropdownMenuItem3);
    DropdownMenuItem dropdownMenuItem4 = new DropdownMenuItem(
      child: new Text('4'),
      value: '4',
    );
    items.add(dropdownMenuItem4);
    DropdownMenuItem dropdownMenuItem5 = new DropdownMenuItem(
      child: new Text('5'),
      value: '5',
    );
    items.add(dropdownMenuItem5);
    DropdownMenuItem dropdownMenuItem6 = new DropdownMenuItem(
      child: new Text('6'),
      value: '6',
    );
    items.add(dropdownMenuItem6);
    DropdownMenuItem dropdownMenuItem7 = new DropdownMenuItem(
      child: new Text('7'),
      value: '7',
    );
    items.add(dropdownMenuItem7);
    DropdownMenuItem dropdownMenuItem8 = new DropdownMenuItem(
      child: new Text('8'),
      value: '8',
    );
    items.add(dropdownMenuItem8);
    DropdownMenuItem dropdownMenuItem9 = new DropdownMenuItem(
      child: new Text('9'),
      value: '9',
    );
    items.add(dropdownMenuItem9);
    DropdownMenuItem dropdownMenuItem10 = new DropdownMenuItem(
      child: new Text('10'),
      value: '10',
    );
    items.add(dropdownMenuItem10);
    return items;
  }

  var value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("新增任务"),
          centerTitle: true,
        ),
        body: new Container(
            padding: const EdgeInsets.all(30.0),
//            color: Color(0xFFdeecff),
            child: new Form(
              key: _formKey,
              child: new Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text('任务周期:'),
                      SizedBox(
                        width: 8,
                      ),
                      DropdownButton(
                        items: getListData(),
                        hint: new Text('下拉选择你想要的数据'),
                        value: value, //下拉菜单选择完之后显示给用户的值
                        onChanged: (T) {
                          //下拉菜单item点击之后的回调
                          setState(() {
                            value = T;
                          });
                        },
                        elevation: 20, //设置阴影的高度
                        style: new TextStyle(
                            //设置文本框里面文字的样式
                            color: Colors.red),
                        isDense:
                            false, //减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                        iconSize: 25.0, //设置三角标icon的大小
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text('任务类型:'),
                      SizedBox(
                        width: 8,
                      ),
                      Radio(
                        value: 1,
                        groupValue: this._taskType,
                        onChanged: (v) {
//                          setState(() {
//                            this. _taskType = v;
//                          });
                        },
                      ),
                      Text('日常巡检'),
                      Radio(
                        value: 2,
                        groupValue: this._taskType,
                        onChanged: (v) {
//                          setState(() {
//                            this. _taskType = v;
//                          });
                        },
                      ),
                      Text('年度巡检'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text('任务内容:'),
//                      SizedBox(
////                        width: 8,
////                      ),

//                      TextFormField(
//                        decoration: new InputDecoration(
//                            enabledBorder: OutlineInputBorder(
//                              borderRadius: BorderRadius.all(Radius.circular(20)),
//                              borderSide: BorderSide(
//                                  color: Colors.lightGreen,
//                                  width: 1
//                              ),
//                            ),
//                            focusedBorder: OutlineInputBorder(
//                                borderSide: BorderSide(
//                                  color: Colors.green, //边框颜色为绿色
//                                  width: 1, //宽度为5
//                                )),
//
////                        helperText: "任务内容",
//                            // errorText: "errorText",
//                            hintText: "任务内容",
//                            prefixIcon: Icon(Icons.perm_identity)
//                        ),
//                        onSaved: (val) {
//                          _taskContent = val;
//                        },
//
//                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text('开始时间:'),
                      SizedBox(
                        width: 20,
                      ),



//                      SafeArea(
//                        top: false,
//                        bottom: false,
//                        child: new ListView(
//                          children: <Widget>[
//                            new DatePicker(
//                              selectedDate: _taskStartDate,
//                              selectDate: (DateTime date) {
//                                setState(() {
//                                  _taskStartDate = date;
//                                });
//                              },
//                            )
//                          ],
//                        ),
//                      )
//                      DatePicker(
//                        selectedDate: _taskStartDate,
//                        selectDate: (DateTime date){
//                          setState(() {
//                            _taskStartDate=date;
//                          });
//                        },
//                      )

//                      RaisedButton(
//                        child: Text(_taskStartDate == null ? '任务开始日期' : _taskStartDate),
//                        onPressed: () => _showDataPicker(),
//                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text('选择人员:'),
                      SizedBox(
                        width: 10,
                        height: 15,
                      ),
                      RaisedButton(
                          child: Text("选择委派人"),
                        onPressed: (){
                          print('FloatingActionButton');
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context){
                                return new PersonnelListComponent();
                              },
//                    fullscreenDialog: true
                              )
                          );
                        },

                      )

                    ],
                  ),
//                  new TextFormField(
//                    decoration: new InputDecoration(
//                        enabledBorder: OutlineInputBorder(
//                          borderRadius: BorderRadius.all(Radius.circular(20)),
//                          borderSide:
//                              BorderSide(color: Colors.lightGreen, width: 1),
//                        ),
//                        focusedBorder: OutlineInputBorder(
//                            borderSide: BorderSide(
//                          color: Colors.green, //边框颜色为绿色
//                          width: 1, //宽度为5
//                        )),
//
////                        helperText: "任务内容",
//                        // errorText: "errorText",
//                        hintText: "任务内容",
//                        prefixIcon: Icon(Icons.perm_identity)),
//                    onSaved: (val) {
//                      _taskContent = val;
//                    },
//                  ),
//                  new TextFormField(
//                    decoration: new InputDecoration(
//                      labelText: '任务内容',
//                    ),
//                    onSaved: (val) {
//                      _taskContent = val;
//                    },
//                  ),
                ],
              ),
            )));
  }
}
