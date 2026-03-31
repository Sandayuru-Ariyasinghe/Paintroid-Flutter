import 'package:flutter/material.dart';
import 'package:paintroid/ui/theme/data/paintroid_theme.dart';

class AdvancedOptionsDialog extends StatefulWidget {
  const AdvancedOptionsDialog({super.key});

  @override
  State<AdvancedOptionsDialog> createState() => _AdvancedOptionsDialogState();
}

class _AdvancedOptionsDialogState extends State<AdvancedOptionsDialog> {
  // Requirement: Disabled by default
  bool _antialiasing = false;
  bool _smoothing = false;

  @override
  Widget build(BuildContext context) {
    // Access the custom Paintroid theme
    final theme = PaintroidTheme.of(context);
    final primaryColor = theme.primaryColor; // This pulls the teal/blue from the app's config

    return AlertDialog(
      title: Text(
        'Advanced Options',
        style: TextStyle(
          color: primaryColor, 
          fontWeight: FontWeight.normal,
        ),
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
          onPressed: () => Navigator.pop(context),
          child: Text('OK', style: TextStyle(color: primaryColor)),
        ),
      ],
    );
  }
}