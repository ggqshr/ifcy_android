part of 'components.dart';

class PersonnelListComponent extends StatelessWidget {
  final String _title = '广东粤安科技有限公司';
  List<DepartmentMessage> departmentList = new List();
  final controller = TextEditingController();

  PersonnelListComponent({this.departmentList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQueryData.fromWindow(window).padding.top,
          ),
          child: Container(
            height: 52.0,
            child: new Padding(
                padding: const EdgeInsets.all(6.0),
                child: new Card(
                    child: new Container(
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: TextField(
                            controller: controller,
                            decoration: new InputDecoration(
                                contentPadding: EdgeInsets.only(top: 0.0),
                                hintText: 'Search',
                                border: InputBorder.none),
                            //onChanged: onSearchTextChanged,
                          ),
                        ),
                      ),
                      new IconButton(
                        icon: new Icon(Icons.cancel),
                        color: Colors.grey,
                        iconSize: 18.0,
                        onPressed: () {
                          controller.clear();
                          // onSearchTextChanged('');
                        },
                      ),
                    ],
                  ),
                ))
            ),
          ),
        ),

      ),
    );
  }
}
