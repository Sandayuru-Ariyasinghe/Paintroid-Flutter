import 'package:flutter/material.dart';

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
    return AlertDialog(
      title: const Text('Advanced Options'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            title: const Text('Antialiasing'),
            value: _antialiasing,
            onChanged: (bool value) => setState(() => _antialiasing = value),
          ),
          SwitchListTile(
            title: const Text('Smoothing'),
            value: _smoothing,
            onChanged: (bool value) => setState(() => _smoothing = value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            // Persistence logic will go here in the next step
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}