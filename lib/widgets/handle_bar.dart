import 'package:flutter/material.dart';

class HandleBar extends Builder {
  HandleBar({
    Key key,
    @required AnimationController animationController,
    VoidCallback onPressed,
  }) : super(
          key: key,
          builder: (context) {
            final opacityTween = Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animationController);

            final offsetTween = Tween<Offset>(
              begin: Offset.zero,
              end: Offset(0.0, 8.0),
            ).animate(animationController);

            return AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: offsetTween.value,
                  child: FractionallySizedBox(
                    widthFactor: 0.15,
                    child: Opacity(
                      opacity: opacityTween.value,
                      child: InkWell(
                        onTap: onPressed,
                        highlightColor: Colors.transparent,
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
                  ),
                );
              },
            );
          },
        );
}
