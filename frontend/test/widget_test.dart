import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:renbok/features/create/screens/create_screen.dart';
import 'package:renbok/features/main/widgets/premium_bottom_nav.dart';

void main() {
  testWidgets('mobile bottom navigation fits 390x844', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: PremiumBottomNav(
            currentIndex: 0,
            onTap: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Create'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('create screen renders at 390x844', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(
        home: CreateScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Create\nAdventure'), findsOneWidget);
    expect(find.text('Upload Petualangan'), findsOneWidget);
    expect(find.text('Level 7 Explorer'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
