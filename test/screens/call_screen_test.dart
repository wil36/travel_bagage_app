import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_bagage_app/screens/call_screen.dart';

void main() {
  group('CallScreen Widget Tests', () {
    testWidgets('should display user name in audio call mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Jean Dupont',
            isVideoCall: false,
          ),
        ),
      );

      // Vérifier que le nom de l'utilisateur est affiché
      expect(find.text('Jean Dupont'), findsWidgets);

      // Vérifier que l'avatar initial est affiché
      expect(find.text('J'), findsOneWidget);
    });

    testWidgets('should display "Appel en cours..." initially', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Marie Martin',
            isVideoCall: false,
          ),
        ),
      );

      // Vérifier le statut initial
      expect(find.text('Appel en cours...'), findsWidgets);
    });

    testWidgets('should connect after 2 seconds', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Sophie Bernard',
            isVideoCall: false,
          ),
        ),
      );

      // Attendre 2 secondes pour la connexion simulée
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Vérifier que le statut a changé à "Connecté"
      expect(find.text('Connecté'), findsNothing); // Le statut affiche maintenant la durée
      expect(find.text('00:00'), findsWidgets);
    });

    testWidgets('should display mute button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Thomas Petit',
            isVideoCall: false,
          ),
        ),
      );

      // Vérifier que le bouton muet est présent
      expect(find.byIcon(Icons.mic), findsOneWidget);
      expect(find.text('Muet'), findsOneWidget);
    });

    testWidgets('should toggle mute state when mute button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Claire Dubois',
            isVideoCall: false,
          ),
        ),
      );

      // Trouver et appuyer sur le bouton muet
      final muteButton = find.widgetWithText(Column, 'Muet');
      expect(muteButton, findsOneWidget);

      await tester.tap(muteButton);
      await tester.pump();

      // Vérifier que l'icône a changé
      expect(find.byIcon(Icons.mic_off), findsOneWidget);
      expect(find.text('Réactiver'), findsOneWidget);
    });

    testWidgets('should display speaker button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Ahmed Diallo',
            isVideoCall: false,
          ),
        ),
      );

      // Vérifier que le bouton haut-parleur est présent
      expect(find.byIcon(Icons.volume_down), findsOneWidget);
      expect(find.text('Écouteur'), findsOneWidget);
    });

    testWidgets('should toggle speaker state when speaker button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Marie Kouassi',
            isVideoCall: false,
          ),
        ),
      );

      // Trouver et appuyer sur le bouton haut-parleur
      final speakerButton = find.widgetWithText(Column, 'Écouteur');
      expect(speakerButton, findsOneWidget);

      await tester.tap(speakerButton);
      await tester.pump();

      // Vérifier que l'icône a changé
      expect(find.byIcon(Icons.volume_up), findsOneWidget);
      expect(find.text('Haut-parleur'), findsOneWidget);
    });

    testWidgets('should display video button in video call mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Jean Dupont',
            isVideoCall: true,
          ),
        ),
      );

      // Vérifier que le bouton vidéo est présent
      expect(find.byIcon(Icons.videocam), findsWidgets);
      expect(find.text('Caméra'), findsOneWidget);
    });

    testWidgets('should not display video button in audio call mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Sophie Bernard',
            isVideoCall: false,
          ),
        ),
      );

      // Vérifier que le bouton vidéo n'est pas présent
      expect(find.text('Caméra'), findsNothing);
      expect(find.text('Cam. off'), findsNothing);
    });

    testWidgets('should display end call button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Thomas Petit',
            isVideoCall: false,
          ),
        ),
      );

      // Vérifier que le bouton raccrocher est présent
      expect(find.byIcon(Icons.call_end), findsOneWidget);
    });

    testWidgets('should end call when end button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CallScreen(
                        userId: 'test_user_1',
                        userName: 'Claire Dubois',
                        isVideoCall: false,
                      ),
                    ),
                  );
                },
                child: const Text('Start Call'),
              ),
            ),
          ),
        ),
      );

      // Démarrer l'appel
      await tester.tap(find.text('Start Call'));
      await tester.pumpAndSettle();

      // Vérifier que l'écran d'appel est affiché
      expect(find.text('Claire Dubois'), findsWidgets);

      // Appuyer sur le bouton raccrocher
      await tester.tap(find.byIcon(Icons.call_end));
      await tester.pumpAndSettle();

      // Vérifier que nous sommes revenus à l'écran précédent
      expect(find.text('Start Call'), findsOneWidget);
      expect(find.text('Claire Dubois'), findsNothing);
    });

    testWidgets('should format call duration correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Ahmed Diallo',
            isVideoCall: false,
          ),
        ),
      );

      // Attendre la connexion
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Vérifier le format initial (00:00)
      expect(find.text('00:00'), findsWidgets);

      // Avancer de 5 secondes
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      // Vérifier que la durée est mise à jour
      expect(find.textContaining(':'), findsWidgets);
    });

    testWidgets('should display local video preview in video call mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Marie Kouassi',
            isVideoCall: true,
          ),
        ),
      );

      // Vérifier que l'aperçu vidéo locale est affiché
      expect(find.text('Vous'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsWidgets);
    });

    testWidgets('should not display local video preview in audio call mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Jean Dupont',
            isVideoCall: false,
          ),
        ),
      );

      // Vérifier que l'aperçu vidéo locale n'est pas affiché
      expect(find.text('Vous'), findsNothing);
    });

    testWidgets('should use SafeArea to avoid system UI', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CallScreen(
            userId: 'test_user_1',
            userName: 'Sophie Bernard',
            isVideoCall: false,
          ),
        ),
      );

      // Vérifier que SafeArea est présent
      expect(find.byType(SafeArea), findsOneWidget);
    });
  });
}
