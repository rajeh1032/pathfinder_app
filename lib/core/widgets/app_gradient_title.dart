import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../theme/app_gradients.dart';
import '../theme/app_text_styles.dart';

class AppGradientTitle extends StatelessWidget {
  const AppGradientTitle({this.titleKey = 'app.name', super.key});

  final String titleKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.titleLarge;

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: AppGradients.aiTertiary.createShader,
      child: Text(
        titleKey.tr(),
        style: titleStyle?.copyWith(color: Colors.white) ??
            AppTextStyles.titleLarge(Colors.white),
      ),
    );
  }
}
