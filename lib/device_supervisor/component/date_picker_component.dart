part of "device_supervisor_component.dart";

class DatePickerComponent extends StatefulWidget {

  final String timeType;
  DatePickerComponent({this.timeType});

  @override
  _DatePickerComponentState createState() => _DatePickerComponentState();
}

class _DatePickerComponentState extends State<DatePickerComponent> {
  var _time = DateTime.now().toString().substring(0, 10);

  _showDataPicker() async {
    Locale myLocale = Localizations.localeOf(context);
    var picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2050),
        locale: myLocale);
    setState(() {
      _time = picker.toString().substring(0, 10);
    });
  }

  _showTimePicker() async {
    var picker =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      _time = picker.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
//        SizedBox(
//          width: 10,
//        ),
        Text("开始时间:          $_time                  "),
//        Text("                 "),
        IconButton(
          icon: Icon(
            Icons.date_range,
            color: Colors.lightGreen,
          ),
          onPressed: () => _showDataPicker(),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
