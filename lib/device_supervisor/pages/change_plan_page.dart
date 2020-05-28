part of "device_supvisor_pages.dart";

class ChangePlanPage extends StatefulWidget {
  final TaskPlanEntity model;

  ChangePlanPage(this.model);

  @override
  _ChangePlanPageState createState() => _ChangePlanPageState();
}

class _ChangePlanPageState extends State<ChangePlanPage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _textEditingController;
  TextEditingController _planNameController;
  TextEditingController _commentController;
  AddTaskBlocModel model;
  ChangePlanBloc bloc;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController.fromValue(
      TextEditingValue(
        text: "1",
        selection: TextSelection.fromPosition(
          TextPosition(affinity: TextAffinity.downstream, offset: 1),
        ),
      ),
    );
    _planNameController = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.model.name??"",
        selection: TextSelection.fromPosition(
          TextPosition(affinity: TextAffinity.downstream, offset: widget.model.name?.length??0),
        ),
      ),
    );
    _commentController = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.model.noteText??"",
        selection: TextSelection.fromPosition(
          TextPosition(affinity: TextAffinity.downstream, offset: widget.model.noteText?.length??0),
        ),
      ),
    );
    bloc = BlocProvider.of<ChangePlanBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: PageStorageKey("change_plan_stepper"),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("修改计划"),
      ),
      body: BlocListener<ChangePlanBloc, ChangePlanState>(
        bloc: bloc,
        listener: (context, state) async {
          if (state is LoadedChangePlanState) {
            if (state.isFault) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('提交失败，请稍后再试'), Icon(Icons.error)],
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
            }
            if (state.isSubmitting) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('提交中'),
                        CircularProgressIndicator(),
                      ],
                    ),
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
                        Text('修改成功'),
                        Icon(Icons.check),
                      ],
                    ),
                  ),
                );
              await Future.delayed(Duration(seconds: 1));
              Navigator.of(context).pop();
            }
          }
        },
        child: BlocBuilder(
          // ignore: missing_return
          builder: (context, state) {
            if (state is LoadingChangePlanState) {
              return LoadingPage();
            }
            if (state is LoadErrorChangePlanState) {
              return LoadErrorPage(() => bloc.add(InitPageEvent()));
            }
            if (state is LoadedChangePlanState) {
              model ??= AddTaskBlocModel(
                currentBuilding: state.currentBuilding,
                allInspectionSystem: state.systems,
                allPeople: state.people,
                allTaskCycle: state.cycles,
                thisModel: state.model..inspectionType=NewInspectionType.plan,
              );
              return ChangeNotifierProvider<AddTaskBlocModel>.value(
                value: model,
                child:
                    Consumer<AddTaskBlocModel>(builder: (context, vm, child) {
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
                                    title: Text("任务名"),
                                    subtitle: TextField(
                                      controller: _planNameController,
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
                                          Text(
                                              "已选${vm.model.currentFloor.length}层"),
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
                                              "已选${vm.model.selectedSystem.map((item) => item.inspectionItem.length).where((item) => item > 0).length}项"),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          RaisedButton(
                                            onPressed: () {
                                              vm.fillSelectSystem();
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
                                      value: vm.model.cycle,
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
                                      subtitle: Text(
                                          vm.model.firstStartTime != null
                                              ? vm.model.firstStartTime
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
                                          Text(
                                              "已选${vm.model.selectedPeople.length}人"),
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
//                                if (vm.inspectionType == NewInspectionType.plan)
//                                  SwitchListTile(
//                                    title: Text("是否立即启用"),
//                                    value: vm.isEnable,
//                                    onChanged: vm.changeEnable,
//                                  ),
                                  ListTile(
                                    title: Text("备注"),
                                    subtitle: TextField(
                                      controller: _commentController,
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
//                            onStepTapped: (index) {
//                              if (Form.of(context).validate()) {
//                                vm.stepperCall(index);
//                              }
//                            },
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
                                      if (vm
                                          .index2validate[vm.stepperIndex]()) {
                                        vm.nextStepperCall();
                                      }
                                    },
                                    child: Text("下一步"),
                                  ),
                                if (vm.stepperIndex == 3)
                                  FlatButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      if (vm
                                          .index2validate[vm.stepperIndex]()) {
                                        vm.submitData((model) => bloc.add(
                                            SubmitChangeEvent(model)));
                                      }
                                    },
                                    child: Text(
                                      "修改",
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
              );
            }
          },
          bloc: bloc,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
