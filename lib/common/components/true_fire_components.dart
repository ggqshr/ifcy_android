part of "components.dart";
class TrueFireComponent extends StatelessWidget {
  final int trueFireNum;

  TrueFireComponent(this.trueFireNum);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return TrueFireCard(
            title: "火警消息",
            messageNum: trueFireNum,
            onTalCall: (context) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BlocProvider<CheckAlarmListBloc>(
                  create: (context) =>
                  CheckAlarmListBloc(CheckAlarmRepositories())
                    ..add(FetchCheckedAlarmData(true)),
                  child: CheckedAlarmPage(
                        (thisTask) => CheckResultComponent(
                        "真火警"),
                    true,
                        (isfire) => RefreshTrueAlarmData(),
                        (isfire) => FetchTrueAlarmData(),
                    titleString: "火警信息",
                  ),
                );
              }));
            },
          );
        },
        childCount: 1,
      ),
    );
  }
}

