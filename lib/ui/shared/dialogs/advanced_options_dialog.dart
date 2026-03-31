import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paintroid/ui/theme/theme.dart';

class AdvancedOptionsDialog extends StatefulWidget {
  const AdvancedOptionsDialog({super.key});

  @override
  State<AdvancedOptionsDialog> createState() => _AdvancedOptionsDialogState();
}

class _AdvancedOptionsDialogState extends State<AdvancedOptionsDialog> {
  // Requirement: Both options must be disabled by default.
  bool _antialiasing = false;
  bool _smoothing = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Logic: If the key doesn't exist yet, it returns null, so we default to 'false'.
      _antialiasing = prefs.getBool('antialiasing') ?? false;
      _smoothing = prefs.getBool('smoothing') ?? false;
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('antialiasing', _antialiasing);
    await prefs.setBool('smoothing', _smoothing);
  }

  @override
  Widget build(BuildContext context) {
    // Show nothing or a loader until we know the previous state
    if (_isLoading) return const SizedBox.shrink();

    final theme = PaintroidTheme.of(context);
    final primaryColor = theme.primaryColor;

    return AlertDialog(
      title: Text(
        'Advanced Options',
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            title: const Text('Antialiasing'),
            value: _antialiasing,
            activeColor: primaryColor,
            onChanged: (val) => setState(() => _antialiasing = val),
          ),
          SwitchListTile(
            title: const Text('Smoothing'),
            value: _smoothing,
            activeColor: primaryColor,
            onChanged: (val) => setState(() => _smoothing = val),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('CANCEL', style: TextStyle(color: primaryColor)),
        ),
        TextButton(
          onPressed: () async {
            final navigator = Navigator.of(context); 
            
            await _saveSettings();
            
            // 2. The linter often prefers checking !mounted first 
            // or using the captured navigator.
            if (!mounted) return;
            navigator.pop();
          },
          child: Text('OK', style: TextStyle(color: primaryColor)),
        ),
      ],
    );
  }
}