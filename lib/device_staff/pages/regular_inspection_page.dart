///@author ggq
///@description:
///@date :2019/8/3 11:34
part of 'device_staff_pages.dart';

class RegularInspectionPage extends StatefulWidget {
  @override
  _RegularInspectionPageState createState() => _RegularInspectionPageState();
}

class _RegularInspectionPageState extends State<RegularInspectionPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _floatAnimationController;
  Animation<double> _animation;
  Animation<double> _transButton;
  ScrollController _scrollController;
  DeviceStaffDeviceCheckBloc _bloc;
  DeviceCheckRepositories _deviceCheckRepositories;

  @override
  void initState() {
    super.initState();
    //当滚动到下面的时候，开始展示回到顶部按钮
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset > 500 &&
            !_floatAnimationController.isCompleted) {
          _floatAnimationController.forward();
        } else if (_scrollController.offset <= 500 &&
            _floatAnimationController.isCompleted) {
          _floatAnimationController.reverse();
        }
      });
    //初始化两个动画控制器，一个控制最上面的进度条,一个控制floatingActionButton的出现
    _floatAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    //曲线动画
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.decelerate);
    //悬浮按钮的动画
    _transButton =
        Tween<double>(begin: 56, end: -14.0).animate(_floatAnimationController);

    //执行进度条动画
    _animationController.forward();
    _bloc = BlocProvider.of<DeviceStaffDeviceCheckBloc>(context);
    _deviceCheckRepositories =
        RepositoryProvider.of<DeviceCheckRepositories>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _floatAnimationController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_animationController.isCompleted) {
      _animationController.reset();
      _animationController.forward();
    }
    return BlocProvider<DeviceListFilterBloc>(
      create: (context) => DeviceListFilterBloc(_bloc),
      child: BlocBuilder<DeviceListFilterBloc, DeviceListFilterState>(
        // ignore: missing_return
        builder: (context, state) {
          print(state);
          if (state is FilterDeviceListLoading) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("加载中"),
                  ],
                ),
              ),
            );
          }
          if (state is FilterDeviceListLoaded) {
            var models = state.models;
            return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return BlocProvider<FloorMapBloc>(
                        create: (context) {
                          return FloorMapBloc(
                            FloorMapDataRepositories(),
                            RepositoryProvider.of<UserLoginRepositories>(
                                context),
                            state.models,
                          )..add(LoadFloorDetailEvent());
                        },
                        child: FloorMapPages(),
                      );
                    })),
                    icon: Tooltip(
                      message: "楼层图",
                      child: Icon(Icons.map),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                        icon: Icon(FontAwesomeIcons.filter),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: SearchBarButton(
                          inputHistory: ["1", "2", "3"],
                          dataList: models,
                        ),
                      );
