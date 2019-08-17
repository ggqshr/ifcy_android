part of "building_owner_pages.dart";

class OwnerPage extends StatelessWidget {
  final Function drawerCall;

  OwnerPage(this.drawerCall);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
//        title:AppBarComponent(),
      ),
    );
  }
}
