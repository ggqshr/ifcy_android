import 'package:badges/badges.dart';
import 'package:bloc/bloc.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'dart:ui';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/device_supervisor/blocs/supervisor_blocs.dart';
import 'package:ifcy/device_supervisor/pages/device_supvisor_pages.dart';
import 'package:ifcy/device_supervisor/repositories/repositories.dart';
import 'package:ifcy/main_app/blocs/main_app_blocs.dart';
import 'package:rxdart/subjects.dart';

part 'search_input_componet.dart';
part 'expansion_card.dart';
part 'person_info_component.dart';
//part 'package:ifcy/device_supervisor/component/person_list_component.dart';
part "person_page.dart";
part "LoadErrorPage.dart";
part "LoadingPage.dart";

