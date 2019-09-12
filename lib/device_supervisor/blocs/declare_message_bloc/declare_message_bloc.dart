import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/repositories/report_device_repositories.dart';
import './bloc.dart';

class DeclareMessageBloc
    extends Bloc<DeclareMessageEvent, DeclareMessageState> {
  final ReportDeviceRepositories repositories;

  DeclareMessageBloc(this.repositories);

  @override
  DeclareMessageState get initialState => LoadingDeclareMessageState();

  @override
  Stream<DeclareMessageState> mapEventToState(
    DeclareMessageEvent event,
  ) async* {
    if (event is FetchDeclareMessage) {
      yield* _mapFetchToState();
    }
    if (event is RefreshDeclareMessage) {
      yield* _mapRefreshToState();
    }
  }

  Stream<DeclareMessageState> _mapRefreshToState() async* {
    try {
      final PageDataModel models = await repositories.getDeclareFirstPage();
      yield LoadedDeclareMessageState(isReachMax: false, models: models);
    } catch (e) {
      yield LoadErrorDeclareMessageState();
      rethrow;
    }
  }

  Stream<DeclareMessageState> _mapFetchToState() async* {
    try {
      if (currentState is LoadingDeclareMessageState ||
          currentState is LoadErrorDeclareMessageState) {
        final PageDataModel models = await repositories.getDeclareFirstPage();
        yield LoadedDeclareMessageState(isReachMax: false, models: models);
      } else {
        final PageDataModel thisModel =
            (currentState as LoadedDeclareMessageState).models;
        final PageDataModel newModel =
            await repositories.getDeclareNextPage(thisModel.currentPage + 1);
        yield newModel.dataList.isEmpty
            ? (currentState as LoadedDeclareMessageState).copy(isReachMax: true)
            : (currentState as LoadedDeclareMessageState)
                .copy(isReachMax: false, models: thisModel.nextPage(newModel));
      }
    } catch (e, s) {
      yield LoadErrorDeclareMessageState();
      rethrow;
    }
  }
}
