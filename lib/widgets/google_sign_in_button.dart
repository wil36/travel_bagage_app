import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final String pathImage;

  const SocialSignInButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.pathImage,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: BorderSide(color: Colors.grey[300]!),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 24, height: 24, child: _buildImage()),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (pathImage.endsWith('.svg')) {
      return SvgPicture.asset(pathImage, width: 24, height: 24);
    } else {
      return Image.asset(pathImage, width: 24, height: 24);
    }
  }
}
