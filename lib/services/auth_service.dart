// Service d'authentification préparé pour le backend .NET
// TODO: Implémenter les appels API vers votre backend .NET

class AuthService {
  // TODO: Remplacer par l'URL de votre API .NET
  // static const String baseUrl = 'https://your-api.com/api';

  // Utilisateur actuellement connecté (à remplacer par un vrai état)
  Map<String, dynamic>? _currentUser;

  // Getter pour l'utilisateur courant
  Map<String, dynamic>? get currentUser => _currentUser;

  // Vérifier si l'utilisateur est connecté
  bool get isLoggedIn => _currentUser != null;

  // Connexion avec email et mot de passe
  Future<Map<String, dynamic>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    // TODO: Implémenter l'appel API vers POST /api/auth/login
    // final response = await http.post(
    //   Uri.parse('$baseUrl/auth/login'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({'email': email, 'password': password}),
    // );

    // Simulation pour le moment
    await Future.delayed(const Duration(seconds: 1));

    // Simuler une réponse
    _currentUser = {
      'id': '1',
      'email': email,
      'name': 'Utilisateur Test',
    };

    return _currentUser!;
  }

  // Inscription avec email et mot de passe
  Future<Map<String, dynamic>> registerWithEmail({
    required String email,
    required String password,
    String? name,
    String? phone,
  }) async {
    // TODO: Implémenter l'appel API vers POST /api/auth/register
    // final response = await http.post(
    //   Uri.parse('$baseUrl/auth/register'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({
    //     'email': email,
    //     'password': password,
    //     'name': name,
    //     'phone': phone,
    //   }),
    // );

    // Simulation pour le moment
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = {
      'id': '1',
      'email': email,
      'name': name ?? 'Nouvel utilisateur',
    };

    return _currentUser!;
  }

  // Connexion avec Google
  Future<Map<String, dynamic>?> signInWithGoogle() async {
    // TODO: Implémenter Google Sign In + appel API vers POST /api/auth/google
    // 1. Utiliser google_sign_in pour obtenir le token Google
    // 2. Envoyer le token à votre backend .NET pour validation
    // 3. Recevoir le JWT de votre backend

    // Simulation pour le moment
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = {
      'id': '2',
      'email': 'google.user@gmail.com',
      'name': 'Google User',
      'photoUrl': null,
    };

    return _currentUser;
  }

  // Déconnexion
  Future<void> signOut() async {
    // TODO: Implémenter l'appel API vers POST /api/auth/logout
    // + Supprimer le token JWT stocké localement

    _currentUser = null;
  }

  // Réinitialisation du mot de passe
  Future<void> resetPassword(String email) async {
    // TODO: Implémenter l'appel API vers POST /api/auth/forgot-password
    // final response = await http.post(
    //   Uri.parse('$baseUrl/auth/forgot-password'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({'email': email}),
    // );

    await Future.delayed(const Duration(seconds: 1));
  }

  // Obtenir le profil utilisateur
  Future<Map<String, dynamic>?> getCurrentUser() async {
    // TODO: Implémenter l'appel API vers GET /api/users/me
    // avec le token JWT dans les headers

    return _currentUser;
  }

  // Mettre à jour le profil
  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? phone,
    String? photoUrl,
  }) async {
    // TODO: Implémenter l'appel API vers PUT /api/users/me

    await Future.delayed(const Duration(seconds: 1));

    if (_currentUser != null) {
      _currentUser = {
        ..._currentUser!,
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
        if (photoUrl != null) 'photoUrl': photoUrl,
      };
    }

    return _currentUser ?? {};
  }
}
