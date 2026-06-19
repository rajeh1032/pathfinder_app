import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_button.dart';
import '../cubit/reset_password_cubit.dart';
import '../cubit/reset_password_state.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    for (final controller in _controllers) {
      controller.addListener(_refreshChanges);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.removeListener(_refreshChanges);
    }
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          clearFields();
        }
      },
      builder: (context, state) {
        final submitting = state is ResetPasswordSubmitting;

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            _PasswordField(
              controller: _currentController,
              labelKey: 'profile.currentPassword',
            ),
            _PasswordField(
              controller: _newController,
              labelKey: 'profile.newPassword',
            ),
            _PasswordField(
              controller: _confirmController,
              labelKey: 'profile.confirmPassword',
            ),
            const SizedBox(height: AppSpacing.lg),
            CustomButton(
              labelKey: 'profile.updatePassword',
              isLoading: submitting,
              onPressed: submitting || !_hasChanges ? null : _submit,
            ),
          ],
        );
      },
    );
  }

  void _submit() {
    context.read<ResetPasswordCubit>().submit(
          currentPassword: _currentController.text,
          newPassword: _newController.text,
          confirmPassword: _confirmController.text,
        );
  }

  List<TextEditingController> get _controllers => [
        _currentController,
        _newController,
        _confirmController,
      ];

  void _refreshChanges() {
    final hasChanges = _controllers.any(
      (controller) => controller.text.isNotEmpty,
    );
    if (hasChanges == _hasChanges || !mounted) return;
    setState(() => _hasChanges = hasChanges);
  }

  void clearFields() {
    for (final controller in _controllers) {
      controller.clear();
    }
    _refreshChanges();
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.labelKey,
  });

  final TextEditingController controller;
  final String labelKey;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: context.tr(labelKey),
          fillColor: colors.onPrimary,
        ),
      ),
    );
  }
}
