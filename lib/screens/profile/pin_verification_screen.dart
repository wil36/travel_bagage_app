import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinVerificationScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onSuccess;

  const PinVerificationScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onSuccess,
  });

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  String _errorMessage = '';
  final String _correctPin = '1234'; // En production, ceci viendrait du serveur

  @override
  void initState() {
    super.initState();
    // Auto-focus on first field
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _focusNodes[0].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Icône de sécurité
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: 40,
                  color: Colors.blue[700],
                ),
              ),

              const SizedBox(height: 32),

              // Titre
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Sous-titre
              Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Champs de saisie du code
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.only(
                      right: index < 3 ? 16 : 0,
                    ),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      obscureText: true,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          // Move to next field
                          if (index < 3) {
                            _focusNodes[index + 1].requestFocus();
                          } else {
                            // Last field filled, verify PIN
                            _focusNodes[index].unfocus();
                            _verifyPin();
                          }
                        }

                        setState(() {
                          _errorMessage = '';
                        });
                      },
                      onTap: () {
                        // Select all text when tapped
                        _controllers[index].selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: _controllers[index].text.length,
                        );
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 16),

              // Message d'erreur
              if (_errorMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red[700],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _errorMessage,
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

              const Spacer(),

              // Lien "Code oublié"
              TextButton(
                onPressed: _handleForgotPin,
                child: const Text(
                  'Code oublié ?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Bouton Continuer
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _verifyPin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continuer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyPin() {
    final enteredPin = _controllers.map((c) => c.text).join();

    if (enteredPin.length != 4) {
      setState(() {
        _errorMessage = 'Veuillez entrer le code complet';
      });
      return;
    }

    if (enteredPin == _correctPin) {
      // Success
      widget.onSuccess();
      Navigator.pop(context, true);
    } else {
      // Error
      setState(() {
        _errorMessage = 'Code incorrect';
        // Clear all fields
        for (var controller in _controllers) {
          controller.clear();
        }
        // Focus first field
        _focusNodes[0].requestFocus();
      });

      // Shake animation would be nice here
      _shakeFields();
    }
  }

  void _shakeFields() {
    // Simple error feedback with haptic
    HapticFeedback.vibrate();
  }

  void _handleForgotPin() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Code oublié'),
        content: const Text(
          'Un code de vérification a été envoyé à votre numéro de téléphone +33 6 ** ** ** 78',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
