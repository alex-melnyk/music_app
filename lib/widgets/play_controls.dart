import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PlayControls extends StatelessWidget {
  PlayControls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconTheme(
        data: IconThemeData(
          color: Colors.white,
          size: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Feather.download,
              size: 24,
            ),
            Icon(
              Ionicons.ios_skip_backward,
              size: 32,
            ),
            Icon(
              MaterialCommunityIcons.pause_circle,
              size: 64,
            ),
            Icon(
              Ionicons.ios_skip_forward,
              size: 32,
            ),
            Icon(
              Feather.file_text,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
