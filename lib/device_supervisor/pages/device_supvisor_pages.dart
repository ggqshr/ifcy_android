library device_supvisor_pages;
import 'dart:io';

import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/common/components/components.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/device_staff/repositories/repositories.dart';
import 'package:ifcy/device_supervisor/blocs/supervisor_blocs.dart';
import 'package:ifcy/device_supervisor/blocs/task_list_bloc/bloc.dart';
import 'package:ifcy/device_supervisor/component/device_supervisor_component.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';
import 'package:ifcy/main_app/blocs/main_app_blocs.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

part 'add_task_page.dart';
part "change_plan_page.dart";
part "checked_alarm_page.dart";
part "confirm_message_page.dart";
part 'falut_declare_page.dart';
part 'fault_page.dart';
part "floor_deivice_page.dart";
part 'monitor_page.dart';
part "plan_list_page.dart";
part "report_device_page.dart";
part 'supervisor_list_page.dart';
part 'task_list_page.dart';
part 'task_page.dart';
part 'work_pages.dart';

