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
  TaskInfoDetailListBloc<RegularInspectionTaskDetail> _taskDetailsBloc;

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

    _taskDetailsBloc =
        TaskInfoDetailListBloc.localInit(List.generate(20, (index) {
      return RegularInspectionTaskDetail.generate(index.toString());
    }));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _floatAnimationController.dispose();
    _scrollController.dispose();
    _taskDetailsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_animationController.isCompleted) {
      _animationController.reset();
      _animationController.forward();
    }
    return ChangeNotifierProvider.value(
      value: _taskDetailsBloc,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
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
                    dataList: _taskDetailsBloc.taskDetailList,
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
        floatingActionButton: getFloatingActionButton(),
        body: Consumer<TaskInfoDetailListBloc<RegularInspectionTaskDetail>>(
          builder: (context, model, child) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: TaskStateProcessHeader(Tween(
                          begin: 0.0,
                          end: model.currentCompleteTask.length /
                              model.taskDetailList.length)
                      .animate(_animation)),
                ),
                SliverPersistentHeader(
                  delegate: TaskStateHeader(model.taskDetailList),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ChangeNotifierProvider.value(
                        value: model.list2show[index],
                        child: InspectionTaskDetailPanel(),
                      );
                    },
                    childCount: _taskDetailsBloc.list2show.length,
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    "保存",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 35,
                width: 10,
                child: VerticalDivider(
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: OutlineButton(
                  onPressed: () {},
                  child: Text("上传"),
                ),
              )
            ],
          ),
        ),
        endDrawer: Container(
          width: 250,
          child: Drawer(
            child: ListView(
              children: <Widget>[
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
                            TaskStatusChip(TaskStatus.completed),
                            SizedBox(
                              width: 20,
                            ),
                            TaskStatusChip(TaskStatus.uncompleted),
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
                Consumer<TaskInfoDetailListBloc<RegularInspectionTaskDetail>>(
                  builder: (context, model, child) {
                    var floorList = model.currentFloorList;
                    floorList.sort((a,b)=>int.parse(a).compareTo(int.parse(b)));
                    return ListTile(
                      title: Text("选择楼层:"),
                      trailing: DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text("空"),
                            value: "空",
                          ),
                          ...floorList.map<DropdownMenuItem<String>>(
                            (item) {
                              return DropdownMenuItem(
                                child: Text(item),
                                value: item,
                              );
                            },
                          ).toList()
                        ],
                        onChanged: model.changeFloor,
                        value: model.currentFloor,
                      ),
                    );
                  },
                ),
                Divider(
                  color: Colors.black,
                ),
                Center(
                  child: Container(
                    child: Text("区域选择"),
                  ),
                ),
                Container(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 0),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Consumer<
                            TaskInfoDetailListBloc<
                                RegularInspectionTaskDetail>>(
                          builder: (context, model, child) {
                            return RawChip(
                              label: Text("区域${(index + 1).toString()}"),
                              labelStyle: model.areaSelected[index] &
                                      model.areaEnable[index]
                                  ? TextStyle(color: Colors.white)
                                  : null,
                              selectedColor: Colors.blue,
                              showCheckmark: false,
                              isEnabled: model.areaEnable[index],
                              selected: model.areaSelected[index] &
                                  model.areaEnable[index],
                              onSelected: (checked) {
                                model.changeAreaSelected(index, checked);
                              },
                            );
                          },
                        ),
                      );
                    },
                    itemCount: 12,
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getFloatingActionButton() {
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
        FloatingActionButton(
          onPressed: () {
//              scrollController.animateTo(
//                60.0 + 7 * 66,
//                duration: Duration(seconds: 1),
//                curve: Curves.decelerate,
//              );
          },
          child: Icon(FontAwesomeIcons.qrcode),
        ),
      ],
    );
  }
}

