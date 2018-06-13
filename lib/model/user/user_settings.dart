class UserSettings {
  bool offlineMode;
  bool feedbackMode;
  int userId;

  UserSettings(
    this.userId, {
    bool offlineMode = true,
    bool feedbackMode = false,
  })  : offlineMode = offlineMode,
        feedbackMode = feedbackMode;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();
    tempMap["offlineMode"] = this.offlineMode.toString();
    tempMap["feedbackMode"] = this.feedbackMode.toString();
    tempMap["userId"] = userId;
    return tempMap;
  }
}