//              if (itemIndex?.isNotEmpty is bool && itemIndex.isNotEmpty) {
//                _scrollController.animateTo(
//                  60.0 + int.parse(itemIndex) * 66,
//                  duration: Duration(seconds: 1),
//                  curve: Curves.decelerate,
//                );
//              }
                    },
                    icon: Tooltip(
                      message: "搜索",
                      child: Icon(Icons.search),
                    ),
                  ),
                ],
                title: Text("工作台"),
                centerTitle: true,
              ),
              floatingActionButton: getFloatingActionButton(models
                  .where((item) => item.checkStatus == CheckStatus.localCheck)
                  .toList()),
              body: CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  if (models.isNotEmpty) ...[
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: TaskStateProcessHeader(Tween(
                              begin: 0.0,
                              end: models
                                      .where((item) =>
                                          item.checkStatus ==
                                          CheckStatus.checked)
                                      .length /
                                  models.length)
                          .animate(_animation)),
                    ),
                    SliverPersistentHeader(
                      delegate: TaskStateHeader(models),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ReadOnlyInspectionTaskDetailPanel(
                            model: models[index],
                            floorList: (_bloc.state as DeviceListLoaded)
                                .floorList,
                          );
                        },
                        childCount: models.length,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                      ),
                    )
                  ],
                  if (models.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Text("当前列表为空"),
                      ),
                    )
                ],
              ),
              endDrawer: FilterEndDrawer(
                  (_bloc.state as DeviceListLoaded).floorList),
            );
          }
        },
      ),
    );
  }

  getFloatingActionButton(List<InspectionDeviceModel> model) {
    return Builder(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          AnimatedBuilder(
            animation: _transButton,
            builder: (context, child) {
              return Transform(
                transform:
                    Matrix4.translationValues(0.0, _transButton.value, 0.0),
                child: child,
              );
            },
            child: FloatingActionButton(
              heroTag: "backtoTop",
              tooltip: "backtoTop",
              onPressed: () {
                _scrollController.animateTo(0.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate);
              },
              child: Icon(Icons.arrow_upward),
            ),
          ),
          Badge(
            showBadge: model.length != 0,
            position: BadgePosition.topRight(right: 2, top: -10),
            badgeContent: Text(
              model.length.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: FloatingActionButton(
              tooltip: "待上传列表",
              heroTag: "waiting_upload_list",
              onPressed: () {
                //点击弹出待上传列表页面，
                // 可以将已经扫码的设备进行上传，点击上传后，
                // 将待上传列表中的设备和服务器进行同步，每上传一个，就更新一个状态
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => DeviceUploadBloc(
                        _deviceCheckRepositories,
                      )..add(GetUploadData(model)),
                      child: UploadComponent(
                          (_bloc.state as DeviceListLoaded).floorList),
                    );
                  },
                ));
              },
              child: Icon(Icons.format_list_bulleted),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            tooltip: "扫码",
            onPressed: () async {
              String BRCodeScanRes; //二维码扫描结果
              try {
                BRCodeScanRes = await BarcodeScanner.scan();
              } on PlatformException catch (e) {
                if (e.code == BarcodeScanner.CameraAccessDenied) {
                  print('相机未授权');
                } else {
                  print('未知错误: $e');
                }
              } on FormatException {
//              print(
//                  'null (User returned using the "back"-button before scanning anything. Re');
              } catch (e) {
                print('未知错误: $e');
              }
              //扫描到结果
              if (BRCodeScanRes.isNotEmpty) {
                DeviceStaffDeviceCheckBloc _deviceBloc =
                    BlocProvider.of<DeviceStaffDeviceCheckBloc>(context);
                List<InspectionDeviceModel> models =
                    (_deviceBloc.state as DeviceListLoaded).models;
                var resIndex =
                    models.indexWhere((item) => item.code == BRCodeScanRes);
                if (resIndex == -1) {
                  //没有找到对应id的设备
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text("无效的二维码")));
                } else {
                  InspectionDeviceModel thisModel = models[resIndex];
                  if (thisModel.checkStatus == CheckStatus.checked) {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text("已检查过的设备")));
                  } else {
                    InspectionDeviceModel bachRes =
                        await Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return BlocProvider<DeviceDetailBloc>(
                          create: (_) => DeviceDetailBloc(_deviceBloc)
                            ..add(LoadData(thisModel)),
                          child: ScanCodeToInspectionComponent(),
                        );
                      },
                    ));
                    if (bachRes != null) {
                      bachRes.checkStatus = CheckStatus.localCheck;
                      _deviceBloc.add(UpdateDevice(bachRes));
                    }
                  }
                }
              }
            },
            child: Icon(FontAwesomeIcons.qrcode),
          ),
        ],
      );
    });
  }
}

