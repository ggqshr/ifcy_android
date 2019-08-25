import 'package:meta/meta.dart';

@immutable
abstract class PlanListEvent {}

class Fetch extends PlanListEvent {}
