import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/module1/pages/CountPage.dart';
import 'package:ifcy/utils/StoreCreater.dart';
import 'package:redux/redux.dart';
import 'action/Moudle1Action.dart';
import 'model/Moudle1Model.dart';
import 'MoudleRedux.dart';
import 'pages/AsyncPage.dart';

class Moudle1Test extends StatefulWidget {
  @override
  _Moudle1TestState createState() => _Moudle1TestState();
}

class _Moudle1TestState extends State<Moudle1Test>
    with SingleTickerProviderStateMixin {
  Store<Moudle1Model> _store;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _store = createStoreWithmiddleware<Moudle1Model>(
        moudle1Reducer, Moudle1Model(0, true, "no data here"), null);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<Moudle1Model>(
      store: _store,
      child: Scaffold(
        appBar: AppBar(
          title: Text("MoudlePageOne"),
          actions: <Widget>[
            StoreConnector<Moudle1Model, Function>(
              converter: (Store<Moudle1Model> store) {
                return () {
                  store.dispatch(MinsCountAction());
                };
              },
              builder: (_, call) {
                return IconButton(
                  icon: Icon(Icons.minimize),
                  onPressed: () => call(),
                );
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TabBar(controller: _tabController, tabs: [
                Tab(
                  child: Text(
                    "普通操作",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    "异步操作",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ]),
              Expanded(
                child: TabBarView(
                  children: [CountPage(), AsyncPage()],
                  controller: _tabController,
                ),
              )
            ],
          ),
        ),
        floatingActionButton: StoreConnector(builder: (_, Function call) {
          return FloatingActionButton(
            onPressed: () => call(),
            child: Icon(Icons.add),
          );
        }, converter: (Store<Moudle1Model> store) {
          return () {
            store.dispatch(AddCountAction());
          };
        }),
      ),
    );
  }
}
