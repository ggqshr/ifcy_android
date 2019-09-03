import 'package:badges/badges.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifcy/common/components/components.dart';
import 'package:ifcy/device_supervisor/actions/device_supervisor_actions.dart';
import 'package:ifcy/device_supervisor/blocs/supervisor_blocs.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/pages/device_supvisor_pages.dart';
import 'package:redux/redux.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:intl/intl.dart';

part 'task_rate_component.dart';

part 'fault_num_component.dart';


part 'fire_alarm_component.dart';

part "device_fault_component.dart";

part 'task_info_component.dart';

part 'task_list_component.dart';

part 'task_add_component.dart';

part 'date_picker_component.dart';

part 'online_device_fault_component.dart';

part 'offline_device_fault_component.dart';

part 'supervisor_list_component.dart';

part 'person_list_component.dart';

part 'radio_component.dart';

part 'task_excute_chart_compont.dart';

part "check_alarm_panel_component.dart";

