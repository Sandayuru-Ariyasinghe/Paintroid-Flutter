import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paintroid/core/localization/app_localizations.dart';
import 'package:paintroid/ui/pages/workspace_page/workspace_page.dart';
import 'package:paintroid/ui/theme/data/dark_paintroid_theme_data.dart';
import 'package:paintroid/ui/theme/data/light_paintroid_theme_data.dart';
import 'package:paintroid/ui/theme/data/paintroid_theme.dart';

void main() {
  testWidgets('Workspace overlay Advanced Options flow', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: PaintroidTheme(
            lightTheme: LightPaintroidThemeData(),
            darkTheme: DarkPaintroidThemeData(),
            child: const WorkspacePage(),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // open overflow menu
    final overflowMenu = find.byIcon(Icons.more_vert);
    expect(overflowMenu, findsOneWidget);
    await tester.tap(overflowMenu, warnIfMissed: false);
    await tester.pumpAndSettle();

    // tap advanced options menu item
    final advancedOptionsItem = find.text('Advanced Options');
    expect(advancedOptionsItem, findsOneWidget);
    await tester.tap(advancedOptionsItem);
    await tester.pumpAndSettle();

    // dialog appears
    final dialog = find.byType(AlertDialog);
    expect(dialog, findsOneWidget);

    // Contains both expected toggle labels
    final toggleLabel1 = find.text('Enable Fast Preview');
    final toggleLabel2 = find.text('Enable High Precision');
    expect(toggleLabel1, findsOneWidget);
    expect(toggleLabel2, findsOneWidget);

    // defaults OFF
    final switch1 = find.descendant(
      of: toggleLabel1,
      matching: find.byType(Switch),
    );
    final switch2 = find.descendant(
      of: toggleLabel2,
      matching: find.byType(Switch),
    );
    expect(switch1, findsOneWidget);
    expect(switch2, findsOneWidget);
    expect((tester.widget<Switch>(switch1)).value, isFalse);
    expect((tester.widget<Switch>(switch2)).value, isFalse);

    // toggle one switch
    await tester.tap(switch1);
    await tester.pumpAndSettle();
    expect((tester.widget<Switch>(switch1)).value, isTrue);

    // confirm with OK
    final okButton = find.widgetWithText(TextButton, 'OK');
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    expect(dialog, findsNothing);
  });
}
