part of "device_supvisor_pages.dart";

class SupervisorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarComponent(),
        centerTitle: true,
        automaticallyImplyLeading: true,
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
//          SupervisorListComponent()
        ],
      ),
    );
  }
}
