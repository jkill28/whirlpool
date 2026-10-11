import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings.dart';

class SettingsService {
  static const String _settingsKey = 'app_settings';
  
  final SharedPreferences _prefs;

  SettingsService(this._prefs);

  Future<AppSettings> getSettings() async {
    final json = _prefs.getString(_settingsKey);
    if (json != null) {
      return AppSettings.fromJson({
        'whirlpoolApiKey': _prefs.getString('whirlpoolApiKey') ?? '',
        'notificationsEnabled': _prefs.getBool('notificationsEnabled') ?? true,
        'notifyNewWhim': _prefs.getBool('notifyNewWhim') ?? true,
        'notifyWatchedThreads': _prefs.getBool('notifyWatchedThreads') ?? true,
        'notificationInterval': _prefs.getString('notificationInterval') ?? '15min',
        'openThreadInBrowser': _prefs.getBool('openThreadInBrowser') ?? false,
        'loadPublicThreadAtBottom': _prefs.getBool('loadPublicThreadAtBottom') ?? true,
        'autoMarkWatchedAsRead': _prefs.getBool('autoMarkWatchedAsRead') ?? true,
      });
    }
    return AppSettings();
  }

  Future<void> saveSettings(AppSettings settings) async {
    await _prefs.setString('whirlpoolApiKey', settings.whirlpoolApiKey);
    await _prefs.setBool('notificationsEnabled', settings.notificationsEnabled);
    await _prefs.setBool('notifyNewWhim', settings.notifyNewWhim);
    await _prefs.setBool('notifyWatchedThreads', settings.notifyWatchedThreads);
    await _prefs.setString('notificationInterval', settings.notificationInterval);
    await _prefs.setBool('openThreadInBrowser', settings.openThreadInBrowser);
    await _prefs.setBool('loadPublicThreadAtBottom', settings.loadPublicThreadAtBottom);
    await _prefs.setBool('autoMarkWatchedAsRead', settings.autoMarkWatchedAsRead);
  }

  Future<void> saveApiKey(String apiKey) async {
    await _prefs.setString('whirlpoolApiKey', apiKey);
  }

  Future<String> getApiKey() async {
    return _prefs.getString('whirlpoolApiKey') ?? '';
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
