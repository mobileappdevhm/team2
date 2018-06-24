class Campus {
  final int id;
  final String name;
  final String image; //TODO: CHANGE THIS TO SOMETHING THAT IS AN IMAGE?
  final String address;

  //TODO: process latitude and longitude coordinates

  const Campus(this.id, this.name, this.image, this.address);

  factory Campus.fromJsonMap(Map<String, dynamic> map) => map != null
      ? Campus(map['id'] ?? -1, map['name'] ?? '', null, map['name'] ?? '')
      : Campus(-1, '', null, '');

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();
    tempMap["id"] = this.id;
    tempMap["name"] = this.name;
    tempMap["image"] = this.image;
    tempMap["address"] = this.address;
    return tempMap;
  }
}
