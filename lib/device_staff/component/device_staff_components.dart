import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:ifcy/device_staff/pages/device_staff_pages.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/device_staff/thunk/device_staff_thunk.dart';

part 'regular_inspection_component.dart';
part 'fault_inspection_component.dart';
part 'scan_code_toinspection_component.dart';
part 'upload_component.dart';
part 'device_staff_app_bar_component.dart';