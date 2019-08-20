///@author ggq
///@description: 增加任务页面的bloc model
///@date :2019/8/19 15:12
part of 'device_supervisor_model.dart';

///巡检类型，是计划还是任务
enum NewInspectionType {
  plan, //计划
  task, //任务
}

Map<int, String> newInspectionTypeTypeMap = {
  0: "计划",
  1: "任务",
};

///发布计划或者任务页面的bloc逻辑类
class AddTaskBlocModel with ChangeNotifier {
  ///Stepper的下标
  int stepperIndex;

  ///巡检类型
  NewInspectionType inspectionType;

  ///任务的备注
  String noteText;

  ///当前选择的建筑
  Build currentBuild;

  ///所有建筑的列表,需要从store中拿去,在初始化时还需加载楼层列表
  List<Build> allBuilding;

  ///当前选择的楼层
  List<FloorEntity> currentFloor;

  ///选择的检查系统
  List<InspectionSystem> selectedSystem;

  ///所有的检查系统,从store中拿取
  List<InspectionSystem> allInspectionSystem;

  ///选择的执行人
  List<PersonnelMessage> selectedPeople;

  ///所有的部门和人员，从store中拿取
  List<PersonnelMessage> allPeople;

  ///任务独有

  ///开始时间
  String startTime;

  ///结束时间
  String endTime;

  ///计划独有

  ///第一次任务发起的时间,针对计划
  String firstStartTime;

  ///针对计划，每次任务的执行持续时间，即每次需要多长时间完成,暂定单位为天
  int sustainedTime;

  ///当前选择的巡检周期
  TaskCycleModel taskCycleModel;

  ///所有的巡检周期,需要从store中拿去
  List<TaskCycleModel> allTaskCycle;

  ///如果是计划的话，可以选择是否立即开始执行
  bool isEnable;

  ///选择建筑的错误提示
  String buildingErrorMag;

  ///楼层选择的错误提示
  String floorErrorMsg;

  ///检察系统的错误提示
  String checkSystemErrorMsg;

  ///第一次任务开始时间错误提示
  String firstStartTimeErrorMsg;

  ///开始时间错误提示
  String startTimeErrorMsg;

  ///结束时间错误提示
  String endTimeErrorMsg;

  ///执行人员错误提示
  String peopleErrorMsg;

  Map<int, Function> index2validate;

  AddTaskBlocModel(
      {this.allBuilding,
      this.allInspectionSystem,
      this.allPeople,
      this.allTaskCycle})
      : inspectionType = NewInspectionType.plan,
        stepperIndex = 0,
        currentFloor = [],
        selectedSystem = [],
        selectedPeople = [],
        isEnable = true,
        noteText = "",
        taskCycleModel = allTaskCycle[0] {
    bool step1Validate() {
      if (currentBuild != null) {
        buildingErrorMag = null;
        notifyListeners();
        return true;
      } else {
        buildingErrorMag = "请选择建筑";
        notifyListeners();
        return false;
      }
    }

    ///阶段2的检查函数
    bool step2Validate() {
      if (currentFloor.isNotEmpty &&
          selectedSystem
              .map((item) => item.inspectionItem.length)
              .any((item) => item > 0)) {
        floorErrorMsg = null;
        checkSystemErrorMsg = null;
        notifyListeners();
        return true;
      } else {
        if (currentFloor.isEmpty) {
          floorErrorMsg = "请选择楼层";
        }
        if (!selectedSystem
            .map((item) => item.inspectionItem.length)
            .any((item) => item > 0)) {
          checkSystemErrorMsg = "请选择检查系统";
        }
        notifyListeners();
        return false;
      }
    }

    bool step3Validate() {
      if (inspectionType == NewInspectionType.plan) {
        if (firstStartTime == null) {
          firstStartTimeErrorMsg = "请选择第一次任务开始时间";
        } else {
          firstStartTimeErrorMsg = null;
        }
        notifyListeners();
        return firstStartTime != null;
      } else {
        if (startTime != null && endTime != null) {
          startTimeErrorMsg = null;
          endTimeErrorMsg = null;
        } else {
          if (startTime == null) {
            startTimeErrorMsg = "请选择开始时间";
          }
          if (endTime == null) {
            endTimeErrorMsg = "请选择结束时间";
          }
        }
        notifyListeners();
        return startTime != null && endTime != null;
      }
    }

    bool step4Validate() {
      if (selectedPeople.isNotEmpty) {
        peopleErrorMsg = null;
      } else {
        peopleErrorMsg = "请选择任务执行人员";
      }
      notifyListeners();
      return selectedPeople.isNotEmpty;
    }

    index2validate = {
      0: step1Validate,
      1: step2Validate,
      2: step3Validate,
      3: step4Validate,
    };
  }

