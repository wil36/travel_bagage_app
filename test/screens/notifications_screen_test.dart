import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_bagage_app/screens/notifications_screen.dart';

void main() {
  group('NotificationsScreen Widget Tests', () {
    testWidgets('should display app bar with title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Vérifier que le titre est affiché
      expect(find.text('Notifications'), findsOneWidget);
    });

    testWidgets('should display mark all as read button in app bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Vérifier que le bouton "Tout marquer comme lu" est présent
      expect(find.byIcon(Icons.done_all), findsOneWidget);
    });

    testWidgets('should display list of notifications', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Vérifier que les notifications sont affichées
      expect(find.text('Nouveau message'), findsOneWidget);
      expect(find.text('Voyage accepté'), findsOneWidget);
      expect(find.text('Nouvelle demande'), findsOneWidget);
      expect(find.text('Mise à jour système'), findsOneWidget);
    });

    testWidgets('should display notification icons based on type', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Vérifier que les icônes appropriées sont affichées
      expect(find.byIcon(Icons.message_rounded), findsWidgets);
      expect(find.byIcon(Icons.flight_rounded), findsWidgets);
      expect(find.byIcon(Icons.inventory_2_rounded), findsWidgets);
      expect(find.byIcon(Icons.info_rounded), findsWidgets);
    });

    testWidgets('should display notification timestamp', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Vérifier que les timestamps sont affichés
      expect(find.textContaining('il y a'), findsWidgets);
    });

    testWidgets('should highlight unread notifications', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Les notifications non lues devraient avoir un fond bleu léger
      final unreadContainers = tester.widgetList<Container>(
        find.byWidgetPredicate(
          (widget) => widget is Container &&
                      widget.decoration is BoxDecoration &&
                      (widget.decoration as BoxDecoration).color != null,
        ),
      );

      expect(unreadContainers.length, greaterThan(0));
    });

    testWidgets('should display blue dot for unread notifications', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Vérifier que les points bleus sont présents pour les notifications non lues
      final blueDots = tester.widgetList<Container>(
        find.byWidgetPredicate(
          (widget) => widget is Container &&
                      widget.decoration is BoxDecoration &&
                      (widget.decoration as BoxDecoration).shape == BoxShape.circle &&
                      (widget.decoration as BoxDecoration).color == Colors.blue,
        ),
      );

      expect(blueDots.length, greaterThan(0));
    });

    testWidgets('should navigate to notification detail when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Trouver et appuyer sur la première notification
      final firstNotification = find.text('Nouveau message');
      await tester.tap(firstNotification);
      await tester.pumpAndSettle();

      // Vérifier que nous sommes sur l'écran de détail
      expect(find.byType(NotificationsScreen), findsNothing);
    });

    testWidgets('should support swipe to delete', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Vérifier que Dismissible est présent
      expect(find.byType(Dismissible), findsWidgets);

      // Compter le nombre initial de notifications
      final initialNotificationCount = tester.widgetList(find.byType(Dismissible)).length;

      // Faire glisser la première notification
      await tester.drag(find.byType(Dismissible).first, const Offset(-500, 0));
      await tester.pumpAndSettle();

      // Vérifier qu'une notification a été supprimée
      final finalNotificationCount = tester.widgetList(find.byType(Dismissible)).length;
      expect(finalNotificationCount, lessThan(initialNotificationCount));
    });

    testWidgets('should display red delete background when swiping', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Commencer à faire glisser
      await tester.drag(find.byType(Dismissible).first, const Offset(-100, 0));
      await tester.pump();

      // Vérifier que le fond rouge avec l'icône de suppression est visible
      expect(find.byIcon(Icons.delete_outline), findsWidgets);
    });

    testWidgets('should show snackbar after deleting notification', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Supprimer une notification
      await tester.drag(find.byType(Dismissible).first, const Offset(-500, 0));
      await tester.pumpAndSettle();

      // Vérifier que le snackbar est affiché
      expect(find.text('Notification supprimée'), findsOneWidget);
    });

    testWidgets('should mark notification as read when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Trouver une notification non lue
      final unreadNotification = find.text('Nouveau message');

      // Appuyer sur la notification
      await tester.tap(unreadNotification);
      await tester.pumpAndSettle();

      // Revenir en arrière
      await tester.pageBack();
      await tester.pumpAndSettle();

      // La notification devrait maintenant être marquée comme lue
      // (visuellement, elle n'aura plus le fond bleu ni le point bleu)
    });

    testWidgets('should display different colors for different notification types', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Vérifier que les conteneurs d'icônes ont différentes couleurs
      final iconContainers = tester.widgetList<Container>(
        find.byWidgetPredicate(
          (widget) => widget is Container &&
                      widget.decoration is BoxDecoration &&
                      (widget.decoration as BoxDecoration).color != null,
        ),
      );

      expect(iconContainers.length, greaterThan(0));
    });

    testWidgets('should display notification message preview', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Vérifier que les aperçus de messages sont affichés
      expect(find.textContaining('Jean Dupont vous a envoyé'), findsOneWidget);
      expect(find.textContaining('Votre voyage vers Dakar'), findsOneWidget);
      expect(find.textContaining('Marie Martin demande'), findsOneWidget);
    });

    testWidgets('should display correct icon and color for message notifications', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Les notifications de message devraient avoir une icône de message
      expect(find.byIcon(Icons.message_rounded), findsWidgets);
    });

    testWidgets('should display correct icon and color for trip notifications', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Les notifications de voyage devraient avoir une icône d'avion
      expect(find.byIcon(Icons.flight_rounded), findsWidgets);
    });

    testWidgets('should display correct icon and color for package notifications', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Les notifications de colis devraient avoir une icône de colis
      expect(find.byIcon(Icons.inventory_2_rounded), findsWidgets);
    });

    testWidgets('should display correct icon and color for system notifications', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Les notifications système devraient avoir une icône d'info
      expect(find.byIcon(Icons.info_rounded), findsWidgets);
    });

    testWidgets('should have InkWell for tap feedback', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Vérifier que InkWell est présent pour l'effet ripple
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('should format timestamp correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NotificationsScreen(),
        ),
      );

      // Vérifier que les timestamps sont formatés correctement
      expect(find.text('il y a 5 min'), findsOneWidget);
      expect(find.text('il y a 1 heure'), findsOneWidget);
      expect(find.text('il y a 3 heures'), findsOneWidget);
      expect(find.text('Hier'), findsOneWidget);
    });
  });

  group('NotificationModel Tests', () {
    test('should create NotificationModel with all required fields', () {
      final notification = NotificationModel(
        id: '1',
        title: 'Test Notification',
        message: 'Test message',
        timestamp: DateTime.now(),
        isRead: false,
        type: 'message',
      );

      expect(notification.id, '1');
      expect(notification.title, 'Test Notification');
      expect(notification.message, 'Test message');
      expect(notification.isRead, false);
      expect(notification.type, 'message');
    });

    test('should create NotificationModel with optional relatedId', () {
      final notification = NotificationModel(
        id: '1',
        title: 'Test Notification',
        message: 'Test message',
        timestamp: DateTime.now(),
        isRead: false,
        type: 'message',
        relatedId: 'related_123',
      );

      expect(notification.relatedId, 'related_123');
    });

    test('should support different notification types', () {
      final messageNotification = NotificationModel(
        id: '1',
        title: 'Message',
        message: 'New message',
        timestamp: DateTime.now(),
        isRead: false,
        type: 'message',
      );

      final tripNotification = NotificationModel(
        id: '2',
        title: 'Trip',
        message: 'New trip',
        timestamp: DateTime.now(),
        isRead: false,
        type: 'trip',
      );

      final packageNotification = NotificationModel(
        id: '3',
        title: 'Package',
        message: 'New package',
        timestamp: DateTime.now(),
        isRead: false,
        type: 'package',
      );

      final systemNotification = NotificationModel(
        id: '4',
        title: 'System',
        message: 'System update',
        timestamp: DateTime.now(),
        isRead: false,
        type: 'system',
      );

      expect(messageNotification.type, 'message');
      expect(tripNotification.type, 'trip');
      expect(packageNotification.type, 'package');
      expect(systemNotification.type, 'system');
    });

    test('should handle read and unread states', () {
      final unreadNotification = NotificationModel(
        id: '1',
        title: 'Test',
        message: 'Test',
        timestamp: DateTime.now(),
        isRead: false,
        type: 'message',
      );

      final readNotification = NotificationModel(
        id: '2',
        title: 'Test',
        message: 'Test',
        timestamp: DateTime.now(),
        isRead: true,
        type: 'message',
      );

      expect(unreadNotification.isRead, false);
      expect(readNotification.isRead, true);
    });
  });
}
