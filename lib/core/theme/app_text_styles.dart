import 'package:flutter/material.dart';

/// Semantic text styles. Pick the one that matches the text's role, then
/// adjust with `?.copyWith(...)` if needed.
class HeadingText {
  const HeadingText._();

  static TextStyle? smallStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge;

  static TextStyle? mediumStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall;

  static TextStyle? largeStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium;
}

class BodyText {
  const BodyText._();

  static TextStyle? smallStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall;

  static TextStyle? mediumStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium;

  static TextStyle? largeStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge;
}

class LabelText {
  const LabelText._();

  static TextStyle? smallStyle(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall;

  static TextStyle? mediumStyle(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium;

  static TextStyle? largeStyle(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge;
}
