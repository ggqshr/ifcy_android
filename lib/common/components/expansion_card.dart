part of 'components.dart';

class ExpansionCard extends StatelessWidget {
  final String title;
  final int messageNum;
  final List<Widget> viewList;

  ExpansionCard({this.title, this.messageNum, this.viewList});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              textScaleFactor: 1.3,
            ),
            Badge(
              badgeContent: SizedBox(
                width: 20,
                child: Text(
                  messageNum.toString(),
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              animationType: BadgeAnimationType.scale,
              showBadge: messageNum != 0,
            ),
            Spacer(),
            GestureDetector(
              child: Chip(
                label: Text(
                  "查看历史",
                  style: TextStyle(
                    color:Colors.black,
                  ),
                ),
              ),
              onTap: (){
                print("11111");
              },
            ),
          ],
        ),
        initiallyExpanded: false,
        children: viewList,
      ),
    );
  }
}
