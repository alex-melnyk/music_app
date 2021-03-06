import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PlayInfo extends StatelessWidget {
  PlayInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 4,
                ),
                child: Text(
                  'Insomnia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                    ),
                    child: Text(
                      'Valetudo Beats',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    'S30',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          color: Colors.white,
          icon: Icon(
            MaterialCommunityIcons.heart_outline,
            size: 24,
          ),
          onPressed: () {},
        ),
        IconButton(
          color: Colors.white,
          icon: Icon(
            MaterialCommunityIcons.dots_horizontal_circle_outline,
            size: 24,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
