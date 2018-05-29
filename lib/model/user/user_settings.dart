class UserSettings {
  bool autoSync;
  bool offlineMode;
  bool usesDrawer;
  String language;
  bool secret1;

  UserSettings({
    String language = "en",
    bool sync = false,
    bool offlineMode = false,
    bool usesDrawer = false,
    bool secret1 = false,
  }) : autoSync = sync,
       offlineMode = offlineMode,
       usesDrawer = usesDrawer,
       secret1 = secret1,
       language = language;
}