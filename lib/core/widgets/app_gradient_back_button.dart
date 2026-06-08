import 'package:flutter/material.dart';

class AppGradientBackButton extends StatelessWidget {
  const AppGradientBackButton({
    this.icon = Icons.arrow_back_ios_new,
    this.size = 20,
    this.onPressed,
    super.key,
  });

  final IconData icon;
  final double size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final iconTheme = Theme.of(context).appBarTheme.iconTheme;

    return IconButton(
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      icon: Icon(
        icon,
        size: size,
        color: iconTheme?.color,
      ),
    );
  }
}