class InspectionTaskDetailPanel<T extends TaskInfoDetail>
    extends StatelessWidget {
  final bool isExpansion;
  final bool isEdit;

  InspectionTaskDetailPanel({this.isExpansion = false, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    DeviceDetailBloc _bloc = BlocProvider.of<DeviceDetailBloc>(context);
    return BlocBuilder<DeviceDetailBloc, DeviceDetailState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is LoadingDetail) {
          return Text("加载中");
        }
        if (state is LoadedDetail) {
          InspectionDeviceModel model = state.model;
          return Card(
            elevation: 5,
            child: ExpansionTile(
              initiallyExpanded: isExpansion,
              title: Container(
                width: 200,
                child: Row(
                  children: <Widget>[
                    Text(model.name),
                    Spacer(),
                    Chip(
                      label: Text(
                        parseEnumType(model.checkStatus),
                        style: TextStyle(
                          color: model.checkStatus == CheckStatus.checked
                              ? Colors.black
                              : Colors.red,
                        ),
                      ),
                    ),
                    Chip(
                      label: Text(
                        "${state.floorList.singleWhere((item) => item.id == model.buildingFloorId).name}",
                      ),
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: Text("设备Code"),
                  subtitle: Text(state.model.code),
                ),
                ListTile(
                  title: Text("检查结果"),
                  subtitle: Row(
                    children: ["正常", "故障", "缺陷"].map((item) {
                      return Row(
                        children: <Widget>[
                          Radio(
                            value: item,
                            groupValue: parseEnumType(model.checkResult),
                            onChanged: isEdit
                                ? (value) => _bloc.add(
                                    UpdateCheckResult(parseEnumType(value)))
                                : null,
                          ),
                          Text(item)
                        ],
                      );
                    }).toList(),
                  ),
                ),
                ListTile(
                  title: Text("备注："),
                  subtitle: TextField(
                    maxLines: 3,
                    minLines: 1,
                    maxLength: 80,
                    readOnly: !isEdit,
                    decoration: InputDecoration(
                      hintText: "请输入备注",
                    ),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: model.comment ?? "",
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              affinity: TextAffinity.downstream,
                              offset: (model.comment ?? "").length),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      _bloc.add(UpdateComment(value));
                    },
                  ),
                ),
                ListTile(
                  title: Text("上传图片"),
                ),
                getPIckImg(
                  model,
                  context,
                  (imagesName, index) => _bloc.add(
                    UpdateImages(
                      imagesName,
                      index,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  getPIckImg(InspectionDeviceModel model, context, Function updateImage) {
    return ListTile(
      title: Row(
        children: <Widget>[
          model.pic1 == null || model.pic1 == "null"
              ? Container(
                  child: IconButton(
                    icon: Icon(Icons.camera_enhance),
                    onPressed: !isEdit
                        ? null
                        : () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    color: Color.fromRGBO(117, 117, 117, 1),
                                    height: 120,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).canvasColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(15),
                                          topRight: const Radius.circular(15),
                                        ),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          getPicImageTile(
                                            Icon(Icons.linked_camera),
                                            "使用相机拍摄",
                                            ImageSource.camera,
                                            updateImage,
                                            0,
                                            context,
                                          ),
                                          getPicImageTile(
                                            Icon(Icons.photo),
                                            "从相册选择",
                                            ImageSource.gallery,
                                            updateImage,
                                            0,
                                            context,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                  ),
                  constraints: BoxConstraints.tight(Size(80, 80)),
                  margin: EdgeInsets.fromLTRB(0, 3, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                )
              : getImageWithCloseIcon(model.pic1, context, updateImage, 0),
          model.pic2 == null && model.pic2 != "null"
              ? Container(
                  child: IconButton(
                    icon: Icon(Icons.camera_enhance),
                    onPressed: !isEdit
                        ? null
                        : () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    color: Color.fromRGBO(117, 117, 117, 1),
                                    height: 120,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).canvasColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(15),
                                          topRight: const Radius.circular(15),
                                        ),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          getPicImageTile(
                                            Icon(Icons.linked_camera),
                                            "使用相机拍摄",
                                            ImageSource.camera,
                                            updateImage,
                                            1,
                                            context,
                                          ),
                                          getPicImageTile(
                                            Icon(Icons.photo),
                                            "从相册选择",
                                            ImageSource.gallery,
                                            updateImage,
                                            1,
                                            context,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                  ),
                  constraints: BoxConstraints.tight(Size(80, 80)),
                  margin: EdgeInsets.fromLTRB(0, 3, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                )
              : getImageWithCloseIcon(
                  model.pic2,
                  context,
                  updateImage,
                  1,
                ),
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 5),
    );
  }

  ///传入一个图像，返回一个带有右上角取消图标的图像
  getImageWithCloseIcon(
      String thisImg, context, Function updateCall, int index) {
    return Badge(
      padding: EdgeInsets.all(0),
      position: BadgePosition.topRight(right: 2, top: -5),
      child: Container(
        constraints: BoxConstraints.tight(Size(80, 80)),
        child: CachedNetworkImage(
          cacheManager: IfcyCacheManager(),
          imageUrl: thisImg,
          imageBuilder: (context, imageProvider) {
            return Image(
              image: imageProvider,
              fit: BoxFit.fill,
            );
          },
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        margin: EdgeInsets.fromLTRB(0, 3, 10, 0),
      ),
      badgeContent: GestureDetector(
        child: Icon(
          Icons.close,
          size: 18,
          color: Colors.white,
        ),
        onTap: !isEdit
            ? null
            : () async {
                var result = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("警告"),
                      content: Text("确认删除这张图片么？"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text("确认"),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text("取消"),
                        )
                      ],
                    );
                  },
                );
                if (result) {
                  updateCall(null, index);
                  IfcyCacheManager().removeFile(thisImg);
                }
              },
      ),
    );
  }

  Widget getPicImageTile(Icon icon, String text, ImageSource source,
      Function updateCall, int index, context) {
    return ListTile(
      leading: icon,
      title: Text(text),
      onTap: () async {
        File ii = await ImagePicker.pickImage(source: source);
        if (ii != null) {
          String thisFileName = p.basename(ii.path); //获取文件名
          await IfcyCacheManager().putFile(thisFileName, await ii.readAsBytes(),
              fileExtension: 'jpg'); //将文件放到缓存管理中
          ii.deleteSync(); //删除当前文件
          updateCall(thisFileName, index); //添加到当前集合中
          Navigator.of(context).pop();
        }
      },
    );
  }
}

class ReadOnlyInspectionTaskDetailPanel extends StatelessWidget {
  final bool isExpansion;
  final InspectionDeviceModel model;
  final List<FloorEntity> floorList;

  ReadOnlyInspectionTaskDetailPanel(
      {this.isExpansion = false, this.model, this.floorList});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ExpansionTile(
        initiallyExpanded: isExpansion,
        title: Container(
          width: 200,
          child: Row(
            children: <Widget>[
              Text(model.name),
              Spacer(),
              Chip(
                label: Text(
                  parseEnumType(model.checkStatus),
                  style: TextStyle(
                    color: model.checkStatus == CheckStatus.checked
                        ? Colors.black
                        : Colors.red,
                  ),
                ),
              ),
              Chip(
                label: Text(
                  "${floorList.singleWhere((item) => item.id == model.buildingFloorId).name}",
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text("设备Code"),
            subtitle: Text(model.code),
          ),
          ListTile(
            title: Text("检查结果"),
            subtitle: Row(
              children: ["正常", "故障", "缺陷"].map((item) {
                return Row(
                  children: <Widget>[
                    Radio(
                      value: item,
                      groupValue: parseEnumType(model.checkResult),
                    ),
                    Text(item)
                  ],
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: Text("备注："),
            subtitle: TextField(
              maxLines: 3,
              minLines: 1,
              maxLength: 80,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "请输入备注",
              ),
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: model.comment ?? "",
                  selection: TextSelection.fromPosition(
                    TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: (model.comment ?? "").length),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text("上传图片"),
          ),
          getPIckImg(
            model,
            context,
          ),
        ],
      ),
    );
  }

  getPIckImg(InspectionDeviceModel model, context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          model.pic1 == null || model.pic1 == "null"
              ? Container(
                  child: IconButton(
                    icon: Icon(Icons.camera_enhance),
                    onPressed: null,
                  ),
                  constraints: BoxConstraints.tight(Size(80, 80)),
                  margin: EdgeInsets.fromLTRB(0, 3, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                )
              : getImageWithCloseIcon(model.pic1, context, 0),
          model.pic2 == null && model.pic2 != "null"
              ? Container(
                  child: IconButton(
                    icon: Icon(Icons.camera_enhance),
                    onPressed: null,
                  ),
                  constraints: BoxConstraints.tight(Size(80, 80)),
                  margin: EdgeInsets.fromLTRB(0, 3, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                )
              : getImageWithCloseIcon(
                  model.pic2,
                  context,
                  1,
                ),
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 5),
    );
  }

  ///传入一个图像，返回一个带有右上角取消图标的图像
  getImageWithCloseIcon(String thisImg, context, int index) {
    return Badge(
      padding: EdgeInsets.all(0),
      position: BadgePosition.topRight(right: 2, top: -5),
      child: Container(
        constraints: BoxConstraints.tight(Size(80, 80)),
        child: CachedNetworkImage(
          cacheManager: IfcyCacheManager(),
          imageUrl: thisImg,
          imageBuilder: (context, imageProvider) {
            return Image(
              image: imageProvider,
              fit: BoxFit.fill,
            );
          },
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        margin: EdgeInsets.fromLTRB(0, 3, 10, 0),
      ),
      badgeContent: GestureDetector(
        child: Icon(
          Icons.close,
          size: 18,
          color: Colors.white,
        ),
        onTap: null,
      ),
    );
  }
}

class SearchBarButton extends SearchDelegate<String> {
  List<String> inputHistory = ["1", "2", "3"];
  List<InspectionDeviceModel> dataList;

  SearchBarButton({
    this.inputHistory,
    this.dataList,
  });

  @override
  String get searchFieldLabel => "输入设备号或类别";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      //如果查询不为空
      if (inputHistory.contains(query)) {
        //如果当前输入历史中存在结果
        if (inputHistory.indexOf(query) != inputHistory.length - 1) {
          //如果记录中的位置不在最后一个
          inputHistory.remove(query);
          inputHistory.add(query);
        }
      } else {
        //不存在就直接添加
        inputHistory.add(query);
      }
    }
    Map<String, List<InspectionDeviceModel>> res = findResultByQuery(query);
    if (res.isEmpty) {
      return Container(
        child: Center(
          child: Text("结果为空"),
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (res['name'].isNotEmpty)
            ExpansionTile(
              title: Text("按照名字查询命中的结果"),
              children: res['name'].map((item) {
                return BlocProvider<DeviceDetailBloc>(
                  create: (_) => DeviceDetailBloc()..add(LoadData(item)),
                  child: InspectionTaskDetailPanel(),
                );
              }).toList(),
            ),
//          if (res['type'].isNotEmpty)
//            ExpansionTile(
//              title: Text("按照类别查询命中的结果"),
//              children: res['type'].map((item) {
//                return InspectionTaskDetailPanel(
//                  model: item,
//                );
//              }).toList(),
//            ),
        ],
      ),
    );
  }

  Map<String, List<InspectionDeviceModel>> findResultByQuery(
      String nameOrType) {
    if (dataList.isNotEmpty) {
      List<InspectionDeviceModel> onNameHit = [];
      List<InspectionDeviceModel> onTypeHit = [];
      for (var item in dataList) {
        if (item.name.contains(nameOrType)) {
          onNameHit.add(item);
        }
//        if (item.deviceType.contains(nameOrType)) {
//          onTypeHit.add(item);
//        }
      }
      if (onNameHit.isEmpty && onTypeHit.isEmpty) {
        return {};
      }
      return {
        "name": onNameHit,
        "type": onTypeHit,
      };
    } else {
      return {};
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        List<Widget> historyTile = inputHistory.reversed.take(10).map((item) {
          return ListTile(
            onTap: () {
              query = item;
              showResults(context);
            },
            leading: Icon(Icons.history),
            title: Text(item),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                inputHistory.remove(item);
                setState(() {});
              },
            ),
          );
        }).toList();
        return ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                "搜索历史",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: FlatButton(
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    //todo 清空缓存中输入搜索记录
                    inputHistory.clear();
                    setState(() {});
                  },
                  child: Text(
                    "清空",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  )),
            ),
            Divider(
              color: Colors.grey,
            ),
            ...historyTile,
            if (historyTile.length != 0)
              Divider(
                color: Colors.grey,
              ),
            if (historyTile.length == 0)
              ListTile(
                title: Text("空"),
              )
          ],
        );
      },
    );
  }
}

class TaskStatusChip extends StatelessWidget {
  final CheckStatusFilter taskStatus;

  TaskStatusChip(this.taskStatus);

  @override
  Widget build(BuildContext context) {
    DeviceListFilterBloc bloc = BlocProvider.of<DeviceListFilterBloc>(context);
    return BlocBuilder<DeviceListFilterBloc, DeviceListFilterState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is FilterDeviceListLoading) {
          return Text("加载中...");
        }
        if (state is FilterDeviceListLoaded) {
          return RawChip(
            label: Text(checkStatusFilterTypeString[taskStatus.index]),
            labelStyle: state.statusFilter == taskStatus
                ? TextStyle(color: Colors.white)
                : null,
            selectedColor: Colors.blue,
            showCheckmark: false,
            selected: state.statusFilter == taskStatus,
            onSelected: (checked) {
              if (checked) {
                bloc.add(UpdateStatusFilter(taskStatus));
              } else {
                bloc.add(UpdateStatusFilter(CheckStatusFilter.all));
              }
            },
          );
        }
      },
    );
  }
}

