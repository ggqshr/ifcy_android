import 'dart:core';

import 'package:ifcy/common/utils/utils.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart' show thunkMiddleware;

Store<T> createStoreWithmiddleware<T>(Function reducer,T initstate, List<Middleware<T>> middleware) {
  if (middleware == null) {
    middleware = [thunkMiddleware,ErrorMiddleware()];
  }

  return Store<T>(reducer, initialState: initstate, middleware: middleware);
}
