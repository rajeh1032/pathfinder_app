import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../domain/entities/profile.dart';
import '../cubit/edit_profile_cubit.dart';
import 'edit_profile_fields.dart';
import 'profile_avatar_image.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({
    required this.profile,
    required this.isSubmitting,
    super.key,
  });

  final Profile profile;
  final bool isSubmitting;

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _headlineController;
  late final TextEditingController _emailController;
  late final TextEditingController _locationController;
  late final TextEditingController _bioController;
  late String _savedName;
  late String _savedHeadline;
  late String _savedEmail;
  late String _savedLocation;
  late String _savedBio;
  late String _savedAvatarPath;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.profile.fullNameKey.tr());
    _headlineController =
        TextEditingController(text: widget.profile.headlineKey.tr());
    _emailController =
        TextEditingController(text: widget.profile.emailKey.tr());
    _locationController =
        TextEditingController(text: widget.profile.locationKey.tr());
    _bioController = TextEditingController(text: widget.profile.bioKey.tr());
    _storeSavedSnapshot();
    for (final controller in _controllers) {
      controller.addListener(_refreshChanges);
    }
  }

  @override
  void didUpdateWidget(EditProfileForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSubmitting && !widget.isSubmitting) {
      _storeSavedSnapshot();
    }
    _refreshChanges();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.removeListener(_refreshChanges);
    }
    _nameController.dispose();
    _headlineController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xxl,
      ),
      children: [
        Column(
          children: [
            ProfileAvatarImage(
              avatarPath: widget.profile.avatarAsset,
              size: 112,
            ),
            const SizedBox(height: AppSpacing.md),
            CustomButton(
              labelKey: 'profile.changePhoto',
              icon: Icons.add_photo_alternate_outlined,
              onPressed:
                  widget.isSubmitting ? null : () => _showPhotoSheet(context),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        EditProfileField(
            controller: _nameController, labelKey: 'profile.editName'),
        EditProfileField(
            controller: _headlineController, labelKey: 'profile.editHeadline'),
        EditProfileField(
          controller: _emailController,
          labelKey: 'profile.editEmail',
          keyboardType: TextInputType.emailAddress,
        ),
        EditProfileField(
            controller: _locationController, labelKey: 'profile.editLocation'),
        EditProfileField(
          controller: _bioController,
          labelKey: 'profile.editBio',
          minLines: 4,
          maxLines: 6,
        ),
        const SizedBox(height: AppSpacing.md),
        CustomButton(
          labelKey: 'profile.resetPassword',
          icon: Icons.lock_reset_outlined,
          variant: CustomButtonVariant.outline,
          onPressed: () => Navigator.pushNamed(
            context,
            AppRoutes.profileResetPassword,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        CustomButton(
          labelKey: 'profile.save',
          isLoading: widget.isSubmitting,
          onPressed: widget.isSubmitting || !_hasChanges
              ? null
              : () => _submit(context),
        ),
      ],
    );
  }

  void _submit(BuildContext context) {
    context.read<EditProfileCubit>().submit(
          fullName: _nameController.text,
          headline: _headlineController.text,
          email: _emailController.text,
          location: _locationController.text,
          bio: _bioController.text,
        );
  }

  Future<void> _showPhotoSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EditProfilePhotoAction(
                  icon: Icons.photo_library_outlined,
                  labelKey: 'profile.pickFromGallery',
                  onTap: () async {
                    Navigator.of(sheetContext).pop();
                    await _pickFromGallery(context);
                  },
                ),
                EditProfilePhotoAction(
                  icon: Icons.photo_camera_outlined,
                  labelKey: 'profile.takePhoto',
                  onTap: () async {
                    Navigator.of(sheetContext).pop();
                    await _requestCamera(context);
                  },
                ),
                EditProfilePhotoAction(
                  icon: Icons.delete_outline,
                  labelKey: 'profile.removePhoto',
                  onTap: () {
                    context.read<EditProfileCubit>().removeAvatar();
                    Navigator.of(sheetContext).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickFromGallery(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    final path = result?.files.single.path;
    if (path == null || !context.mounted) return;
    context.read<EditProfileCubit>().selectAvatar(path);
  }

  Future<void> _requestCamera(BuildContext context) async {
    await Permission.camera.request();
    if (!context.mounted) return;
    CustomSnackbar.showInfoKey(
      context: context,
      messageKey: 'profile.cameraIntegrationRequired',
    );
  }

  List<TextEditingController> get _controllers => [
        _nameController,
        _headlineController,
        _emailController,
        _locationController,
        _bioController,
      ];

  void _storeSavedSnapshot() {
    _savedName = _nameController.text;
    _savedHeadline = _headlineController.text;
    _savedEmail = _emailController.text;
    _savedLocation = _locationController.text;
    _savedBio = _bioController.text;
    _savedAvatarPath = widget.profile.avatarAsset;
    _hasChanges = false;
  }

  void _refreshChanges() {
    final hasChanges = _nameController.text != _savedName ||
        _headlineController.text != _savedHeadline ||
        _emailController.text != _savedEmail ||
        _locationController.text != _savedLocation ||
        _bioController.text != _savedBio ||
        widget.profile.avatarAsset != _savedAvatarPath;

    if (hasChanges == _hasChanges || !mounted) return;
    setState(() => _hasChanges = hasChanges);
  }
}
