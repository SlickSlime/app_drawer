import 'package:app_drawer/app_drawer.dart';
import 'package:flutter/material.dart';

/// Use [animateForward] and [animateReverse] to open and close app drawer.
class AppDrawerController extends ChangeNotifier {
  /// "true" when app bar is collapsed
  bool isCollapsed = true;

  /// Set a value before calling [animateForward] or [animateReverse]
  AnimationController _animationController;

  /// App drawer open/close animation duration
  final Duration duration;

  /// Used to define how the height of [AppDrawerWrapper.child] will be shrunk when app drawer
  /// is opened. Use it in tandem with [collapsedWidth].
  ///
  /// Default value is 0.1
  ///
  /// Example:
  /// Setting [collapsedHeight] to 0.1 will shrink height of [AppDrawerWrapper.child]
  /// by 10% of it's original height.
  final double collapsedHeight;

  /// Used to define how the width of [AppDrawerWrapper.child] will be shrunk when app drawer
  /// is opened. Use it in tandem with [collapsedHeight].
  ///
  /// Default value is 0.6
  ///
  /// Example:
  /// Setting [collapsedWidth] to 0.8 will shrink height of [AppDrawerWrapper.child]
  /// by 80% of it's original height.
  final double collapsedWidth;

  AppDrawerController({
    this.duration = const Duration(milliseconds: 500),
    this.collapsedHeight = 0.1,
    this.collapsedWidth = 0.6,
  });

  Future<void> animateForward() {
    isCollapsed = false;
    notifyListeners();
    return _animationController?.forward();
  }

  Future<void> animateReverse() {
    isCollapsed = true;
    notifyListeners();
    return _animationController?.reverse();
  }

  void disposeAnimationController() {
    return _animationController?.dispose();
  }

  set animationController(AnimationController value) {
    _animationController = value;
  }
}
