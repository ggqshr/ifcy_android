part of 'components.dart';

class PersonnelListComponent extends StatelessWidget {

  final String _title = '广东粤安科技有限公司';
//  List<DepartmentMessage> departmentList = new List(
//  );
  final controller = TextEditingController();
//  PersonnelListComponent({this.departmentList});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
//        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQueryData.fromWindow(window).padding.top,
          ),
          child: Container(
            height: 72.0,
            child: new Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: <Widget>[
                  new Row(
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
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
//                      MyHomeApp(title: 'Movies')
                    ],
                  )
                ],

              ),

            ),
          ),
        ),
      ),
    );
  }
}

class MyHomeApp extends StatefulWidget {
  final String title;
  MyHomeApp({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyHomeAppState();
  }
}

class _MyHomeAppState extends State<MyHomeApp> {
  List subjects = [];
  String title = '';

  @override
  void initState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: getBody(),
      ),
    );
  }

  loadData() async {
    String loadRUL = "https://api.douban.com/v2/movie/in_theaters";
    http.Response response = await http.get(loadRUL);
    var result = json.decode(response.body);
    setState(() {
      title = result['title'];
      print('title: $title');
      subjects = result['subjects'];
    });
  }

  getItem(var subject) {
//    演员列表
    var avatars = List.generate(subject['casts'].length, (int index) =>
        Container(
          margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 16.0),

          child: CircleAvatar(
              backgroundColor: Colors.white10,
              backgroundImage: NetworkImage(
                  subject['casts'][index]['avatars']['small']
              )
          ),
        ),
    );
    var row = Container(
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              subject['images']['large'],
              width: 100.0, height: 150.0,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8.0),
                height: 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                    电影名称
                    Text(
                      subject['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      maxLines: 1,
                    ),
//                    豆瓣评分
                    Text(
                      '豆瓣评分：${subject['rating']['average']}',
                      style: TextStyle(
                          fontSize: 16.0
                      ),
                    ),
//                    类型
                    Text(
                        "类型：${subject['genres'].join("、")}"
                    ),
//                    导演
                    Text(
                        '导演：${subject['directors'][0]['name']}'
                    ),
//                    演员
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Text('主演：'),
                          Row(
                            children: avatars,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
    return Card(
      child: row,
    );
  }

  getBody() {
    if (subjects.length != 0) {
      return ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int position) {
            return getItem(subjects[position]);
          });
    } else {
      // 加载菊花
      return CupertinoActivityIndicator();
    }
  }

}