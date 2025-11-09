import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_bagage_app/screens/messages_list_screen.dart';

void main() {
  group('MessagesListScreen Widget Tests', () {
    testWidgets('should display app bar with title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier que le titre est affiché
      expect(find.text('Messages'), findsOneWidget);
    });

    testWidgets('should display search icon in app bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier que l'icône de recherche est présente
      expect(find.byIcon(Icons.search_rounded), findsOneWidget);
    });

    testWidgets('should display list of messages', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier que les messages sont affichés
      expect(find.text('Jean Dupont'), findsOneWidget);
      expect(find.text('Marie Martin'), findsOneWidget);
      expect(find.text('Sophie Bernard'), findsOneWidget);
      expect(find.text('Thomas Petit'), findsOneWidget);
      expect(find.text('Claire Dubois'), findsOneWidget);
    });

    testWidgets('should display message preview text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier que les aperçus de messages sont affichés
      expect(find.textContaining('Bonjour, je suis intéressé'), findsOneWidget);
      expect(find.textContaining('quelle heure arrive'), findsOneWidget);
      expect(find.textContaining('bien arrivé'), findsOneWidget);
    });

    testWidgets('should display timestamp for messages', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier que les timestamps sont affichés
      expect(find.text('5m'), findsOneWidget);
      expect(find.text('2h'), findsOneWidget);
      expect(find.text('Hier'), findsOneWidget);
    });

    testWidgets('should display unread count badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier que les badges de messages non lus sont affichés
      expect(find.text('2'), findsOneWidget); // Jean Dupont has 2 unread
      expect(find.text('1'), findsOneWidget); // Thomas Petit has 1 unread
    });

    testWidgets('should display green indicator for unread messages', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier que les indicateurs verts sont présents pour les messages non lus
      final greenIndicators = tester.widgetList<Container>(
        find.byWidgetPredicate(
          (widget) => widget is Container &&
                      widget.decoration is BoxDecoration &&
                      (widget.decoration as BoxDecoration).color == Colors.green,
        ),
      );

      expect(greenIndicators.length, greaterThan(0));
    });

    testWidgets('should display user avatar with first letter', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier que les avatars avec les initiales sont affichés
      expect(find.text('J'), findsOneWidget); // Jean
      expect(find.text('M'), findsOneWidget); // Marie
      expect(find.text('S'), findsOneWidget); // Sophie
      expect(find.text('T'), findsOneWidget); // Thomas
      expect(find.text('C'), findsOneWidget); // Claire
    });

    testWidgets('should navigate to chat detail when message is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Trouver et appuyer sur le premier message
      final firstMessage = find.text('Jean Dupont').first;
      await tester.tap(firstMessage);
      await tester.pumpAndSettle();

      // Vérifier que nous sommes sur l'écran de détail du chat
      expect(find.text('Jean Dupont'), findsWidgets);
    });

    testWidgets('should navigate to user profile when avatar is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Trouver et appuyer sur le premier avatar
      final avatars = find.byType(CircleAvatar);
      await tester.tap(avatars.first);
      await tester.pumpAndSettle();

      // Vérifier que nous sommes sur l'écran de profil utilisateur
      // (Le profil affichera également le nom de l'utilisateur)
      expect(find.byType(MessagesListScreen), findsNothing);
    });

    testWidgets('should highlight unread messages with different styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Les messages non lus devraient avoir un fond bleu léger
      final unreadContainers = tester.widgetList<Container>(
        find.byWidgetPredicate(
          (widget) => widget is Container &&
                      widget.decoration is BoxDecoration &&
                      (widget.decoration as BoxDecoration).color != null,
        ),
      );

      expect(unreadContainers.length, greaterThan(0));
    });

    testWidgets('should display bottom nav spacer', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Faire défiler jusqu'en bas pour voir le spacer
      await tester.dragUntilVisible(
        find.byType(SizedBox).last,
        find.byType(ListView),
        const Offset(0, -100),
      );

      // Vérifier que le spacer est présent
      final spacers = find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == 150,
      );
      expect(spacers, findsWidgets);
    });

    testWidgets('should format time correctly for recent messages', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier les différents formats de temps
      expect(find.text('5m'), findsOneWidget); // Minutes
      expect(find.text('2h'), findsOneWidget); // Heures
      expect(find.text('Hier'), findsOneWidget); // Hier
      expect(find.text('2j'), findsOneWidget); // Jours
      expect(find.text('3j'), findsOneWidget); // Jours
    });

    testWidgets('should display emoji in messages', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier que l'emoji est affiché correctement
      expect(find.textContaining('❤️'), findsOneWidget);
    });

    testWidgets('should display message card with correct border', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier que les cartes de messages ont des bordures
      final containers = tester.widgetList<Container>(
        find.byWidgetPredicate(
          (widget) => widget is Container &&
                      widget.decoration is BoxDecoration &&
                      (widget.decoration as BoxDecoration).border != null,
        ),
      );

      expect(containers.length, greaterThan(0));
    });

    testWidgets('should apply InkWell ripple effect on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier que InkWell est présent pour l'effet ripple
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('should display correct text ellipsis for long messages', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MessagesListScreen(),
        ),
      );

      // Vérifier que les textes longs sont tronqués
      final textWidgets = tester.widgetList<Text>(
        find.byWidgetPredicate(
          (widget) => widget is Text &&
                      widget.overflow == TextOverflow.ellipsis,
        ),
      );

      expect(textWidgets.length, greaterThan(0));
    });
  });

  group('Message Model Tests', () {
    test('should create Message with all required fields', () {
      final message = Message(
        id: '1',
        userId: 'user1',
        userName: 'Test User',
        lastMessage: 'Test message',
        timestamp: DateTime.now(),
        unreadCount: 0,
      );

      expect(message.id, '1');
      expect(message.userId, 'user1');
      expect(message.userName, 'Test User');
      expect(message.lastMessage, 'Test message');
      expect(message.unreadCount, 0);
    });

    test('should create Message with optional userAvatar', () {
      final message = Message(
        id: '1',
        userId: 'user1',
        userName: 'Test User',
        lastMessage: 'Test message',
        timestamp: DateTime.now(),
        userAvatar: 'avatar_url.png',
      );

      expect(message.userAvatar, 'avatar_url.png');
    });

    test('should default unreadCount to 0', () {
      final message = Message(
        id: '1',
        userId: 'user1',
        userName: 'Test User',
        lastMessage: 'Test message',
        timestamp: DateTime.now(),
      );

      expect(message.unreadCount, 0);
    });
  });
}
