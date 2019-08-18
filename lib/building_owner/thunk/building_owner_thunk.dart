///@author lc
///@description: 业主首页的异步thunkaction文件
///@date :2019/8/17 14:45
///
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/main_app/actions/main_app_actions.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/building_owner/action/building_owner_actions.dart';

part 'building_owner_home_thunk.dart';