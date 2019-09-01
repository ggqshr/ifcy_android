///@author ggq
///@description: 上传列表的页面
///@date :2019/8/14 10:31
part of 'device_staff_components.dart';

class UploadComponent extends StatelessWidget {
  final List<FloorEntity> floorList;
  UploadComponent(this.floorList);
  @override
  Widget build(BuildContext context) {
    DeviceUploadBloc _bloc = BlocProvider.of<DeviceUploadBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("待上传列表"),
      ),
      body: BlocListener<DeviceUploadBloc, DeviceUploadState>(
        listener: (context, state) {
          if (state is LoadedUploadDevice) {
            if (state.isUploading) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('提交中...'),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
            }
            if (state.isFault) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('提交失败'), Icon(Icons.error)],
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
            }
            if (state.isSuccess) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('提交成功'),
                        Icon(Icons.check),
                      ],
                    ),
                  ),
                );
            }
          }
        },
        child: BlocBuilder<DeviceUploadBloc,DeviceUploadState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is InitialDeviceUploadState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadedUploadDevice) {
              if (state.models.isEmpty) {
                return Center(
                  child: Text("无需要上传的设备"),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ReadOnlyInspectionTaskDetailPanel(
                      model: state.models[index],
                      floorList: floorList,
                      isExpansion: true,
                    );
                  },
                  itemCount: state.models.length,
                );
              }
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: BlocBuilder<DeviceUploadBloc,DeviceUploadState>(
          // ignore: missing_return
          builder: (context, state) {
            if(state is InitialDeviceUploadState){
              return CircularProgressIndicator();
            }
            if (state is LoadedUploadDevice) {
              return FlatButton(
                onPressed: state.models.isEmpty
                    ? null
                    : () async {
                        _bloc.dispatch(UploadToServer());
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
              );
            }
          },
        ),
      ),
    );
  }
}
