import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BadgeEvent extends Equatable {
  BadgeEvent([List props = const <dynamic>[]]) : super(props);
}

///增加徽章数量
class AddBadgeNum extends BadgeEvent {
  ///要增加的徽章数量
  final int badgeNum;

  ///要增加哪一个页面的徽章数量
  final int badgeIndex;

  AddBadgeNum({this.badgeNum = 1, this.badgeIndex})
      : super([badgeNum, badgeIndex]);

  @override
  String toString() {
    return 'AddBadgeNum{badgeNum: $badgeNum, badgeIndex: $badgeIndex}';
  }
}

///减少徽章数量
class DecreaseBadgeNum extends BadgeEvent {
  ///要减少的徽章数量
  final int badgeNum;

  ///要减少哪一个页面的徽章数量
  final int badgeIndex;

  DecreaseBadgeNum({this.badgeNum = 1, this.badgeIndex})
      : super([badgeNum, badgeIndex]);

  @override
  String toString() {
    return 'DecreaseBadgeNum{badgeNum: $badgeNum, badgeIndex: $badgeIndex}';
  }
}
