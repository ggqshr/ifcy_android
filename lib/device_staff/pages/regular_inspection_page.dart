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
  List<RegularInspectionTaskDetail> _taskDetails;
  ScrollController _scrollController;

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
        Tween<double>(begin: 45, end: -14.0).animate(_floatAnimationController);

    //执行进度条动画
    _animationController.forward();

    _taskDetails = List.generate(50, (index) {
      return RegularInspectionTaskDetail.generate(index.toString());
    });
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
    _animation = Tween(begin: 0.0, end: 0.5).animate(_animation);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: null,
            icon: Icon(FontAwesomeIcons.filter),
          ),
          IconButton(
            onPressed: () async {
              String itemIndex = await showSearch(
                  context: context, delegate: SearchBarButton());
              if (itemIndex?.isNotEmpty is bool) {
                _scrollController.animateTo(
                  60.0 + int.parse(itemIndex) * 66,
                  duration: Duration(seconds: 1),
                  curve: Curves.decelerate,
                );
              }
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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: TaskStateHeader(_animation),
          ),
          SliverAppBar(
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Text("待检查设备总数:6"),
                          SizedBox(
                            width: 20,
                          ),
                          Text("已检查设备:6"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Text("剩余待检查设备:6"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            expandedHeight: 60,
            automaticallyImplyLeading: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return InspectionTaskDetailPanel(
                  _taskDetails[index],
                );
              },
              childCount: _taskDetails.length,
            ),
          ),
        ],
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
          child: FloatingActionButton.extended(
            heroTag: "backtoTop",
            tooltip: "backtoTop",
            onPressed: () {
              _scrollController.animateTo(0.0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            },
            icon: Icon(Icons.arrow_upward),
            label: Text("回顶"),
          ),
        ),
        FloatingActionButton.extended(
          onPressed: () {
//              scrollController.animateTo(
//                60.0 + 7 * 66,
//                duration: Duration(seconds: 1),
//                curve: Curves.decelerate,
//              );
          },
          label: Text("扫码"),
          icon: Icon(FontAwesomeIcons.qrcode),
        ),
      ],
    );
  }
}

class InspectionTaskDetailPanel<T extends TaskInfoDetail>
    extends StatelessWidget {
  final T taskDetail;

  InspectionTaskDetailPanel(
    this.taskDetail,
  );

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      Function onResultChangeCall = (value) {
        taskDetail.inspectionResultType = parseEnumType(value);
        setState(() {});
      };
      Function onProcessChangeCall = (value) {
        taskDetail.processType = parseEnumType(value);
        setState(() {});
      };
      return Card(
        elevation: 5,
        child: ExpansionTile(
          title: Text(
            taskDetail.deviceName + taskDetail.deviceId,
          ),
          children: <Widget>[
            ListTile(
              title: Text(
                "设备类别:",
                softWrap: true,
              ),
              subtitle: Text(taskDetail.deviceType),
            ),
            ListTile(
              title: Text(
                "检查要求:",
                softWrap: true,
              ),
              subtitle: Text(
                taskDetail.inspectionRequire,
                softWrap: true,
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
                        groupValue:
                            parseEnumType(taskDetail.inspectionResultType),
                        onChanged: onResultChangeCall,
                      ),
                      Text(item)
                    ],
                  );
                }).toList(),
              ),
            ),
            if (taskDetail.inspectionResultType !=
                InspectionResultType.normal) ...[
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
                            groupValue: parseEnumType(taskDetail.processType),
                            onChanged: onProcessChangeCall,
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
                      text: taskDetail.noteText ?? "",
                      selection: TextSelection.fromPosition(
                        TextPosition(
                            affinity: TextAffinity.downstream,
                            offset: (taskDetail.noteText ?? "").length),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    taskDetail.noteText = value;
                  },
                ),
              ),
              ListTile(
                title: Text("上传图片"),
              ),
              getPIckImg(taskDetail.images, context, setState),
            ]
          ],
        ),
      );
    });
  }

  ///传入一个图像，返回一个带有右上角取消图标的图像
  getImageWithCloseIcon(List<File> images, File thisImg, context, setState) {
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
            images.remove(thisImg);
            setState(() {});
          }
        },
      ),
    );
  }

  getPIckImg(List<File> images, context, setState) {
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
                                    setState(() {
                                      images.add(ii);
                                    });
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
                                    setState(() {
                                      images.add(ii);
                                    });
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
          if (images.isNotEmpty)
            for (var img in images)
              getImageWithCloseIcon(images, img, context, setState),
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 5),
    );
  }
}

class SearchBarButton extends SearchDelegate<String> {
  List<String> inputHistory = ["1", "2", "3"];
  List<String> dataList = ["4", "5", "6"];

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
    close(context, query);
    return Container();
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

class TaskStateHeader extends SliverPersistentHeaderDelegate {
  final Animation<double> animation;

  TaskStateHeader(this.animation);

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
            Text("当前进度: %50"),
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
