import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../domain/entities/user_profile.dart';
import '../cubit/my_profile_cubit.dart';
import 'edit_profile_fields.dart';

/// Edit form backed by the live Profiles API (`PATCH /me`). Only fields the
/// endpoint accepts are editable; `name` is read-only (managed by auth).
class ApiEditProfileForm extends StatefulWidget {
  const ApiEditProfileForm({
    required this.profile,
    required this.isSubmitting,
    required this.onSaved,
    super.key,
  });

  final UserProfile profile;
  final bool isSubmitting;
  final VoidCallback onSaved;

  @override
  State<ApiEditProfileForm> createState() => _ApiEditProfileFormState();
}

class _ApiEditProfileFormState extends State<ApiEditProfileForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _headlineController;
  late final TextEditingController _locationController;
  late final TextEditingController _universityController;
  late final TextEditingController _majorController;
  late final TextEditingController _bioController;

  late String _savedHeadline;
  late String _savedLocation;
  late String _savedUniversity;
  late String _savedMajor;
  late String _savedBio;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _nameController = TextEditingController(text: p.name ?? '');
    _headlineController = TextEditingController(text: p.headline ?? '');
    _locationController = TextEditingController(text: p.location ?? '');
    _universityController = TextEditingController(text: p.university ?? '');
    _majorController = TextEditingController(text: p.major ?? '');
    _bioController = TextEditingController(text: p.bio ?? '');
    _storeSnapshot();
    for (final c in _editableControllers) {
      c.addListener(_refreshChanges);
    }
  }

  @override
  void didUpdateWidget(ApiEditProfileForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-baseline after a successful save (submitting -> not submitting).
    if (oldWidget.isSubmitting && !widget.isSubmitting) {
      _storeSnapshot();
      _refreshChanges();
    }
  }

  @override
  void dispose() {
    for (final c in _editableControllers) {
      c.removeListener(_refreshChanges);
    }
    _nameController.dispose();
    _headlineController.dispose();
    _locationController.dispose();
    _universityController.dispose();
    _majorController.dispose();
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
        Center(child: _Avatar(avatarUrl: widget.profile.avatarUrl)),
        const SizedBox(height: AppSpacing.lg),
        EditProfileField(
          controller: _nameController,
          labelKey: 'profile.editName',
          enabled: false,
        ),
        EditProfileField(
          controller: _headlineController,
          labelKey: 'profile.editHeadline',
        ),
        EditProfileField(
          controller: _locationController,
          labelKey: 'profile.editLocation',
        ),
        EditProfileField(
          controller: _universityController,
          labelKey: 'profile.editUniversity',
        ),
        EditProfileField(
          controller: _majorController,
          labelKey: 'profile.editMajor',
        ),
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

  Future<void> _submit(BuildContext context) async {
    final cubit = context.read<MyProfileCubit>();
    final changes = _buildChanges();
    if (changes.isEmpty) return;

    final ok = await cubit.updateProfile(changes);
    if (!context.mounted) return;

    if (ok) {
      widget.onSaved();
      CustomSnackbar.showSuccessKey(
        context: context,
        messageKey: 'profile.updateSuccess',
      );
    } else {
      final message = cubit.state.errorMessage;
      if (message != null && message.isNotEmpty) {
        CustomSnackbar.showError(context: context, message: message);
      } else {
        CustomSnackbar.showErrorKey(
          context: context,
          messageKey: 'common.error',
        );
      }
    }
  }

  /// Builds a snake_case payload of only the fields that changed.
  Map<String, dynamic> _buildChanges() {
    final changes = <String, dynamic>{};
    void put(String key, String current, String saved) {
      if (current.trim() != saved.trim()) changes[key] = current.trim();
    }

    put('headline', _headlineController.text, _savedHeadline);
    put('location', _locationController.text, _savedLocation);
    put('university', _universityController.text, _savedUniversity);
    put('major', _majorController.text, _savedMajor);
    put('bio', _bioController.text, _savedBio);
    return changes;
  }

  List<TextEditingController> get _editableControllers => [
        _headlineController,
        _locationController,
        _universityController,
        _majorController,
        _bioController,
      ];

  void _storeSnapshot() {
    _savedHeadline = _headlineController.text;
    _savedLocation = _locationController.text;
    _savedUniversity = _universityController.text;
    _savedMajor = _majorController.text;
    _savedBio = _bioController.text;
    _hasChanges = false;
  }

  void _refreshChanges() {
    final hasChanges = _buildChanges().isNotEmpty;
    if (hasChanges == _hasChanges || !mounted) return;
    setState(() => _hasChanges = hasChanges);
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasUrl = avatarUrl != null && avatarUrl!.trim().isNotEmpty;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        shape: BoxShape.circle,
        border: Border.all(color: colors.surface, width: 4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: CircleAvatar(
          radius: 56,
          backgroundColor: colors.primaryContainer,
          foregroundColor: colors.primary,
          backgroundImage: hasUrl ? NetworkImage(avatarUrl!.trim()) : null,
          child: hasUrl
              ? null
              : Icon(Icons.person_outline, size: 48, color: colors.primary),
        ),
      ),
    );
  }
}
