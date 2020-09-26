part of "components.dart";

class TrueFireCard extends StatelessWidget {
  final String title;
  final int messageNum;
  final Function onTalCall;
  final bool isExpansion;

  TrueFireCard(
      {this.title, this.messageNum, this.onTalCall, this.isExpansion = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTalCall == null ? null : () => onTalCall(context),
      child: Card(
        color: Color.fromRGBO(192, 47, 47, 1),
        child: Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Container(
                child: SizedBox(
                  width: 20,
                ),
              ),
              Icon(FontAwesomeIcons.fireAlt,color: Colors.red,),
              Container(
                child: SizedBox(
                  width: 13,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                textScaleFactor: 1.3,
              ),
              Badge(
                badgeContent: SizedBox(
                  width: 30,
                  child: Text(
                    messageNum.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
                animationType: BadgeAnimationType.scale,
                showBadge: messageNum != 0,
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
