import 'package:flutter/material.dart';

import 'app_drawer_controller.dart';

/// Wrap a page with [AppDrawerWrapper] and ChangeNotifierProvider of
/// [AppDrawerController] to add "animated" app drawer to that page.
///
/// Use [AppDrawerController.animateForward] and [AppDrawerController.animateReverse]
/// to open and close app drawer.
class AppDrawerWrapper extends StatefulWidget {
  const AppDrawerWrapper({
    Key key,
    @required this.appDrawer,
    @required this.child,
    @required this.controller,
  }) : super(key: key);

  /// Main UI
  final Widget child;

  /// App drawer UI
  final Widget appDrawer;

  /// ...
  final AppDrawerController controller;

  @override
  _AppDrawerWrapperState createState() {
    return _AppDrawerWrapperState();
  }
}

class _AppDrawerWrapperState extends State<AppDrawerWrapper>
    with SingleTickerProviderStateMixin {
  double screenWidth, screenHeight;

  @override
  void initState() {
    super.initState();

    widget.controller.animationController = AnimationController(
      vsync: this,
      duration: widget.controller.duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    AppDrawerController wrapperController = widget.controller;

    return WillPopScope(
      onWillPop: () async {
        if (!wrapperController.isCollapsed) {
          // Not collapsed. Go to uncollapsed state
          wrapperController.animateReverse();
          return false;
        } else
          return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            widget.appDrawer,
            AnimatedPositioned(
              duration: widget.controller.duration,
              left: wrapperController.isCollapsed
                  ? 0
                  : widget.controller.collapsedWidth * screenWidth,
              right: wrapperController.isCollapsed
                  ? 0
                  : -widget.controller.collapsedWidth * screenWidth,
              top: wrapperController.isCollapsed
                  ? 0
                  : screenHeight * widget.controller.collapsedHeight,
              bottom: wrapperController.isCollapsed
                  ? 0
                  : screenHeight * widget.controller.collapsedHeight,
              curve: Curves.fastOutSlowIn,
              child: InkWell(
                onTap: () {
                  if (!wrapperController.isCollapsed) {
                    // "child" tapped in collapsed state. Go to uncollapsed state.
                    wrapperController.animateReverse();
                  }
                },
                child: AbsorbPointer(
                  // Don't register taps on "child" in collapsed state
                  absorbing: !wrapperController.isCollapsed,
                  child: Container(
                    child: widget.child,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.disposeAnimationController();
    super.dispose();
  }
}
