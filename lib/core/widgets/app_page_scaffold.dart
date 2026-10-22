import 'package:flutter/material.dart';

/// Centered, scrollable, width-limited page body used by form-style screens.
class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({super.key, required this.child, this.appBar});

  final Widget child;
  final PreferredSizeWidget? appBar;

  static const double _maxWidth = 400;
  static const double _padding = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(_padding),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxWidth),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
