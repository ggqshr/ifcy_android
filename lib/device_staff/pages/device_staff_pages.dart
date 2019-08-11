import 'dart:convert';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/device_staff/component/device_staff_components.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

part 'device_work_page.dart';
part 'regular_inspection_page.dart';