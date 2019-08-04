part of 'device_supervisor_component.dart';

class TaskAddComponent extends StatefulWidget {
  @override
  _TaskAddComponentState createState() => _TaskAddComponentState();
}

class _TaskAddComponentState extends State<TaskAddComponent> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _taskContent;
  String _taskType;

//  DateTime _taskStartDate = DateTime.now();
//  DateTime _taskEndDate = DateTime.now();
  String _taskPeriod;
  String _executor;
  String startTime = '开始时间';
  String endTime = '结束时间';
  final TextEditingController _controller = new TextEditingController();

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
            margin: EdgeInsets.all(10.0),
            color: Color(0xFFdeecff),
            child: new Form(
              key: _formKey,
              child: new Column(
                children: <Widget>[
                  TextFormField(
                    //controller:TextEditingController(),
                    //initialValue: '请输入任务内容',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w200),
                    controller: _controller,
                    decoration: new InputDecoration(
                      labelText: '    任务内容:',
                      //helperText: '     请输入任务内容',
                      // hintText: '请输入任务内容',
                      border: InputBorder.none,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                        value: value,
                        //下拉菜单选择完之后显示给用户的值
                        onChanged: (T) {
                          //下拉菜单item点击之后的回调
                          setState(() {
                            value = T;
                          });
                        },
                        elevation: 20,
                        //设置阴影的高度
                        style: new TextStyle(
                            //设置文本框里面文字的样式
                            color: Colors.greenAccent),
                        isDense: false,
                        //减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                        iconSize: 25.0, //设置三角标icon的大小
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RadioComponent(),
                  SizedBox(
                    height: 20,
                  ),
                  DatePickerComponent(startTime),
                  SizedBox(
                    height: 30,
                  ),
                  DatePickerComponent(endTime),
                  SizedBox(
                    height: 20,
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
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 120,
                      ),
                      RaisedButton(
                        textColor:Colors.lightGreen,
                        onPressed: null,
                        child: Text('发布任务'),
                        highlightColor:Colors.lightGreen,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RaisedButton(
                        onPressed: null,
                        child: Text('取消发布'),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
