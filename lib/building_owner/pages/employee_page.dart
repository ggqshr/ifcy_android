part of "building_owner_pages.dart";

class EmployeePage extends StatelessWidget {
  EmployeePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text((BlocProvider.of<AuthorizationBloc>(context).currentState
                as Authenticated)
            .currentBuild
            .buildName),
      ),
//      floatingActionButton: FloatingActionButton(
//          backgroundColor: Colors.lightGreen,
//          child: Icon(
//            Icons.add,
//          ),
//          onPressed: () {}),
      body: ProjectStaffListComponent(),
    );
  }
}

class ProjectStaffListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EmployeeListBloc bloc = BlocProvider.of<EmployeeListBloc>(context);
    return BlocBuilder<EmployeeListBloc,EmployeeListState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is LoadErrorEmployeeListState) {
          return LoadErrorPage(
              () => bloc.dispatch(FetchEmployeeListDataEvent()));
        }
        if (state is LoadingEmployeeListState) {
          return LoadingPage();
        }
        if (state is LoadedEmployeeListState) {
          var staffList = state.employeeList;
          return RefreshIndicator(
            onRefresh: () async {
              bloc.dispatch(FetchEmployeeListDataEvent());
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
                      List<PersonnelMessage> owner = staffList
                          .where((item) => item.roleType == 'OWNER')
                          .toList();
                      if (owner.length == 0) {
                        viewList.add(ListTile(
                          title: Text("当前无业主信息"),
                        ));
                      } else {
                        viewList.add(Divider(
                          color: Colors.black,
                        ));
                        viewList.add(ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Colors.lightGreen,
                          ),
                          title: Text(owner.first.name),
                          subtitle: Text("联系电话：${owner.first.mobile}"),
                        ));
                      }
                      return ExpansionCard(
                        title: "业主信息",
                        messageNum: 0,
                        viewList: viewList,
                        isExpansion: true,
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
                      List<PersonnelMessage> maintainManager = staffList
                          .where((item) => item.roleType == 'MAINTAIN_MANAGER')
                          .toList();
                      if (maintainManager.length == 0) {
                        viewList.add(ListTile(
                          title: Text("当前无维保主管"),
                        ));
                      } else {
                        viewList.add(Divider(
                          color: Colors.black,
                        ));
                        viewList.add(ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Colors.lightGreen,
                            ),
                            title: Text(maintainManager.first.name),
                            subtitle:
                                Text("联系电话：${maintainManager.first.mobile}"),
                            trailing: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.lightGreen,
                                ),
                                onPressed: null)));
                      }
                      return ExpansionCard(
                        title: "维保主管信息",
                        messageNum: 0,
                        viewList: viewList,
                        isExpansion: true,
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
                      List<PersonnelMessage> maintainWorker = staffList
                          .where((item) => item.roleType == 'MAINTAIN_WORKER')
                          .toList();
                      if (maintainWorker.length == 0) {
                        viewList.add(ListTile(
                          title: Text("当前无维保工作人员"),
                        ));
                      } else {
                        viewList = maintainWorker.map<Widget>((staff) {
                          return ListTile(
                              leading: Icon(
                                Icons.people,
                                color: Colors.lightGreen,
                              ),
                              title: Text(staff.name),
                              subtitle: Text("联系电话:${staff.mobile}"),
                              trailing: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.lightGreen,
                                  ),
                                  onPressed: null));
                        }).toList();
                      }
                      return ExpansionCard(
                        title: "维保工作人员信息",
                        messageNum: 0,
                        viewList: viewList,
                        isExpansion: true,
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
                      List<PersonnelMessage> propertyManager = staffList
                          .where((item) => item.roleType == 'PROPERTY_MANAGER')
                          .toList();
                      if (propertyManager.length == 0) {
                        viewList.add(ListTile(
                          title: Text("当前无物业主管"),
                        ));
                      } else {
                        viewList.add(ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Colors.lightGreen,
                            ),
                            title: Text(propertyManager.first.name),
                            subtitle:
                                Text("联系电话：${propertyManager.first.mobile}"),
                            trailing: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.lightGreen,
                                ),
                                onPressed: null)));
                      }
                      return ExpansionCard(
                        title: "物业主管信息",
                        messageNum: 0,
                        viewList: viewList,
                        isExpansion: true,
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
                      List<PersonnelMessage> propertyWorker = staffList
                          .where((item) => item.roleType == 'PROPERTY_WORKER')
                          .toList();
                      if (propertyWorker.length == 0) {
                        viewList.add(ListTile(
                          title: Text("当前无物业工作人员"),
                        ));
                      } else {
                        viewList = propertyWorker.map<Widget>((staff) {
                          return ListTile(
                              leading: Icon(
                                Icons.people,
                                color: Colors.lightGreen,
                              ),
                              title: Text(staff.name),
                              subtitle: Text("联系电话:${staff.mobile}"),
                              trailing: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.lightGreen,
                                  ),
                                  onPressed: null));
                        }).toList();
                      }
                      return ExpansionCard(
                        title: "物业工作人员信息",
                        messageNum: 0,
                        viewList: viewList,
                        isExpansion: true,
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
        }
      },
    );
  }
}
