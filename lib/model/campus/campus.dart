class Campus {
  final int id;
  final String name;
  final String image;
  final String address;

  const Campus(this.id, this.name, this.image, this.address);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();
    tempMap["id"] = this.id;
    tempMap["name"] = this.name;
    tempMap["image"] = this.image;
    tempMap["address"] = this.address;
    return tempMap;
  }
}
