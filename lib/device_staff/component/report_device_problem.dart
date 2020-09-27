import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_staff/blocs/report_upload_bloc/bloc.dart';
import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:ifcy/device_staff/pages/device_staff_pages.dart';

class ReportDeviceProblem extends StatelessWidget {
  final List<FloorEntity> floorList;

  ReportDeviceProblem(this.floorList);

  @override
  Widget build(BuildContext context) {
    ReportUploadBloc _bloc = BlocProvider.of<ReportUploadBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("问题申报"),
      ),
      body: BlocListener<ReportUploadBloc, ReportUploadState>(
        listener: (context, state) async {
          if (state is ReportDeviceProblemState) {
            if (state.isUploading) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('申报中...'),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
            }
            if (state.isFault) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('申报失败'), Icon(Icons.error)],
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
            }
            if (state.isSuccess) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('申报成功'),
                        Icon(Icons.check),
                      ],
                    ),
                  ),
                );
              Future.delayed(
                  Duration(seconds: 1), () => Navigator.of(context).pop());
            }
          }
        },
        child: BlocBuilder<ReportUploadBloc, ReportUploadState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is InitialReportUploadState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ReportDeviceProblemState) {
              if (state.models.isEmpty) {
                return Center(
                  child: Text("无设备"),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    var thisDevice = state.models[index];
                    return Card(
                      child: ExpansionTile(
                        leading: Checkbox(
                          value: state.devicesToReport.contains(thisDevice.code),
                          onChanged: (value) {
                            if (value) {
                              _bloc.add(AddToReport(thisDevice.code));
                            } else {
                              _bloc.add(
                                  RemoveFromReport(thisDevice.code));
                            }
                          },
                        ),
                        title: Text(thisDevice.name),
                        subtitle: Text(
                            int.parse(thisDevice.buildingFloorId)-4 > 0 ?
                            (int.parse(thisDevice.buildingFloorId)-4).toString()+"层"
                                :
                            "负"+(5-int.parse(thisDevice.buildingFloorId)).toString()+"层"
                        ),
                          children: <Widget>[
                            ListTile(
                              title: Text("设备编号"),
                              subtitle: Text(thisDevice.code),
                            ),
                            ]
                      ),
                    );
                  },
                  itemCount: state.models.length,
                );
              }
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: BlocBuilder<ReportUploadBloc, ReportUploadState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is InitialReportUploadState) {
              return CircularProgressIndicator();
            }
            if (state is ReportDeviceProblemState) {
              return FlatButton(
                onPressed: state.devicesToReport.isEmpty
                    ? null
                    : () async {
                  _bloc.add(ReportToServer());
                },
                child: Text(
                  "申报",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
              );
            }
          },
        ),
      ),
    );
  }
}
