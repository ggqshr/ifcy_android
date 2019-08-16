
class BuildingFloorMessage{
  String id;
  String buildName;
  List<FloorMessage> floorList;

  BuildingFloorMessage({this.id,
    this.buildName,
    this.floorList,
  });

  BuildingFloorMessage.generate(id):
        id="$id",
      buildName="大厦$id",
      floorList=List.generate(10,(index){
        return FloorMessage.generate(index.toString());
      });

  @override
  String toString() {
    return 'BuildingFloorMessage{id: $id, buildName: $buildName, floorList: $floorList}';
  }
}

class FloorMessage {
  String id;
  String floorName;

  FloorMessage({
    this.id,
    this.floorName,
  });

  FloorMessage.generate(id):
        id="$id",
        floorName="楼层$id";

  @override
  String toString() {
    return 'FloorMessage{id: $id, floorName: $floorName}';
  }

}