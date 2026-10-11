import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AppSettings _settings;
  final _apiKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    setState(() {
      _settings = settingsProvider.settings;
      _apiKeyController.text = _settings.whirlpoolApiKey;
    });
  }

  Future<void> _saveSettings() async {
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    final newSettings = _settings.copyWith(
      whirlpoolApiKey: _apiKeyController.text,
    );
    settingsProvider.updateSettings(newSettings);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings saved!'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSectionTitle('API Configuration'),
            _buildApiKeySetting(),
            const SizedBox(height: 24),
            _buildSectionTitle('Notifications'),
            _buildNotificationSettings(),
            const SizedBox(height: 24),
            _buildSectionTitle('Display Options'),
            _buildDisplaySettings(),
            const SizedBox(height: 24),
            _buildSectionTitle('Thread Behavior'),
            _buildThreadBehaviorSettings(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildApiKeySetting() {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        final settings = settingsProvider.settings;
        _apiKeyController.text = settings.whirlpoolApiKey;
        return Card(
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shadowColor: Colors.orange.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Whirlpool API Key',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter your Whirlpool API key to enable full functionality',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _apiKeyController,
                  decoration: InputDecoration(
                    labelText: 'API Key',
                    labelStyle: const TextStyle(color: Colors.orange),
                    hintText: 'Enter your API key',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    filled: true,
                    fillColor: const Color(0xFF2D2D2D),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.orange.withOpacity(0.5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.orange.withOpacity(0.5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  onChanged: (value) {
                    settingsProvider.updateApiKey(value);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationSettings() {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        final settings = settingsProvider.settings;
        return Card(
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shadowColor: Colors.orange.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text(
                    'Enable Notifications',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: settings.notificationsEnabled,
                  onChanged: (value) {
                    settingsProvider.updateNotifications(value);
                  },
                  secondary: const Icon(Icons.notifications, color: Colors.orange),
                  activeColor: Colors.orange,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade700,
                ),
                const Divider(color: Color(0xFF333333), height: 1),
                SwitchListTile(
                  title: const Text(
                    'Notify on New Whim',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Get notified when new whims are posted',
                    style: TextStyle(color: Colors.grey),
                  ),
                  value: settings.notifyNewWhim,
                  onChanged: (value) {
                    settingsProvider.updateNotifyNewWhim(value);
                  },
                  secondary: const Icon(Icons.whatshot, color: Colors.orange),
                  activeColor: Colors.orange,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade700,
                ),
                const Divider(color: Color(0xFF333333), height: 1),
                SwitchListTile(
                  title: const Text(
                    'Notify on Watched Threads',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Get notified when watched threads have new replies',
                    style: TextStyle(color: Colors.grey),
                  ),
                  value: settings.notifyWatchedThreads,
                  onChanged: (value) {
                    settingsProvider.updateNotifyWatchedThreads(value);
                  },
                  secondary: const Icon(Icons.star, color: Colors.orange),
                  activeColor: Colors.orange,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade700,
                ),
                const Divider(color: Color(0xFF333333), height: 1),
                ListTile(
                  title: const Text(
                    'Notification Check Interval',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: DropdownButton<String>(
                    value: settings.notificationInterval,
                    dropdownColor: const Color(0xFF2D2D2D),
                    style: const TextStyle(color: Colors.white),
                    underline: Container(),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        settingsProvider.updateNotificationInterval(newValue);
                      }
                    },
                    items: notificationIntervals.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          getIntervalDisplayName(value),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDisplaySettings() {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        final settings = settingsProvider.settings;
        return Card(
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shadowColor: Colors.orange.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text(
                    'Open Thread in Browser',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Open threads in external browser instead of in-app',
                    style: TextStyle(color: Colors.grey),
                  ),
                  value: settings.openThreadInBrowser,
                  onChanged: (value) {
                    settingsProvider.updateOpenThreadInBrowser(value);
                  },
                  secondary: const Icon(Icons.open_in_browser, color: Colors.orange),
                  activeColor: Colors.orange,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade700,
                ),
                const Divider(color: Color(0xFF333333), height: 1),
                SwitchListTile(
                  title: const Text(
                    'Load Public Thread at Bottom',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'New public posts appear at the bottom of the thread',
                    style: TextStyle(color: Colors.grey),
                  ),
                  value: settings.loadPublicThreadAtBottom,
                  onChanged: (value) {
                    settingsProvider.updateLoadPublicThreadAtBottom(value);
                  },
                  secondary: const Icon(Icons.vertical_align_bottom, color: Colors.orange),
                  activeColor: Colors.orange,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade700,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildThreadBehaviorSettings() {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        final settings = settingsProvider.settings;
        return Card(
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shadowColor: Colors.orange.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text(
                    'Auto Mark Watched Thread as Read',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Automatically mark watched threads as read when viewed',
                    style: TextStyle(color: Colors.grey),
                  ),
                  value: settings.autoMarkWatchedAsRead,
                  onChanged: (value) {
                    settingsProvider.updateAutoMarkWatchedAsRead(value);
                  },
                  secondary: const Icon(Icons.mark_email_read, color: Colors.orange),
                  activeColor: Colors.orange,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade700,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
