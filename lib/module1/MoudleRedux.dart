import 'action/Moudle1Action.dart';
import 'model/Moudle1Model.dart';
import 'package:redux/redux.dart';

int addCount(int count, action) {
  return count += 1;
}

int minsCount(int count, action) {
  return count -= 1;
}

Reducer<int> countReducer = combineReducers([
  TypedReducer<int, AddCountAction>(addCount),
  TypedReducer<int, MinsCountAction>(minsCount),
]);

bool changeShowTextState(bool showText, action) {
  return !showText;
}

Reducer<bool> showTextReducer = combineReducers([
  TypedReducer<bool, ChangeShowTextStateAction>(changeShowTextState),
]);

String text2showFillData(String text2show, action) {
  return (action as GetDelayDataAction).payload;
}

Reducer<String> text2showReducer = combineReducers([
  TypedReducer<String, GetDelayDataAction>(text2showFillData),
]);

Moudle1Model moudle1Reducer(Moudle1Model state, action) => Moudle1Model(
      countReducer(state.count, action),
      showTextReducer(state.showText, action),
      text2showReducer(state.text2show, action),
    );
