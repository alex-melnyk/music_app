import 'package:flutter/material.dart';

class TimelineSlider extends StatelessWidget {
  TimelineSlider({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = Duration(minutes: 2, seconds: 56);
    final play = Duration(seconds: 36);
    final left = play - total;

    final progress = play.inSeconds / total.inSeconds;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: double.maxFinite,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    width: double.maxFinite,
                    height: 4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.lerp(
                    Alignment.centerLeft,
                    Alignment.centerRight,
                    progress,
                  ),
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(play),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.grey[300],
                  ),
                ),
                Text(
                  formatDuration(left),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDuration(Duration duration) => [
    duration.inMinutes.remainder(60).toString().padLeft(1, '0'),
    duration.inSeconds
        .remainder(60)
        .toString()
        .replaceAll('-', '')
        .padLeft(1, '0'),
  ].join(':');
}
