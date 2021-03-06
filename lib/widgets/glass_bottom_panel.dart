import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:music_app/widgets/widgets.dart';

const animationDuration = Duration(milliseconds: 500);

class GlassBottomPanel extends StatefulWidget {
  const GlassBottomPanel({
    Key key,
    this.showCurrentPlay = false,
  }) : super(key: key);

  final bool showCurrentPlay;

  @override
  _GlassBottomPanelState createState() => _GlassBottomPanelState();
}

class _GlassBottomPanelState extends State<GlassBottomPanel>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  double _capturedValue = 0.0;
  Offset _capturedOffset;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      value: 0.0,
      duration: animationDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadiusTween(
            begin: BorderRadius.zero,
            end: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ).evaluate(_animationController),
          child: child,
        );
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15.0,
          sigmaX: 15.0,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragStart:
              widget.showCurrentPlay ? _handleVerticalDragStart : null,
          onVerticalDragUpdate: _handleVerticalDragUpdate,
          onVerticalDragEnd: _handleVerticalDragEnd,
          child: Container(
            color: Colors.white24,
            padding: const EdgeInsets.only(
              bottom: 8.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HandleBar(
                  animationController: _animationController,
                ),
                if (widget.showCurrentPlay)
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: _handleOpen,
                    child: CurrentPlayPanel(
                      animationController: _animationController,
                    ),
                  ),
                BottomTabBar(
                  animationController: _animationController,
                  controller: ValueNotifier<int>(0),
                  items: [
                    BottomTabBarItem('Home', Ionicons.ios_home),
                    BottomTabBarItem('Navigator', Ionicons.ios_compass),
                    BottomTabBarItem('Chat', Ionicons.ios_chatbubbles),
                    BottomTabBarItem('Profile', Ionicons.ios_person),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleVerticalDragStart(DragStartDetails details) {
    _capturedOffset = details.globalPosition;
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    if (_capturedOffset == null) return;

    final screenSize = MediaQuery.of(context).size;

    final diff = _capturedOffset - details.globalPosition;

    _animationController.value = _capturedValue + diff.dy / screenSize.height;
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    if (_capturedOffset == null) return;

    _capturedOffset = null;

    if (_animationController.value > 0.5) {
      _handleOpen();
    } else {
      _handleClose();
    }
  }

  void _handleOpen() {
    _capturedValue = 1.0;
    _animationController.animateTo(
      1.0,
      duration: animationDuration,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _handleClose() {
    _capturedValue = 0.0;
    _animationController.animateTo(
      0.0,
      duration: animationDuration,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}
