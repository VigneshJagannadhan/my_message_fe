import 'package:flutter/material.dart';

enum _AppButtonVariant { primary, secondary, destructive }

/// Primary button by default. Use [AppButton.secondary] or
/// [AppButton.destructive] for the other kinds. A null [onPressed] disables it.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.secondary;

  const AppButton.destructive({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  }) : _variant = _AppButtonVariant.destructive;

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final _AppButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    final VoidCallback? handler = enabled ? onPressed : null;

    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(label),
    );

    final colors = Theme.of(context).colorScheme;
    final button = switch (_variant) {
      _AppButtonVariant.primary => FilledButton(
        onPressed: handler,
        child: content,
      ),
      _AppButtonVariant.secondary => OutlinedButton(
        onPressed: handler,
        child: content,
      ),
      _AppButtonVariant.destructive => FilledButton(
        onPressed: handler,
        style: FilledButton.styleFrom(
          backgroundColor: colors.error,
          foregroundColor: colors.onError,
        ),
        child: content,
      ),
    };

    // The label stays readable to screen readers while the spinner is shown.
    return Semantics(
      label: label,
      button: true,
      enabled: enabled,
      excludeSemantics: true,
      onTap: handler,
      child: button,
    );
  }
}
