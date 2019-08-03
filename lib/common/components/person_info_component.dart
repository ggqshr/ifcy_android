part of 'components.dart';

class PersonInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '个人资料',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      body: PersonInfoForm(),
    );
  }
}

class PersonInfoForm extends StatelessWidget {

  List<String> lists = [
    '默认排序',
    '首付最低',
    '月供最低',
    '车价最低',
    '车价最高'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          child: new Column(
        children: <Widget>[
          TextFormField(
            initialValue: '真实姓名',
            decoration: new InputDecoration(
              prefixText: '真实姓名',
              border: InputBorder.none,
            ),
            textAlign: TextAlign.end,
            onSaved: null,
          ),
          Divider(
            color: Colors.grey,
          ),
          TextFormField(
            initialValue: '昵称',
            decoration: new InputDecoration(
              prefixText: '昵称',
              border: InputBorder.none,
            ),
            textAlign: TextAlign.end,
            onSaved: null,
          ),
          Divider(
            color: Colors.grey,
          ),
          //维保工作人员擅长内容
          TextFormField(
            initialValue: '擅长任务',
            decoration: new InputDecoration(
              prefixText: '专业技能',
              border: InputBorder.none,
            ),
            textAlign: TextAlign.end,
            onSaved: null,
          ),
          Divider(
            color: Colors.grey,
          ),

//          TextFormField(
//            initialValue: '广东广州',
//            decoration: new InputDecoration(
//              prefixText: '所在城市',
//              border: InputBorder.none,
//                suffixIcon: DropdownButton(
//                    items: [
//                      new DropdownMenuItem(
//                        child: new Text('同意'),
//                        value: '同意',
//                      ),
//                      new DropdownMenuItem(
//                        child: new Text('拒绝'),
//                        value: '拒绝',
//                      ),
//                    ],
//                    onChanged: null
//                )
//            ),
//            textAlign: TextAlign.end,
//            onSaved: null,
//          ),
          Divider(
            color: Colors.grey,
          ),

//          TextFormField(
//            initialValue: '广东广州',
//            decoration: new InputDecoration(
//              prefixText: '简介',
//              border: InputBorder.none,
//            ),
//            textAlign: TextAlign.end,
//            onSaved: null,
//            maxLines: 5,
//          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      )),
      padding: EdgeInsets.all(15.0),
    );
  }
}
