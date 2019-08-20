///@author ggq
///@description: 添加任务的页面
///@date :2019/8/19 14:50

part of 'device_supvisor_pages.dart';

class AddTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
        key: PageStorageKey("add_task_page"),
        onInit: (store) {
          //初始化数据
          store.dispatch(initAddTaskData);
          print("init");
        },
        builder: (context, store) {
          DeviceSupervisorModel deviceSupervisorModel =
              store.state.deviceSupervisorModel;
          AddTaskBlocModel model = AddTaskBlocModel(
              allBuilding: deviceSupervisorModel.buildingList.skip(1).toList(),
              allInspectionSystem: deviceSupervisorModel.inspectionSystems,
              allPeople: deviceSupervisorModel.departmentMessages,
              allTaskCycle: deviceSupervisorModel.taskCycleMessages);
          return ChangeNotifierProvider<AddTaskBlocModel>.value(
            value: model,
            child: Scaffold(
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
                                    validator: (value) {
                                      if (value == null) {
                                        return "请选择大厦";
                                      }
                                      return null;
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
                                  ListTile(
                                    title: Text("选择检查系统"),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 20,
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            vm.initSelectSystem();
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
                                ],
                                shrinkWrap: true,
                              ),
                              isActive: true),
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
                              FlatButton(
                                onPressed: () {
                                  if (Form.of(context).validate()) {
                                    vm.nextStepperCall();
                                  }
                                },
                                child: Text("下一步"),
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
