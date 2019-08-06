part of "device_supervisor_component.dart";

class PersonnelListComponent extends StatelessWidget {
  final String _title = '广东粤安科技有限公司';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title,style: TextStyle(fontSize: 16.0),),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.publish),
        backgroundColor: Colors.green,
        onPressed: (){
//          Navigator.push(
//            context,
//            new MaterialPageRoute(builder: (context)=>TaskAddComponent()),
//          );
        },

      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Divider(
              height: 1.0,
            ),
          ),
          SliverToBoxAdapter(
            child: SearchInputComponent(),
          ),
          DepartmentEmployeeListComponent(),
        ],
      ),
    );
  }
}

class DepartmentEmployeeListComponent extends StatelessWidget {
  int childCount;
  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (context, Store<AppState> store) {
      var vm = store.state.deviceSupervisorModel.departmentMessages;
      return SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (vm.length > 0) {
            childCount = vm.length;
            print(vm);
            return DepartmentTile(vm[index]);
          }
        },
        childCount: vm.length,
      ));
    });
  }
}

//员工列表
class DepartmentTile extends StatelessWidget {
  final DepartmentMessage msg;

  DepartmentTile(this.msg);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
      child: Card(
        child:Container(
//          margin: EdgeInsets.fromLTRB(10.0, 0, 50.0, 0,),
          child: ExpansionTile(
            title: Text(
              msg.title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            leading: Icon(
              Icons.assignment_ind,
              color: Colors.green,
            ),
            backgroundColor: Colors.white,
            initiallyExpanded: true,
            children: <Widget>[
              Divider(
                color: Colors.black,
              ),
              ...msg.personnelList.map((index) {
                return ListTile(
                  title: Text("${index.name}"),
                  trailing: Icon(Icons.check_circle_outline,color: Colors.green,),
                  onTap: null,
                );
              }).toList(),
            ],
          ),
        ),
        elevation: 10,
      ),
    );
  }
}
