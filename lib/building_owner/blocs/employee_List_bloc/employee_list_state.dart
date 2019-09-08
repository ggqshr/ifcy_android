import 'package:equatable/equatable.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EmployeeListState extends Equatable {
  EmployeeListState([List props = const <dynamic>[]]) : super(props);
}

class LoadingEmployeeListState extends EmployeeListState {}

class LoadedEmployeeListState extends EmployeeListState {
  final List<PersonnelMessage> employeeList;

  LoadedEmployeeListState(this.employeeList) : super([employeeList]);
}

class LoadErrorEmployeeListState extends EmployeeListState {}
