import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

//import 'package:ifcy/device_supervisor/actions/device_supervisor_actions.dart';
//import 'package:ifcy/device_supervisor/component/device_supervisor_component.dart';
//import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';

import 'package:charts_flutter/flutter.dart' as chart;
import 'package:ifcy/common/components/components.dart';
import 'package:ifcy/common/model/processed_device_fault_message.dart';
import 'package:ifcy/common/model/processing_device_fault_message.dart';
import 'package:ifcy/common/components/components.dart';
import 'package:ifcy/common/model/model.dart';

import 'package:ifcy/building_owner/component/building_owner_component.dart';
import 'package:ifcy/building_owner/model/building_owner_model.dart';

part 'owner_page.dart';
part 'employee_page.dart';
part 'declare_page.dart';
part 'fire_warning_page.dart';
