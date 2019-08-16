part of "device_supervisor_component.dart";

class RadioComponent extends StatefulWidget {
  @override
  _RadioComponentState createState() => _RadioComponentState();
}

class _RadioComponentState extends State<RadioComponent> {
  String _newValue = '巡检';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
//        SizedBox(
//          width: 10,
//        ),
        Text('任务类型:'),
        Flexible(
          child: RadioListTile<String>(
            activeColor: Colors.lightGreen,
            value: '巡检',
            title: Text('巡检',style: TextStyle(fontSize: 14)),
            groupValue: _newValue,
            onChanged: (value) {
              setState(() {
                _newValue = value;
              });
            },
          ),
        ),
        Flexible(
          child: RadioListTile<String>(
            activeColor: Colors.lightGreen,
            value: '任务',
            title: Text('任务',style: TextStyle(fontSize: 14),),
            groupValue: _newValue,
            onChanged: (value) {
              setState(() {
                _newValue = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
