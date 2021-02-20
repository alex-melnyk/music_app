import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({
    Key key,
    @required this.animationController,
  }) : super(key: key);

  final AnimationController animationController;

  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  @override
  Widget build(BuildContext context) {
    final offsetTween = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 80),
    ).animate(widget.animationController);

    final scaleTween = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(widget.animationController);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: AnimatedBuilder(
        animation: widget.animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: offsetTween.value,
            child: Transform.scale(
              scale: scaleTween.value,
              child: child,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTabBarIcon(
                Ionicons.ios_home,
                'Home',
                Colors.grey,
              ),
              _buildTabBarIcon(
                Ionicons.ios_compass,
                'Navigator',
                Colors.orange,
              ),
              _buildTabBarIcon(
                Ionicons.ios_chatbubbles,
                'Chat',
                Colors.grey,
              ),
              _buildTabBarIcon(
                Ionicons.ios_person,
                'Profile',
                Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarIcon(IconData icon, String label, Color activeColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 4,
          ),
          child: Icon(
            icon,
            size: 24,
            color: activeColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: activeColor,
          ),
        ),
      ],
    );
  }
}
