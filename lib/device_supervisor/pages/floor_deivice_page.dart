part of device_supvisor_pages;

class FloorDevicePage extends StatelessWidget {
  final bool isFire;

  FloorDevicePage(this.isFire);

  @override
  Widget build(BuildContext context) {
    FloorDeviceBloc bloc = BlocProvider.of<FloorDeviceBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("楼层图页面"),
      ),
      body: BlocListener<FloorDeviceBloc, FloorDeviceState>(
        listener: (context, state) {
          if (state is LoadedFloorDeviceState) {
            if (state.isLoading) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('加载中'),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
            }
            if (!state.isLoading) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('加载成功'),
                        Icon(Icons.check),
                      ],
                    ),
                  ),
                );
            }
          }
        },
        child: BlocBuilder<FloorDeviceBloc, FloorDeviceState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is LoadingFloorDeviceState) {
              return LoadingPage();
            }
            if (state is LoadErrorFloorDeviceState) {
              return LoadErrorPage(
                  () => bloc.dispatch(LoadFloorDeviceDetailEvent()));
            }
            if (state is LoadedFloorDeviceState) {
              if (state.isLoading) {
                return LoadingPage();
              } else {
                return FutureBuilder<File>(
                  future: IfcyCacheManager()
                      .getSingleFile(state.currentFloor.picture),
                  builder:
                      (BuildContext context, AsyncSnapshot<File> snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(
                        child: Text("加载错误"),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("加载中"),
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                                "位置${state.currentFloor.name}${state.device.position}"),
                          ),
                          Container(
                            width: 400,
                            height: 400,
                            child: StackMap(
                              height: double.parse(state.currentFloor.length),
                              width: double.parse(state.currentFloor.width),
                              buildingMap: FileImage(snapshot.data),
                              markers: [
                                parseMarker(
                                  x: double.parse(state.device.xposition),
                                  y: double.parse(state.device.yposition),
                                  imageName: "images/${GetImageName.typeCodeGetImageName(
                                      state.device.categoryCode, isFire)}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
