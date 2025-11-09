import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_bagage_app/widgets/bottom_nav_spacer.dart';

void main() {
  group('BottomNavSpacer Widget Tests', () {
    testWidgets('should render a SizedBox', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BottomNavSpacer(),
          ),
        ),
      );

      // Vérifier qu'un SizedBox est présent
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('should have height of 150', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BottomNavSpacer(),
          ),
        ),
      );

      // Vérifier que la hauteur est de 150
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, 150);
    });

    testWidgets('should not have a width constraint', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BottomNavSpacer(),
          ),
        ),
      );

      // Vérifier qu'il n'y a pas de contrainte de largeur
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.width, isNull);
    });

    testWidgets('should be const constructor', (WidgetTester tester) async {
      // Créer deux instances
      const spacer1 = BottomNavSpacer();
      const spacer2 = BottomNavSpacer();

      // Vérifier qu'elles sont identiques (même instance grâce à const)
      expect(identical(spacer1, spacer2), true);
    });

    testWidgets('should work in a Column', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                const Text('Content'),
                const BottomNavSpacer(),
              ],
            ),
          ),
        ),
      );

      // Vérifier que le widget fonctionne correctement dans une Column
      expect(find.text('Content'), findsOneWidget);
      expect(find.byType(BottomNavSpacer), findsOneWidget);
    });

    testWidgets('should work in a ListView', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                const Text('Item 1'),
                const Text('Item 2'),
                const BottomNavSpacer(),
              ],
            ),
          ),
        ),
      );

      // Vérifier que le widget fonctionne correctement dans une ListView
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.byType(BottomNavSpacer), findsOneWidget);
    });

    testWidgets('should provide correct spacing at bottom of scrollable content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(height: 100, color: Colors.red),
                  Container(height: 100, color: Colors.blue),
                  Container(height: 100, color: Colors.green),
                  const BottomNavSpacer(),
                ],
              ),
            ),
          ),
        ),
      );

      // Faire défiler jusqu'en bas
      await tester.dragUntilVisible(
        find.byType(BottomNavSpacer),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );

      // Vérifier que le spacer est visible
      expect(find.byType(BottomNavSpacer), findsOneWidget);
    });

    testWidgets('should not interfere with scrolling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              itemCount: 11, // 10 items + 1 spacer
              itemBuilder: (context, index) {
                if (index == 10) {
                  return const BottomNavSpacer();
                }
                return ListTile(title: Text('Item $index'));
              },
            ),
          ),
        ),
      );

      // Vérifier que les premiers items sont visibles
      expect(find.text('Item 0'), findsOneWidget);

      // Faire défiler vers le bas
      await tester.drag(find.byType(ListView), const Offset(0, -1000));
      await tester.pumpAndSettle();

      // Vérifier que le spacer est maintenant visible
      expect(find.byType(BottomNavSpacer), findsOneWidget);
    });

    testWidgets('should have correct size when rendered', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BottomNavSpacer(),
          ),
        ),
      );

      // Obtenir la taille du widget
      final size = tester.getSize(find.byType(BottomNavSpacer));

      // Vérifier que la hauteur est de 150
      expect(size.height, 150);

      // Vérifier que la largeur occupe tout l'espace disponible
      expect(size.width, greaterThan(0));
    });

    testWidgets('should be a StatelessWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BottomNavSpacer(),
          ),
        ),
      );

      // Vérifier que c'est un StatelessWidget
      expect(find.byType(BottomNavSpacer), findsOneWidget);
      final widget = tester.widget<BottomNavSpacer>(find.byType(BottomNavSpacer));
      expect(widget, isA<StatelessWidget>());
    });

    testWidgets('should maintain consistent spacing across different screen sizes', (WidgetTester tester) async {
      // Test avec une petite taille d'écran
      await tester.binding.setSurfaceSize(const Size(320, 568)); // iPhone SE
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BottomNavSpacer(),
          ),
        ),
      );

      final smallSize = tester.getSize(find.byType(BottomNavSpacer));
      expect(smallSize.height, 150);

      // Test avec une grande taille d'écran
      await tester.binding.setSurfaceSize(const Size(428, 926)); // iPhone Pro Max
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BottomNavSpacer(),
          ),
        ),
      );

      final largeSize = tester.getSize(find.byType(BottomNavSpacer));
      expect(largeSize.height, 150);

      // La hauteur devrait être constante
      expect(smallSize.height, largeSize.height);

      // Remettre la taille par défaut
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('should integrate correctly with HomePage', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Home Content'),
                  Container(height: 500, color: Colors.blue),
                  const BottomNavSpacer(),
                ],
              ),
            ),
          ),
        ),
      );

      // Vérifier que le contenu est visible
      expect(find.text('Home Content'), findsOneWidget);

      // Faire défiler jusqu'en bas
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -600));
      await tester.pumpAndSettle();

      // Vérifier que le spacer est présent en bas
      expect(find.byType(BottomNavSpacer), findsOneWidget);
    });
  });
}
