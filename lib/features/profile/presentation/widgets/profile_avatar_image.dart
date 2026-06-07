import 'dart:io';

import 'package:flutter/material.dart';

class ProfileAvatarImage extends StatelessWidget {
  const ProfileAvatarImage({
    required this.avatarPath,
    required this.size,
    super.key,
  });

  final String avatarPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    final image = avatarPath.startsWith('assets/')
        ? Image.asset(avatarPath, width: size, height: size, fit: BoxFit.cover)
        : Image.file(File(avatarPath),
            width: size, height: size, fit: BoxFit.cover);

    return ClipOval(child: image);
  }
}