class InspectionTaskDetailPanel<T extends TaskInfoDetail>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<RegularInspectionTaskDetail>(context);
    return Card(
      elevation: 5,
      child: ExpansionTile(
        title: Container(
          width: 200,
          child: Row(
            children: <Widget>[
              Text(model.deviceName + model.deviceId),
              Spacer(),
              Chip(
                label: Text(
                  parseEnumType(model.taskStatus),
                  style: TextStyle(
                    color: model.taskStatus == TaskStatus.completed
                        ? Colors.black
                        : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          ListTile(
            title: Text(
              "设备类别:",
              softWrap: true,
            ),
            subtitle: Text(model.deviceType),
          ),
          ListTile(
            title: Text(
              "检查要求:",
              softWrap: true,
            ),
            subtitle: Text(
              model.inspectionRequire,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text("检查结果"),
            subtitle: Row(
              children: ["正常", "缺陷", "故障"].map((item) {
                return Row(
                  children: <Widget>[
                    Radio(
                      value: item,
                      groupValue: parseEnumType(model.inspectionResultType),
                      onChanged: model.onResultChangeCall,
                    ),
                    Text(item)
                  ],
                );
              }).toList(),
            ),
          ),
          if (model.inspectionResultType != InspectionResultType.normal) ...[
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("处理措施"),
              subtitle: Row(
                children: ["现场维修", "申请更换", "申报维修"].map(
                  (item) {
                    return Row(
                      children: <Widget>[
                        Radio(
                          value: item,
                          groupValue: parseEnumType(model.processType),
                          onChanged: model.onProcessChangeCall,
                        ),
                        Text(item),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
            ListTile(
              title: Text("备注："),
              subtitle: TextField(
                maxLines: 3,
                minLines: 1,
                maxLength: 80,
                decoration: InputDecoration(
                  hintText: "请输入备注",
                ),
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: model.noteText ?? "",
                    selection: TextSelection.fromPosition(
                      TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: (model.noteText ?? "").length),
                    ),
                  ),
                ),
                onChanged: (value) {
                  model.noteText = value;
                },
              ),
            ),
            ListTile(
              title: Text("上传图片"),
            ),
            getPIckImg(model, context),
          ]
        ],
      ),
    );
  }

  ///传入一个图像，返回一个带有右上角取消图标的图像
  getImageWithCloseIcon(
      RegularInspectionTaskDetail model, File thisImg, context) {
    return Badge(
      padding: EdgeInsets.all(0),
      position: BadgePosition.topRight(right: 2, top: -5),
      child: Container(
        constraints: BoxConstraints.tight(Size(80, 80)),
        child: Image.file(
          thisImg,
          fit: BoxFit.fill,
        ),
        margin: EdgeInsets.fromLTRB(0, 3, 10, 0),
      ),
      badgeContent: GestureDetector(
        child: Icon(
          Icons.close,
          size: 18,
          color: Colors.white,
        ),
        onTap: () async {
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
            model.removeFromImages(thisImg);
          }
        },
      ),
    );
  }

  getPIckImg(RegularInspectionTaskDetail model, context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(Icons.camera_enhance),
              onPressed: () {
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
                              ListTile(
                                leading: Icon(Icons.linked_camera),
                                title: Text("使用相机拍摄"),
                                onTap: () async {
                                  File ii = await ImagePicker.pickImage(
                                      source: ImageSource.camera);
                                  if (ii != null) {
                                    model.addToImages(ii);
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.photo),
                                title: Text("从相册选择"),
                                onTap: () async {
                                  File ii = await ImagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  if (ii != null) {
                                    model.addToImages(ii);
                                    Navigator.of(context).pop();
                                  }
                                },
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
          ),
          if (model.images.isNotEmpty)
            for (var img in model.images)
              getImageWithCloseIcon(model, img, context),
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 5),
    );
  }
}

class SearchBarButton extends SearchDelegate<String> {
  List<String> inputHistory = ["1", "2", "3"];
  List<RegularInspectionTaskDetail> dataList;

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
    Map<String, List<RegularInspectionTaskDetail>> res =
        findResultByQuery(query);
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
                return ChangeNotifierProvider.value(
                  value: item,
                  child: InspectionTaskDetailPanel(),
                );
              }).toList(),
            ),
          if (res['type'].isNotEmpty)
            ExpansionTile(
              title: Text("按照类别查询命中的结果"),
              children: res['type'].map((item) {
                return ChangeNotifierProvider.value(
                  value: item,
                  child: InspectionTaskDetailPanel(),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Map<String, List<RegularInspectionTaskDetail>> findResultByQuery(
      String nameOrType) {
    if (dataList.isNotEmpty) {
      List<RegularInspectionTaskDetail> onNameHit = [];
      List<RegularInspectionTaskDetail> onTypeHit = [];
      for (var item in dataList) {
        if (item.deviceName.contains(nameOrType)) {
          onNameHit.add(item);
        }
        if (item.deviceType.contains(nameOrType)) {
          onTypeHit.add(item);
        }
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
  final TaskStatus taskStatus;

  TaskStatusChip(this.taskStatus);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskInfoDetailListBloc<RegularInspectionTaskDetail>>(
      builder: (context, model, child) {
        return RawChip(
          label: Text(parseEnumType(taskStatus)),
          labelStyle: model.currentShowTaskStatus == taskStatus
              ? TextStyle(color: Colors.white)
              : null,
          selectedColor: Colors.blue,
          showCheckmark: false,
          selected: model.currentShowTaskStatus == taskStatus,
          onSelected: (checked) {
            if (checked) {
              model.changeTaskStatusByIndex(taskStatus);
            } else {
              model.changeTaskStatusByIndex(null);
            }
          },
        );
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
            Text("当前进度: 50%"),
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
    return false;
  }
}

class TaskStateHeader extends SliverPersistentHeaderDelegate {
  final List<RegularInspectionTaskDetail> taskDetailList;

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
                      "已检查设备:${taskDetailList.where((item) => item.taskStatus == TaskStatus.completed).length}"),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Text(
                      "剩余待检查设备:${taskDetailList.where((item) => item.taskStatus == TaskStatus.uncompleted).length}"),
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
    return false;
  }
}
