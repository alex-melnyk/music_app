import 'package:flutter/material.dart';

class PageBar extends StatefulWidget {
  const PageBar({
    Key key,
    @required this.tabs,
    @required this.itemBuilder,
    this.textStyle,
  }) : super(key: key);

  final List<String> tabs;
  final IndexedWidgetBuilder itemBuilder;
  final TextStyle textStyle;

  @override
  _PageBarState createState() => _PageBarState();
}

class _PageBarState extends State<PageBar>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  AnimationController _controller;
  final _animationDuration = 250;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationDuration),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabs(),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.tabs.length,
            itemBuilder: widget.itemBuilder,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final selectorAlignment = Alignment.lerp(
            Alignment.centerLeft,
            Alignment.centerRight,
            _controller.value,
          );

          final itemWidthFactor = 1.0 / widget.tabs.length;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: widget.tabs
                    .asMap()
                    .map((key, value) {
                      final offset = key / (widget.tabs.length - 1);

                      final labelColor = Color.lerp(
                        Colors.white,
                        Colors.white70,
                        _controller.value == offset ? 0.0 : 1.0,
                      );

                      return MapEntry(
                        key,
                        _buildTabItem(
                          value,
                          labelColor,
                          () {
                            _controller.animateTo(
                              offset,
                              duration: Duration(
                                milliseconds: _animationDuration,
                              ),
                              curve: Curves.easeInOut,
                            );
                            _pageController.animateToPage(
                              key,
                              duration: Duration(
                                milliseconds: _animationDuration,
                              ),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      );
                    })
                    .values
                    .toList(growable: false),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: selectorAlignment,
                    child: FractionallySizedBox(
                      widthFactor: itemWidthFactor,
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.orange,
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabItem(
    String label,
    Color activeColor,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: activeColor,
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: widget.textStyle,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
