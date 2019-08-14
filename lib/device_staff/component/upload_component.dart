///@author ggq
///@description: 上传列表的页面
///@date :2019/8/14 10:31
part of 'device_staff_components.dart';
class UploadComponent extends StatelessWidget {
  final TaskInfoDetailListBloc<RegularInspectionTaskDetail> model;

  UploadComponent(this.model);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Consumer<
          TaskInfoDetailListBloc<
              RegularInspectionTaskDetail>>(
          builder: (context, mm, child) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("待上传列表"),
              ),
              body: model.list2upload.isEmpty
                  ? Center(child: Text("空"))
                  : ListView.builder(
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: mm.list2upload.toList()[index],
                    child: InspectionTaskDetailPanel(),
                  );
                },
                itemCount: model.list2upload.length,
              ),
              bottomNavigationBar: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: FlatButton(
                  onPressed: model.list2upload.isEmpty
                      ? null
                      : () async {
                    loadingDialogAction
                        .showLoadingDialog("上传中");
                    await model.upload2server();
                    loadingDialogAction
                        .cancleLoadingDialog();
                  },
                  child: Text(
                    "上传",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                ),
              ),
            );
          }),
    );
  }
}
