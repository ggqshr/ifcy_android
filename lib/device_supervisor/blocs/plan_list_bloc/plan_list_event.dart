import 'package:meta/meta.dart';

@immutable
abstract class PlanListEvent {}

class FetchPlan extends PlanListEvent {}

class RefreshPlan extends PlanListEvent {}
