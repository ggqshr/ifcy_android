///@author ggq
///@description: 显示计划的页面
///@date :2019/8/21 15:47
part of 'device_supvisor_pages.dart';

class PlanListPage extends StatefulWidget {
  @override
  _PlanListPageState createState() => _PlanListPageState();
}

class _PlanListPageState extends State<PlanListPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: (store) {
        store.dispatch(initPlanListThunkAction);
      },
      builder: (context, store) {
        return ListView.builder();
      },
    );
  }
}