class TaskStateProcessHeader extends SliverPersistentHeaderDelegate {
  final Animation<double> animation;

  TaskStateProcessHeader(this.animation);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                return Container(
                  width: constraints.maxWidth,
                  height: 25,
                  child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: animation.value,
                        );
                      }),
                );
              },
            ),
            AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Text("当前进度: ${(animation.value * 100).toInt()}%");
                })
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => 25.0;

  @override
  double get minExtent => 25.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class TaskStateHeader extends SliverPersistentHeaderDelegate {
  final List<InspectionDeviceModel> taskDetailList;

  TaskStateHeader(this.taskDetailList);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Text("待检查设备总数:${taskDetailList.length}"),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                      "已检查设备:${taskDetailList.where((item) => item.checkStatus == CheckStatus.checked).length}"),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Text(
                      "剩余待检查设备:${taskDetailList.where((item) => item.checkStatus == CheckStatus.uncheck).length}"),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class FilterEndDrawer extends StatelessWidget {
  final List<FloorEntity> floorList;

  FilterEndDrawer(this.floorList);

  @override
  Widget build(BuildContext context) {
    DeviceListFilterBloc bloc = BlocProvider.of<DeviceListFilterBloc>(context);
    return Container(
      width: 250,
      child: Drawer(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.top,
                ),
                Center(
                  child: Container(
                    child: Text("筛选"),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text("显示任务类型"),
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TaskStatusChip(CheckStatusFilter.checked),
                            SizedBox(
                              width: 20,
                            ),
                            TaskStatusChip(CheckStatusFilter.unchecked),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Center(
                  child: Container(
                    child: Text("楼层选择"),
                  ),
                ),
                BlocBuilder<DeviceListFilterBloc, DeviceListFilterState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is FilterDeviceListLoading) {
                      return Container(
                        child: Text("加载中"),
                      );
                    }
                    if (state is FilterDeviceListLoaded) {
                      return ListTile(
                        title: Text("选择楼层:"),
                        trailing: DropdownButton(
                          items: [
                            ...floorList.map<DropdownMenuItem<String>>(
                              (item) {
                                return DropdownMenuItem(
                                  child: Text(item.name),
                                  value: item.id,
                                );
                              },
                            ).toList()
                          ],
                          onChanged: (value) =>
                              bloc.add(UpdateFloorFilter(value)),
                          value: state.floorFilter,
                        ),
                      );
                    }
                  },
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 40, //添加一个底部的留白，防止屏幕太短遮挡筛选项目
                ),
              ],
            ),
            Positioned(
              child: Container(
                width: 250,
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          bloc.add(UpdateFilterDeviceList());
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "应用",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          bloc.add(UpdateFloorFilter(null));
                          bloc.add(
                              UpdateStatusFilter(CheckStatusFilter.all));
                        },
                        child: Text("重置"),
                      ),
                    ),
                  ],
                ),
              ),
              bottom: 0,
            )
          ],
        ),
      ),
    );
  }
}
