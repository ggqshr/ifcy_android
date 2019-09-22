part of "components.dart";

ClassicalFooter getFooter() {
  return ClassicalFooter(
    loadText: "释放加载更多",
    loadReadyText: "释放加载更多",
    loadingText: "正在加载",
    loadedText: "加载成功",
    loadFailedText: "加载失败",
    noMoreText: "没有更多数据",
    infoText: "更新于 %T",
  );
}

ClassicalHeader getHeader() {
  return ClassicalHeader(
    refreshText: "下拉刷新",
    refreshReadyText: "释放刷新",
    refreshingText: "正在刷新",
    refreshedText: "刷新成功",
    refreshFailedText: "刷新失败",
    noMoreText: "没有更多数据",
    infoText: "更新于 %T",
  );
}
