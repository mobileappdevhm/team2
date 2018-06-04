class Campus {
  final int id;
  final String name;
  final String imagePath;

  const Campus(this.id, this.name, this.imagePath);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();
    tempMap["id"] = this.id;
    tempMap["name"] = this.name;
    tempMap["imagePath"] = this.imagePath;
    return tempMap;
  }
}
