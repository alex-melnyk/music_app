import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CurrentPlayPanel extends StatefulWidget {
  const CurrentPlayPanel({
    Key key,
    @required this.animationController,
  }) : super(key: key);

  final AnimationController animationController;

  @override
  _CurrentPlayPanelState createState() => _CurrentPlayPanelState();
}

class _CurrentPlayPanelState extends State<CurrentPlayPanel>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: widget.animationController,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 8,
            ),
            height: Tween<double>(
              begin: 58,
              end: screenSize.height - 120,
            ).animate(widget.animationController).value,
            child: child,
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: Transform.translate(
                offset: Offset(0, 0),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    top: 24,
                  ),
                  clipBehavior: Clip.none,
                  child: Stack(
                    children: [
                      AnimatedBuilder(
                        animation: widget.animationController,
                        builder: (context, child) {
                          final scaleTween = Tween<double>(
                            begin: 0.75,
                            end: 1.0,
                          ).evaluate(widget.animationController);

                          final trans1Tween = Tween(
                            begin: Offset(0, 100),
                            end: Offset.zero,
                          ).evaluate(widget.animationController);

                          final trans2Tween = Tween(
                            begin: Offset(0, 150),
                            end: Offset.zero,
                          ).evaluate(widget.animationController);

                          final trans3Tween = Tween(
                            begin: Offset(0, 200),
                            end: Offset.zero,
                          ).evaluate(widget.animationController);

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Transform.scale(
                                scale: scaleTween,
                                child: Transform.translate(
                                  offset: trans1Tween,
                                  child: _buildFullTitle(),
                                ),
                              ),
                              Transform.scale(
                                scale: scaleTween,
                                child: Transform.translate(
                                  offset: trans2Tween,
                                  child: _buildTimeline(),
                                ),
                              ),
                              Transform.scale(
                                scale: scaleTween,
                                child: Transform.translate(
                                  offset: trans3Tween,
                                  child: _buildControls(),
                                ),
                              ),
                              Transform.scale(
                                scale: scaleTween,
                                child: Transform.translate(
                                  offset: trans3Tween,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 16,
                                    ),
                                    child: OutlineButton(
                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 12.0,
                                        ),
                                        child: Text(
                                          '+ Add to cart',
                                        ),
                                      ),
                                      color: Colors.white,
                                      textColor: Colors.white,
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final screenSize = MediaQuery.of(context).size;

    return IntrinsicHeight(
      child: Stack(
        children: [
          OverflowBox(
            alignment: Alignment.topLeft,
            maxWidth: screenSize.width * 2,
            maxHeight: screenSize.height,
            child: AnimatedBuilder(
              animation: widget.animationController,
              builder: (context, child) {
                final sizeTween = Tween<double>(
                  begin: 50.0,
                  end: screenSize.width - 24 - 24,
                ).animate(widget.animationController);

                final paddingTween = EdgeInsetsTween(
                  begin: EdgeInsets.zero,
                  end: EdgeInsets.only(
                    top: 48,
                  ),
                ).animate(widget.animationController);

                return Padding(
                  padding: paddingTween.value,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: sizeTween.value,
                        height: sizeTween.value,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            image: DecorationImage(
                              image: AssetImage('assets/images/trap.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      child,
                    ],
                  ),
                );
              },
              child: AnimatedBuilder(
                animation: widget.animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: Tween<double>(
                      begin: 1.0,
                      end: 0.0,
                    ).evaluate(widget.animationController),
                    child: child,
                  );
                },
                child: SizedBox(
                  width: screenSize.width - 24 - 24 - 50,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: _buildSlimTitle(),
                        ),
                      ),
                      Icon(
                        MaterialCommunityIcons.play,
                        size: 32,
                        color: Colors.white,
                      ),
                      Icon(
                        MaterialCommunityIcons.close,
                        size: 32,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlimTitle({double scaleFactor = 1.0}) {
    return Column(
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
              fontSize: 16 * scaleFactor,
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
                  fontSize: 14 * scaleFactor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              'S30',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14 * scaleFactor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFullTitle() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _buildSlimTitle(scaleFactor: 1.15),
        ),
        IconButton(
          color: Colors.white,
          icon: Icon(MaterialCommunityIcons.heart_outline),
          onPressed: () {},
        ),
        IconButton(
          color: Colors.white,
          icon: Icon(MaterialCommunityIcons.dots_horizontal_circle_outline),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTimeline() {
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
          _buildSlider(progress),
          _buildTime(play, left),
        ],
      ),
    );
  }

  Widget _buildSlider(double progress) {
    return IntrinsicHeight(
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
    );
  }

  Widget _buildTime(Duration play, Duration left) {
    return Container(
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
    );
  }

  Widget _buildControls() {
    return Container(
      child: IconTheme(
        data: IconThemeData(
          color: Colors.white,
          size: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Feather.download),
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
            Icon(Feather.file_text),
          ],
        ),
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