  //更改发布任务的类型
  void changeInspectionType(type) {
    inspectionType = parseEnumType(type);
    notifyListeners();
  }

  ///改变当前选中的建筑,同时也需将选择的楼层清空
  void changeCurrentBuilding(Build build) {
    currentBuild = build;
    currentFloor.clear();
    notifyListeners();
  }

  ///点击stepper中的取消按钮
  void cancelStepperCall() {
    if (stepperIndex > 0) {
      stepperIndex -= 1;
    } else {
      stepperIndex = 0;
    }
    notifyListeners();
  }

  //下一步按钮回调
  void nextStepperCall() {
    if (stepperIndex < 3) {
      stepperIndex = stepperIndex + 1;
    } else {
      stepperIndex = 0;
    }
    notifyListeners();
  }

  //直接点击stepper回调
  void stepperCall(int index) {
    stepperIndex = index;
    notifyListeners();
  }

  ///改变当前选中的楼层
  void changeCurrentFloor(bool value, int index) {
    if (value) {
      currentFloor.add(currentBuild.floors[index]);
    } else {
      currentFloor.remove(currentBuild.floors[index]);
    }
    notifyListeners();
  }

  ///楼层的全选按钮
  void changAllFloor(bool value) {
    if (value) {
      currentFloor = List.from(currentBuild.floors);
    } else {
      currentFloor.clear();
    }
    notifyListeners();
  }

  ///当点击选择系统按钮时调用
  ///按照所有的系统的布局进行初始化
  void initSelectSystem() {
    selectedSystem = allInspectionSystem
        .map((item) => InspectionSystem.copyNullItemList(item))
        .toList();
  }

  ///更改选择系统的选择框回掉
  void changeSelectSystem(bool value, int index) {
    if (value) {
      selectedSystem[index].inspectionItem =
          List.from(allInspectionSystem[index].inspectionItem);
    } else {
      selectedSystem[index].inspectionItem.clear();
    }
    notifyListeners();
  }

  ///改变当个检查项目的选择状态
  void changeSelectCheckItem(bool value, int sysIndex, InspectionItem item) {
    if (value) {
      selectedSystem[sysIndex].inspectionItem.add(item);
    } else {
      selectedSystem[sysIndex].inspectionItem.remove(item);
    }
    notifyListeners();
  }

  ///选择所有的检查系统
  void selectAllSystem(bool value) {
    if (value) {
      selectedSystem = allInspectionSystem
          .map((item) => InspectionSystem.copyFull(item))
          .toList();
    } else {
      initSelectSystem();
    }
    notifyListeners();
  }

  ///更改当前任务周期
  void changeTaskCycle(value) {
    taskCycleModel = value;
    notifyListeners();
  }

  ///设置开始时间
  void setFirstStartTime(String time) {
    firstStartTime = time;
    notifyListeners();
  }

  ///设置任务执行时间
  void setSustainedTime(int value) {
    sustainedTime = value;
  }

  ///设置开始时间
  void setStartTime(String time) {
    startTime = time;
    notifyListeners();
  }

  ///设置结束时间
  void setEndTime(String time) {
    endTime = time;
    notifyListeners();
  }

  ///选人页面全选的回调
  void selectAllPeople(bool value) {
    if (value) {
      selectedPeople = List.from(allPeople);
    } else {
      selectedPeople.clear();
    }
    notifyListeners();
  }

  ///改变当前的选中的人
  void changeSelectPeople(bool value, int index) {
    if (value) {
      selectedPeople.add(allPeople[index]);
    } else {
      selectedPeople.remove(allPeople[index]);
    }
    notifyListeners();
  }

  ///改变是否立即启用的回调
  void changeEnable(bool value) {
    isEnable = value;
    notifyListeners();
  }

  ///改变任务备注的回调
  void changeNoteText(String text) {
    noteText = text;
  }
}
