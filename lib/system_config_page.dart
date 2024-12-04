import 'package:flutter/material.dart';

class SystemConfigPage extends StatefulWidget {
  @override
  _SystemConfigPageState createState() => _SystemConfigPageState();
}

class _SystemConfigPageState extends State<SystemConfigPage> {
  bool _darkModeEnabled = true;
  bool _notificationsEnabled = true;
  double _fontSize = 14.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('System Configuration'),
        backgroundColor: Color(0xFF121212),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF121212),
              Color(0xFF1E1E1E),
              Color(0xFF2C2C2C),
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildSettingSection(
              title: 'Appearance',
              children: [
                _buildToggleSetting(
                  title: 'Dark Mode',
                  value: _darkModeEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
                _buildSliderSetting(
                  title: 'Font Size',
                  value: _fontSize,
                  min: 12.0,
                  max: 20.0,
                  onChanged: (double value) {
                    setState(() {
                      _fontSize = value;
                    });
                  },
                ),
              ],
            ),
            _buildSettingSection(
              title: 'Notifications',
              children: [
                _buildToggleSetting(
                  title: 'Enable Notifications',
                  value: _notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: _saveSystemConfig,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF88E20),
                ),
                child: Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingSection({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      color: Color(0xFF2C2C2C),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSetting({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Color(0xFFF88E20),
        ),
      ],
    );
  }

  Widget _buildSliderSetting({
    required String title,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 4,
          label: value.round().toString(),
          activeColor: Color(0xFFF88E20),
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _saveSystemConfig() {
    // Implement save configuration logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('System configuration saved'),
        backgroundColor: Color(0xFFF88E20),
      ),
    );
  }
}