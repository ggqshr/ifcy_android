part of "device_staff_pages.dart";

class FloorMapPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FloorMapBloc bloc = BlocProvider.of<FloorMapBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("楼层图页面"),
      ),
      body: BlocListener<FloorMapBloc, FloorMapState>(
        listener: (context, state) {
          if (state is LoadedFloorMapState) {
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
        child: BlocBuilder<FloorMapBloc, FloorMapState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is LoadingFloorMapState) {
              return LoadingPage();
            }
            if (state is LoadErrorFloorMapState) {
              return LoadErrorPage(() => bloc.dispatch(LoadFloorDetailEvent()));
            }
            if (state is LoadedFloorMapState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text("请选择楼层"),
                    trailing: DropdownButton(
                      items: state.floors
                          .map<DropdownMenuItem>(
                              (item) => DropdownMenuItem<String>(
                            value: item.id,
                            child: Text(item.name),
                          ))
                          .toList(),
                      value: state.currentFloor?.id,
                      onChanged: (value) => bloc.dispatch(
                        ChangeFloorEvent(value),
                      ),
                    ),
                  ),
                  if (state.currentFloor == null)
                    Center(
                      child: Text("请选择楼层"),
                    ),
                  if (state.currentFloor != null)
                    FutureBuilder<File>(
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
                          return Container(
                            width: 400,
                            height: 400,
                            child: StackMap(
                              height: double.parse(state.currentFloor.length),
                              width: double.parse(state.currentFloor.width),
                              buildingMap: FileImage(snapshot.data),
                              markers: state.devices
                                  .where((item) =>
                              item.buildingFloorId ==
                                  state.currentFloor.id)
                                  .map(
                                    (item) => parseMarker(
                                  x: double.parse(item.xPosition),
                                  y: double.parse(item.yPosition),
                                  imageName:
                                  item.checkStatus == CheckStatus.checked
                                      ? "images/complete.png"
                                      : "images/uncomplete.png",
                                ),
                              )
                                  .toList(),
                            ),
                          );
                        }
                      },
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
