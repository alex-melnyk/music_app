import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:music_app/widgets/current_play_bar.dart';

const animationDuration = Duration(milliseconds: 500);

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key key,
    this.showCurrentPlay = false,
  }) : super(key: key);

  final bool showCurrentPlay;

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  CurrentPlayBar _currentPlayBar;
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

    _currentPlayBar = CurrentPlayBar(
      animationController: _animationController,
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
                _buildHandleBar(),
                if (widget.showCurrentPlay)
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: _handleOpen,
                    child: _currentPlayBar,
                  ),
                _buildTabBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHandleBar() {
    final opacityTween = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);

    final offsetTween = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, 8.0),
    ).animate(_animationController);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: offsetTween.value,
          child: FractionallySizedBox(
            widthFactor: 0.15,
            child: Opacity(
              opacity: opacityTween.value,
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 4.0,
                ),
                height: 4.0,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabBar() {
    final offsetTween = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 80),
    ).animate(_animationController);

    final scaleTween = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(_animationController);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: AnimatedBuilder(
        animation: _animationController,
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
