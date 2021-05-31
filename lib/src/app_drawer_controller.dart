import 'package:flutter/material.dart';

/// Use [animateForward] and [animateReverse] to open and close app drawer.
class AppDrawerWrapperController extends ChangeNotifier {
  /// "true" when app bar is collapsed
  bool isCollapsed = true;

  /// Set a value before calling [animateForward] or [animateReverse]
  AnimationController _animationController;

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

  AnimationController get animationController => _animationController;
}
