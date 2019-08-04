part of "device_supervisor_component.dart";

class RadioComponent extends StatefulWidget {
  @override
  _RadioComponentState createState() => _RadioComponentState();
}

class _RadioComponentState extends State<RadioComponent> {
  String _newValue = '日常';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Text('任务类型:'),
        Flexible(
          child: RadioListTile<String>(
            activeColor: Colors.lightGreen,
            value: '日常',
            title: Text('日常'),
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
            value: '补充',
            title: Text('补充'),
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
