class Campus {
  final int id;
  final String name;
  final String imagePath;
  final String mapUrl;

  const Campus(this.id, this.name, this.imagePath, this.mapUrl);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();
    tempMap["id"] = this.id;
    tempMap["name"] = this.name;
    tempMap["imagePath"] = this.imagePath;
    tempMap["mapUrl"] = this.mapUrl;
    return tempMap;
  }
}
