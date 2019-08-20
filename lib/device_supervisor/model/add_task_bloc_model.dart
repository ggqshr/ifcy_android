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
  List<DepartmentMessage> selectedPeople;

  ///所有的部门和人员，从store中拿取
  List<DepartmentMessage> allPeople;

  ///任务独有

  ///开始时间
  String startTime;

  ///结束时间
  String endTime;

  ///计划独有

  ///第一次任务发起的时间,针对计划
  String firstStartTime;

  ///针对计划，每次任务的执行持续时间，即每次需要多长时间完成
  String sustainedTime;

  ///当前选择的巡检周期
  TaskCycleModel taskCycleModel;

  ///所有的巡检周期,需要从store中拿去
  List<TaskCycleModel> allTaskCycle;

  ///如果是计划的话，可以选择是否立即开始执行
  bool isEnable;

  AddTaskBlocModel(
      {this.allBuilding,
      this.allInspectionSystem,
      this.allPeople,
      this.allTaskCycle})
      : inspectionType = NewInspectionType.plan,
        stepperIndex = 0,
        currentFloor = [],
        selectedSystem = [];

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
    if (stepperIndex < 1) {
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
}
