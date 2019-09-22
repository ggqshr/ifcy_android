import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifcy/common/components/components.dart';
import 'package:ifcy/common/dao/dao.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/device_staff/blocs/device_staff_blocs.dart';
import 'package:ifcy/device_staff/blocs/device_staff_device_check_bloc/bloc.dart';
import 'package:ifcy/device_staff/blocs/device_upload_bloc/device_upload_bloc.dart';
import 'package:ifcy/device_staff/component/device_staff_components.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_bloc.dart';
import 'package:ifcy/main_app/blocs/main_app_blocs.dart';
import 'package:ifcy/main_app/repositories/user_login_repositories.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path/path.dart' as p;

import '../repositories/repositories.dart';

part 'device_work_page.dart';
part 'regular_inspection_page.dart';
part "floor_map_pages.dart";