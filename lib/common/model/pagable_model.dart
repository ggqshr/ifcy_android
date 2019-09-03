///@author ggq
///@description:
///@date :2019/9/2 19:21
part of "model.dart";

@JsonSerializable(explicitToJson:true)
class PageDataModel {
  @JsonKey(name: "content")
  List dataList;
  @JsonKey(name: "total_pages")
  int totalPage;
  @JsonKey(name: "number")
  int currentPage;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  PageDataModel({
    @required this.dataList,
    @required this.totalPage,
    @required this.currentPage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PageDataModel &&
          runtimeType == other.runtimeType &&
          dataList == other.dataList &&
          totalPage == other.totalPage &&
          currentPage == other.currentPage);

  @override
  int get hashCode =>
      dataList.hashCode ^ totalPage.hashCode ^ currentPage.hashCode;

  @override
  String toString() {
    return 'PageDataModel{' +
        ' dataList: $dataList,' +
        ' totalPage: $totalPage,' +
        ' currentPage: $currentPage,' +
        '}';
  }

  PageDataModel copyWith({
    List dataList,
    int totalPage,
    int currentPage,
  }) {
    return PageDataModel(
      dataList: dataList ?? this.dataList,
      totalPage: totalPage ?? this.totalPage,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  PageDataModel nextPage(PageDataModel pageModel) {
    return PageDataModel(
      dataList: this.dataList + pageModel.dataList,
      currentPage: pageModel.currentPage+1,
      totalPage: this.totalPage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dataList': this.dataList,
      'totalPage': this.totalPage,
      'currentPage': this.currentPage,
    };
  }

  factory PageDataModel.fromMap(Map<String, dynamic> map) {
    return PageDataModel(
      dataList: map['dataList'] as List,
      totalPage: map['totalPage'] as int,
      currentPage: map['currentPage'] as int,
    );
  }
  Map<String, dynamic> toJson() => _$PageDataModelToJson(this);

  factory PageDataModel.fromJson(Map<String, dynamic> map) =>
      _$PageDataModelFromJson(map);
//</editor-fold>
}
