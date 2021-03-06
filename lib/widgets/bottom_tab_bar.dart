import 'package:flutter/material.dart';

class BottomTabBarItem {
  const BottomTabBarItem(this.title, this.icon);

  final String title;
  final IconData icon;
}

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({
    Key key,
    @required this.animationController,
    @required this.items,
    @required this.controller,
  }) : super(key: key);

  final AnimationController animationController;
  final List<BottomTabBarItem> items;
  final ValueNotifier<int> controller;

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
      end: 0.75,
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
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ValueListenableBuilder(
            valueListenable: widget.controller,
            builder: (_, value, __) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.items
                    .asMap()
                    .map((key, value) {
                      final isSelected = widget.controller.value == key;

                      return MapEntry(
                        key,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 4,
                              ),
                              child: Icon(
                                value.icon,
                                size: 24,
                                color: isSelected ? Colors.orange : Colors.grey,
                              ),
                            ),
                            Text(
                              value.title,
                              style: TextStyle(
                                fontSize: 10,
                                color: isSelected ? Colors.orange : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                    .values
                    .toList(growable: false),
              );
            },
          ),
        ),
      ),
    );
  }
}
