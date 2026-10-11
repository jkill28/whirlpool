import 'package:flutter/material.dart';

class AppSettings {
  String whirlpoolApiKey;
  bool notificationsEnabled;
  bool notifyNewWhim;
  bool notifyWatchedThreads;
  String notificationInterval;
  bool openThreadInBrowser;
  bool loadPublicThreadAtBottom;
  bool autoMarkWatchedAsRead;

  AppSettings({
    this.whirlpoolApiKey = '',
    this.notificationsEnabled = true,
    this.notifyNewWhim = true,
    this.notifyWatchedThreads = true,
    this.notificationInterval = '15min',
    this.openThreadInBrowser = false,
    this.loadPublicThreadAtBottom = true,
    this.autoMarkWatchedAsRead = true,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      whirlpoolApiKey: json['whirlpoolApiKey'] ?? '',
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      notifyNewWhim: json['notifyNewWhim'] ?? true,
      notifyWatchedThreads: json['notifyWatchedThreads'] ?? true,
      notificationInterval: json['notificationInterval'] ?? '15min',
      openThreadInBrowser: json['openThreadInBrowser'] ?? false,
      loadPublicThreadAtBottom: json['loadPublicThreadAtBottom'] ?? true,
      autoMarkWatchedAsRead: json['autoMarkWatchedAsRead'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
    'whirlpoolApiKey': whirlpoolApiKey,
    'notificationsEnabled': notificationsEnabled,
    'notifyNewWhim': notifyNewWhim,
    'notifyWatchedThreads': notifyWatchedThreads,
    'notificationInterval': notificationInterval,
    'openThreadInBrowser': openThreadInBrowser,
    'loadPublicThreadAtBottom': loadPublicThreadAtBottom,
    'autoMarkWatchedAsRead': autoMarkWatchedAsRead,
  };

  AppSettings copyWith({
    String? whirlpoolApiKey,
    bool? notificationsEnabled,
    bool? notifyNewWhim,
    bool? notifyWatchedThreads,
    String? notificationInterval,
    bool? openThreadInBrowser,
    bool? loadPublicThreadAtBottom,
    bool? autoMarkWatchedAsRead,
  }) {
    return AppSettings(
      whirlpoolApiKey: whirlpoolApiKey ?? this.whirlpoolApiKey,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      notifyNewWhim: notifyNewWhim ?? this.notifyNewWhim,
      notifyWatchedThreads: notifyWatchedThreads ?? this.notifyWatchedThreads,
      notificationInterval: notificationInterval ?? this.notificationInterval,
      openThreadInBrowser: openThreadInBrowser ?? this.openThreadInBrowser,
      loadPublicThreadAtBottom: loadPublicThreadAtBottom ?? this.loadPublicThreadAtBottom,
      autoMarkWatchedAsRead: autoMarkWatchedAsRead ?? this.autoMarkWatchedAsRead,
    );
  }
}

class SettingsProvider extends ChangeNotifier {
  AppSettings _settings = AppSettings();

  AppSettings get settings => _settings;

  void updateSettings(AppSettings newSettings) {
    _settings = newSettings;
    notifyListeners();
  }

  void updateApiKey(String apiKey) {
    _settings = _settings.copyWith(whirlpoolApiKey: apiKey);
    notifyListeners();
  }

  void updateNotifications(bool enabled) {
    _settings = _settings.copyWith(notificationsEnabled: enabled);
    notifyListeners();
  }

  void updateNotifyNewWhim(bool enabled) {
    _settings = _settings.copyWith(notifyNewWhim: enabled);
    notifyListeners();
  }

  void updateNotifyWatchedThreads(bool enabled) {
    _settings = _settings.copyWith(notifyWatchedThreads: enabled);
    notifyListeners();
  }

  void updateNotificationInterval(String interval) {
    _settings = _settings.copyWith(notificationInterval: interval);
    notifyListeners();
  }

  void updateOpenThreadInBrowser(bool enabled) {
    _settings = _settings.copyWith(openThreadInBrowser: enabled);
    notifyListeners();
  }

  void updateLoadPublicThreadAtBottom(bool enabled) {
    _settings = _settings.copyWith(loadPublicThreadAtBottom: enabled);
    notifyListeners();
  }

  void updateAutoMarkWatchedAsRead(bool enabled) {
    _settings = _settings.copyWith(autoMarkWatchedAsRead: enabled);
    notifyListeners();
  }
}

final List<String> notificationIntervals = [
  '15min',
  '30min',
  '1h',
  '4h',
  '12h',
  '24h',
];

String getIntervalDisplayName(String interval) {
  switch (interval) {
    case '15min':
      return '15 minutes';
    case '30min':
      return '30 minutes';
    case '1h':
      return '1 hour';
    case '4h':
      return '4 hours';
    case '12h':
      return '12 hours';
    case '24h':
      return '24 hours';
    default:
      return interval;
  }
}

int getIntervalMinutes(String interval) {
  switch (interval) {
    case '15min':
      return 15;
    case '30min':
      return 30;
    case '1h':
      return 60;
    case '4h':
      return 240;
    case '12h':
      return 720;
    case '24h':
      return 1440;
    default:
      return 15;
  }
}
