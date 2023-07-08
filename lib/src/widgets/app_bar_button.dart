import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;

  const AppBarButton({
    required this.tooltip,
    required this.onPressed,
    this.icon = Icons.arrow_back_ios_new,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: IconButton.filledTonal(
        splashRadius: 24,
        iconSize: 20,
        icon: Icon(icon),
        tooltip: tooltip,
        constraints: const BoxConstraints(
          maxHeight: 48,
          maxWidth: 48,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            theme.colorScheme.onBackground.withOpacity(0.2),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
