import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class GlassBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: IconlyLight.home,
                  activeIcon: IconlyBold.home,
                  label: 'Accueil',
                  index: 0,
                ),
                _buildNavItem(
                  icon: IconlyLight.send,
                  activeIcon: IconlyBold.send,
                  label: 'Voyages',
                  index: 1,
                ),
                _buildNavItem(
                  icon: IconlyLight.bag,
                  activeIcon: IconlyBold.bag,
                  label: 'Colis',
                  index: 2,
                ),
                _buildNavItem(
                  icon: IconlyLight.chat,
                  activeIcon: IconlyBold.chat,
                  label: 'Messages',
                  index: 3,
                ),
                _buildNavItem(
                  icon: IconlyLight.profile,
                  activeIcon: IconlyBold.profile,
                  label: 'Profil',
                  index: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isSelected ? activeIcon : icon,
                  color: isSelected ? Colors.blue : Colors.grey[600],
                  size: 26,
                ),
              ),
              const SizedBox(height: 4),
              // Visibility(
              //   visible: isSelected,
              //   child: Text(
              //     label,
              //     style: TextStyle(
              //       fontSize: 11,
              //       fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              //       color: isSelected ? Colors.blue : Colors.grey[600],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
