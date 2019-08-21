///@author ggq
///@description: 添加任务的页面
///@date :2019/8/19 14:50

part of 'device_supvisor_pages.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _textEditingController;
  AddTaskBlocModel model;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
        key: PageStorageKey("add_task_page"),
        onInit: (store) {
          //初始化数据
          store.dispatch(initAddTaskData);
          _textEditingController = TextEditingController.fromValue(
            TextEditingValue(
              text: "1",
              selection: TextSelection.fromPosition(
                TextPosition(affinity: TextAffinity.downstream, offset: 1),
              ),
            ),
          );
        },
        onDispose: (store) {
          _textEditingController.dispose();
        },
        builder: (context, store) {
          DeviceSupervisorModel deviceSupervisorModel =
              store.state.deviceSupervisorModel;
          if (model == null ||
              model.allInspectionSystem == null ||
              model.allPeople == null) {
            model = AddTaskBlocModel(
                allBuilding:
                    deviceSupervisorModel.buildingList.skip(1).toList(),
                allInspectionSystem: deviceSupervisorModel.inspectionSystems,
                allPeople: deviceSupervisorModel.departmentMessages,
                allTaskCycle: deviceSupervisorModel.taskCycleMessages);
          }
          return ChangeNotifierProvider<AddTaskBlocModel>.value(
            value: model,
            child: Scaffold(
              key: PageStorageKey("add_task_stepper"),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text("发布新任务或计划"),
              ),
              body: Consumer<AddTaskBlocModel>(builder: (context, vm, child) {
                return Container(
                  child: Form(
                    child: Builder(builder: (context) {
                      return Stepper(
                        steps: [
                          Step(
                            title: Text("第一步"),
                            content: ListView(
                              children: <Widget>[
                                ListTile(
                                  title: Text("选择类型"),
                                  subtitle: Row(
                                    children: ["计划", "任务"].map((item) {
                                      return Row(
                                        children: <Widget>[
                                          Radio(
                                            value: item,
                                            groupValue: parseEnumType(
                                                vm.inspectionType),
                                            onChanged:
                                                model.changeInspectionType,
                                          ),
                                          Text(item)
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                                ListTile(
                                  title: Text("选择大厦"),
                                  subtitle: DropdownButtonFormField(
                                    items: vm.allBuilding.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item.buildName),
                                        value: item,
                                      );
                                    }).toList(),
                                    onChanged: vm.changeCurrentBuilding,
                                    value: vm.currentBuild,
                                    hint: Text("请选择大厦"),
                                    decoration: InputDecoration(
                                        errorText: vm.buildingErrorMag),
                                  ),
                                ),
                                ListTile(
                                  title: Text("任务名"),
                                  subtitle: TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        hintText: "任务或计划名称",
                                        errorText: vm.nameErrorMsg),
                                    onChanged: (value) {
                                      vm.changeName(value);
                                    },
                                  ),
                                ),
                              ],
                              shrinkWrap: true,
                            ),
                            isActive: true,
                          ),
                          Step(
                            title: Text("第二步"),
                            content: ListView(
                              children: <Widget>[
                                ChildWithInputDecorator(
                                  vm.floorErrorMsg,
                                  ListTile(
                                    title: Text("选择楼层"),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text("已选${vm.currentFloor.length}层"),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) {
                                                  return ChangeNotifierProvider<
                                                      AddTaskBlocModel>.value(
                                                    value: vm,
                                                    child: SelectFloorPage(),
                                                  );
                                                });
                                          },
                                          child: Text("选择楼层"),
                                        )
                                      ],
                                    ),
                                  ),
                                  vm,
                                ),
                                ChildWithInputDecorator(
                                  vm.checkSystemErrorMsg,
                                  ListTile(
                                    title: Text("选择检查系统"),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                            "已选${vm.selectedSystem.map((item) => item.inspectionItem.length).where((item) => item > 0).length}项"),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            if (vm.selectedSystem.isEmpty) {
                                              vm.initSelectSystem();
                                            }
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) {
                                                  return ChangeNotifierProvider<
                                                      AddTaskBlocModel>.value(
                                                    value: vm,
                                                    child:
                                                        SelectCheckSystemPage(),
                                                  );
                                                });
                                          },
                                          child: Text("选择系统"),
                                        )
                                      ],
                                    ),
                                  ),
                                  vm,
                                ),
                              ],
                              shrinkWrap: true,
                            ),
                            isActive: true,
                          ),
                          if (vm.inspectionType == NewInspectionType.plan)
                            Step(
                              isActive: true,
                              title: Text("第三步"),
                              content: ListView(
                                children: <Widget>[
                                  ListTile(
                                    title: Text("任务执行周期"),
                                    subtitle: DropdownButtonFormField(
                                      hint: Text("选择任务执行周期"),
                                      items: vm.allTaskCycle.map((item) {
                                        return DropdownMenuItem(
                                          child: Text(item.item),
                                          value: item,
                                        );
                                      }).toList(),
                                      onChanged: vm.changeTaskCycle,
                                      value: vm.taskCycleModel,
                                    ),
                                  ),
                                  ChildWithInputDecorator(
                                    vm.firstStartTimeErrorMsg,
                                    ListTile(
                                      title: Text("第一次任务开始时间"),
                                      trailing: RaisedButton(
                                        onPressed: () async {
                                          Locale myLocale =
                                              Localizations.localeOf(context);
                                          DateTime dd = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2019),
                                              lastDate: DateTime(2050),
                                              locale: myLocale);
                                          if (dd != null) {
                                            vm.setFirstStartTime(dd);
                                          }
                                        },
                                        child: Text("选择时间"),
                                      ),
                                      subtitle: Text(vm.firstStartTime != null
                                          ? vm.firstStartTime
                                              .toString()
                                              .substring(0, 10)
                                          : "未选择"),
                                    ),
                                    vm,
                                  ),
                                  ListTile(
                                    title: Text("选择任务执行时间"),
                                    subtitle: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        suffixText: "天",
                                      ),
                                      controller: _textEditingController
                                        ..addListener(() {
                                          vm.setSustainedTime(int.parse(
                                              _textEditingController.text));
                                        }),
                                    ),
                                  ),
                                ],
                                shrinkWrap: true,
                              ),
                            ),
                          if (vm.inspectionType == NewInspectionType.task)
                            Step(
                              isActive: true,
                              title: Text("第三步"),
                              content: ListView(
                                children: <Widget>[
                                  ChildWithInputDecorator(
                                    vm.startTimeErrorMsg,
                                    ListTile(
                                        title: Text("任务开始时间"),
                                        trailing: RaisedButton(
                                          onPressed: () async {
                                            Locale myLocale =
                                                Localizations.localeOf(context);
                                            DateTime dd = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2019),
                                                lastDate: DateTime(2050),
                                                locale: myLocale);
                                            if (dd != null) {
                                              vm.setStartTime(dd);
                                            }
                                          },
                                          child: Text("选择时间"),
                                        ),
                                        subtitle: Text(vm.startTime != null
                                            ? vm.startTime
                                                .toString()
                                                .substring(0, 10)
                                            : "未选择")),
                                    vm,
                                  ),
                                  ChildWithInputDecorator(
                                    vm.endTimeErrorMsg,
                                    ListTile(
                                      title: Text("任务结束时间"),
                                      trailing: RaisedButton(
                                        onPressed: () async {
                                          Locale myLocale =
                                              Localizations.localeOf(context);
                                          DateTime dd = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2019),
                                              lastDate: DateTime(2050),
                                              locale: myLocale);
                                          if (dd != null) {
                                            vm.setEndTime(dd);
                                          }
                                        },
                                        child: Text("选择时间"),
                                      ),
                                      subtitle: Text(vm.endTime != null
                                          ? vm.endTime
                                              .toString()
                                              .substring(0, 10)
                                          : "未选择"),
                                    ),
                                    vm,
                                  ),
                                ],
                                shrinkWrap: true,
                              ),
                            ),
                          Step(
                            isActive: true,
                            title: Text("第四步"),
                            content: ListView(
                              children: <Widget>[
                                ChildWithInputDecorator(
                                  vm.peopleErrorMsg,
                                  ListTile(
                                    title: Text("选择执行人员"),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text("已选${vm.selectedPeople.length}人"),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) {
                                                  return ChangeNotifierProvider<
                                                      AddTaskBlocModel>.value(
                                                    value: vm,
                                                    child: SelectPeoplePage(),
                                                  );
                                                });
                                          },
                                          child: Text("选择人员"),
                                        )
                                      ],
                                    ),
                                  ),
                                  vm,
                                ),
                                if (vm.inspectionType == NewInspectionType.plan)
                                  SwitchListTile(
                                    title: Text("是否立即启用"),
                                    value: vm.isEnable,
                                    onChanged: vm.changeEnable,
                                  ),
                                ListTile(
                                  title: Text("备注"),
                                  subtitle: TextField(
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      vm.changeNoteText(value);
                                    },
                                  ),
                                ),
                              ],
                              shrinkWrap: true,
                            ),
                          )
                        ],
                        currentStep: vm.stepperIndex,
                        onStepCancel: vm.cancelStepperCall,
                        onStepContinue: vm.nextStepperCall,
                        onStepTapped: (index) {
                          if (Form.of(context).validate()) {
                            vm.stepperCall(index);
                          }
                        },
                        controlsBuilder: (BuildContext context,
                            {VoidCallback onStepContinue,
                            VoidCallback onStepCancel}) {
                          return Row(
                            children: <Widget>[
                              if (vm.stepperIndex != 0)
                                FlatButton(
                                  onPressed: () {
                                    vm.cancelStepperCall();
                                  },
                                  child: Text("上一步"),
                                ),
                              if (vm.stepperIndex != 3)
                                FlatButton(
                                  onPressed: () {
                                    if (vm.index2validate[vm.stepperIndex]()) {
                                      vm.nextStepperCall();
                                    }
                                  },
                                  child: Text("下一步"),
                                ),
                              if (vm.stepperIndex == 3)
                                FlatButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    if (vm.index2validate[vm.stepperIndex]()) {
                                      loadingDialogAction.showLoadingDialog(
                                          text2show: "提交中",
                                          newContext: context);
                                      vm.submitData((model) => store.dispatch(
                                          submitInspectionTask(model)));
                                    }
                                  },
                                  child: Text(
                                    "提交",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                            ],
                          );
                        },
                      );
                    }),
                  ),
                );
              }),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}

class SelectFloorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddTaskBlocModel>(
      builder: (context, vm, child) {
        return Container(
          height: 600,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("确定")),
              ],
            ),
            body: ListView.separated(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CheckboxListTile(
                    title: Text("全选"),
                    onChanged: vm.changAllFloor,
                    value:
                        vm.currentFloor.length == vm.currentBuild.floors.length,
                  );
                }
                return CheckboxListTile(
                  title: Text(vm.currentBuild.floors[index - 1].name),
                  value: vm.currentFloor
                      .contains(vm.currentBuild.floors[index - 1]),
                  onChanged: (value) {
                    vm.changeCurrentFloor(value, index - 1);
                  },
                );
              },
              itemCount: vm.currentBuild.floors.length + 1,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.black,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class SelectCheckSystemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddTaskBlocModel>(
      builder: (context, vm, child) {
        return Container(
          height: 600,
          child: Scaffold(
            appBar: AppBar(
              title: Text("选择检查系统"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("确定")),
              ],
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                if (index != 0) {
                  var thisSystem = vm.allInspectionSystem[index - 1];
                  return ExpansionTile(
                    title: Text(thisSystem.name),
                    leading: Checkbox(
                        value: vm.selectedSystem[index - 1].inspectionItem
                                .length ==
                            thisSystem.inspectionItem.length,
                        onChanged: (value) =>
                            vm.changeSelectSystem(value, index - 1)),
                    children: thisSystem.inspectionItem.map((item) {
                      return CheckboxListTile(
                        value: vm.selectedSystem[index - 1].inspectionItem
                            .contains(item),
                        onChanged: (value) =>
                            vm.changeSelectCheckItem(value, index - 1, item),
                        title: Text(item.name),
                      );
                    }).toList(),
                  );
                } else {
                  return ListTile(
                    title: Text("全选"),
                    leading: Checkbox(
                        value: vm.selectedSystem
                            .map((item) => item.inspectionItem.length)
                            .toSet()
                            .difference(vm.allInspectionSystem
                                .map((item) => item.inspectionItem.length)
                                .toSet())
                            .isEmpty,
                        onChanged: (value) => vm.selectAllSystem(value)),
                  );
                }
              },
              itemCount: vm.allInspectionSystem.length + 1,
            ),
          ),
        );
      },
    );
  }
}

class SelectPeoplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddTaskBlocModel>(
      builder: (context, vm, child) {
        return Container(
          height: 600,
          child: Scaffold(
            appBar: AppBar(
              title: Text("选择执行人员"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("确定")),
              ],
            ),
            body: ListView.separated(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CheckboxListTile(
                    value: vm.allPeople.length == vm.selectedPeople.length,
                    onChanged: vm.selectAllPeople,
                    title: Text("全选"),
                  );
                } else {
                  return CheckboxListTile(
                    value: vm.selectedPeople.contains(vm.allPeople[index - 1]),
                    onChanged: (value) =>
                        vm.changeSelectPeople(value, index - 1),
                    title: Text(vm.allPeople[index - 1].name),
                  );
                }
              },
              itemCount: vm.allPeople.length + 1,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          ),
        );
      },
    );
  }
}

class ChildWithInputDecorator extends StatelessWidget {
  final String errorMsg;
  final Widget child;
  final vm;

  ChildWithInputDecorator(this.errorMsg, this.child, this.vm);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      child: child,
      decoration: InputDecoration(errorText: errorMsg),
    );
  }
}
