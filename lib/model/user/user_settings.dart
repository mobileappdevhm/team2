class UserSettings {
  bool offlineMode;
  bool feedbackMode;

  UserSettings({
    bool offlineMode = true,
    bool feedbackMode = true,
  })  : offlineMode = offlineMode,
        feedbackMode = feedbackMode;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();
    tempMap["offlineMode"] = this.offlineMode.toString();
    tempMap["feedbackMode"] = this.feedbackMode.toString();
    return tempMap;
  }
}
