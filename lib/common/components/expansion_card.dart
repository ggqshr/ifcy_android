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
        title: Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 12
              ),
              textScaleFactor: 1.3,
            ),
            Badge(
              badgeContent: SizedBox(
                //width: 20,
                child: Text(
                  messageNum.toString(),
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              animationType: BadgeAnimationType.scale,
              shape:BadgeShape.circle,
              showBadge: messageNum != 0,
            ),
          ],
        ),
        initiallyExpanded: true,
        children: viewList,
      ),
    );
  }
}
