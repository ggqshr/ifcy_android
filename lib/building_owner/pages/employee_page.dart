part of "building_owner_pages.dart";

class EmployeePage extends StatelessWidget {
  Function drawerCall;

  EmployeePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: BuildingOwnerAppBarComponent(),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              drawerCall();
            }),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          child: Icon(
            Icons.add,
          ),
          onPressed: () {}),
      body: ProjectStaffListComponent(),
    );
  }
}

class ProjectStaffListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (context, Store<AppState> store) {
      var staffList = store.state.buildingOwnerModel.projectStaffList;
      return RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Card(
                  //elevation: 5,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 15, 15, 10),
                    child: Text(
                      "项目人员组成",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  List<Widget> viewList = <Widget>[];
                  if(staffList.length==0){
                    viewList.add(ListTile(
                      title: Text("当前无业主信息"),
                    ));
                  }else {
                    viewList.add(Divider(color: Colors.black,));
                    viewList.add(ListTile(
                      leading:Icon(Icons.person,color: Colors.lightGreen,),
                      title: Text("XX业主"),
                      subtitle: Text("联系电话：1266321487"),
                    ));
                  }
                  return ExpansionCard(
                    title: "业主信息",
                    messageNum: 0,
                    viewList: viewList,
                  );
                },
                childCount: 1,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  List<Widget> viewList = <Widget>[];
                  if(staffList.length==0){
                    viewList.add(ListTile(
                      title: Text("当前无维保主管"),
                    ));
                  }else {
                    viewList.add(Divider(color: Colors.black,));
                    viewList.add(
                        ListTile(
                        leading:Icon(Icons.person,color: Colors.lightGreen,),
                      title: Text("XX维保主管"),
                      subtitle: Text("联系电话：1266321487                                     所属公司:xxx维保公司"),
                        trailing:IconButton(icon:Icon(Icons.edit,color: Colors.lightGreen,), onPressed: null)
                    ));
                  }
                  return ExpansionCard(
                    title: "维保主管信息",
                    messageNum: 0,
                    viewList: viewList,
                  );
                },
                childCount: 1,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  List<Widget> viewList = <Widget>[];
                  if(staffList.length==0){
                    viewList.add(ListTile(
                      title: Text("当前无维保工作人员"),
                    ));
                  }else {
                    viewList=staffList.map<Widget>((staff){
                      return ListTile(
                        leading:Icon(Icons.people,color: Colors.lightGreen,),
                        title:Text(staff.name),
                        subtitle:Text("联系电话:${staff.contact}                                    所属公司:${staff.companyName} "),
                          trailing:IconButton(icon:Icon(Icons.edit,color: Colors.lightGreen,), onPressed: null)
                      );
                    }).toList();
                  }
                  return ExpansionCard(
                    title: "维保工作人员信息",
                    messageNum: 0,
                    viewList: viewList,
                  );
                },
                childCount: 1,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  List<Widget> viewList = <Widget>[];
                  if(staffList.length==0){
                    viewList.add(ListTile(
                      title: Text("当前无物业主管"),
                    ));
                  }else {
                    viewList.add(ListTile(
                        leading:Icon(Icons.person,color: Colors.lightGreen,),
                        title: Text("XX物业主管"),
                        subtitle: Text("联系电话：1266321487                                     所属公司:xxx物业公司"),
                        trailing:IconButton(icon:Icon(Icons.edit,color: Colors.lightGreen,), onPressed: null)
                    ));
                  }
                  return ExpansionCard(
                    title: "物业主管信息",
                    messageNum: 0,
                    viewList: viewList,
                  );
                },
                childCount: 1,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  List<Widget> viewList = <Widget>[];
                  if(staffList.length==0){
                    viewList.add(ListTile(
                      title: Text("当前无物业工作人员"),
                    ));
                  }else {
                    viewList=staffList.map<Widget>((staff){
                      return ListTile(
                          leading:Icon(Icons.people,color: Colors.lightGreen,),
                          title:Text(staff.name),
                          subtitle:Text("联系电话:${staff.contact}                                    所属公司:${staff.companyName} "),
                          trailing:IconButton(icon:Icon(Icons.edit,color: Colors.lightGreen,), onPressed: null)
                      );
                    }).toList();
                  }
                  return ExpansionCard(
                    title: "物业工作人员信息",
                    messageNum: 0,
                    viewList: viewList,
                  );
                },
                childCount: 1,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
            ),
          ],
        ),
      );
    });
  }
}
