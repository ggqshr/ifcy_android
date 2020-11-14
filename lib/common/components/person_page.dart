part of 'components.dart';

class PersonPage extends StatelessWidget {
  final Function drawerCall;

  PersonPage(this.drawerCall);

  @override
  Widget build(BuildContext context) {
    final String currentRole =
        (BlocProvider.of<AuthorizationBloc>(context).state as Authenticated)
            .userEntity
            .roleType;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
//        leading: IconButton(
//            icon: Icon(Icons.menu),
//            onPressed: () {
//              drawerCall();
//            }),
//        actions: <Widget>[
//          IconButton(
//      icon: Icon(Icons.navigate_next, color: Colors.grey),
//      onPressed: () {
//        Navigator.push(context,
//            MaterialPageRoute(builder: (context) => PersonInfoPage()));
//      },
//    )
//        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Container(
              margin: EdgeInsets.fromLTRB(15.0, 5, 0, 25),
              height: 48.0,
              alignment: Alignment.center,
              child: PersonelInfoComponent(
                userEntity: (BlocProvider.of<AuthorizationBloc>(context).state
                        as Authenticated)
                    .userEntity,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("注销"),
              onTap: () {
                BlocProvider.of<AuthorizationBloc>(context)
                    .add(LoginOut());
              },
            ),
            ListTile(
              title: Text("升级app"),
              onTap: () async {
                PermissionStatus permission = await PermissionHandler()
                    .checkPermissionStatus(
                    PermissionGroup.storage); //请求权限
                if (permission == PermissionStatus.denied) {
                  Map<PermissionGroup, PermissionStatus> permissions =
                  await PermissionHandler()
                      .requestPermissions([PermissionGroup.storage]);
                }
                Directory appDocDir =
                await getExternalStorageDirectory(); //获取app数据存储地址
                final taskId = await FlutterDownloader.enqueue(
                  //下载app
                  url: 'http://47.107.231.51/ifcy.apk',
                  savedDir: appDocDir.path,
                  showNotification: true,
                  // show download progress in status bar (for Android)
                  openFileFromNotification:
                  true, // click on notification to open downloaded file (for Android)
                );
                FlutterDownloader.registerCallback(//设置回调
                        (taskId, status, progress) async {
                      if (status == DownloadTaskStatus.complete) {
                        InstallPlugin.installApk(
                          //下载完成后，启动更新
                            appDocDir.path + "/ifcy.apk",
                            "com.example.ifcy")
                            .then((e) {
                          print("install $e");
                        });
                      }
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}

class PersonelInfoComponent extends StatelessWidget {
  final UserEntity userEntity;

  const PersonelInfoComponent({Key key, this.userEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(userEntity.realName[0]),
        ),
        title: Text(
          "${userEntity.realName} 当前身份为${Application.auth2string[userEntity.roleType]}",
          style: TextStyle(fontSize: 16.0),
        ),
        trailing: IconButton(
          icon: Icon(Icons.navigate_next, color: Colors.grey),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder:(content){
              return PersonInfoPage();
            }));
          },
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder:(content){
            return PersonInfoPage();
          }));
        },
      ),
    );
  }
}
