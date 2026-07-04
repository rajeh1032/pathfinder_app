import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../cubit/my_profile_cubit.dart';
import '../cubit/my_profile_state.dart';
import '../widgets/api_edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyProfileCubit>(
      create: (_) => getIt<MyProfileCubit>()..load(),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  bool _hasSavedChanges = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _close();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: AppGradientBackButton(onPressed: _close),
          title: Text(context.tr('profile.editProfile')),
        ),
        body: SafeArea(
          child: BlocBuilder<MyProfileCubit, MyProfileState>(
            builder: (context, state) {
              if (state.isSuccess && state.profile != null) {
                return ApiEditProfileForm(
                  profile: state.profile!,
                  isSubmitting: state.isSaving,
                  onSaved: () => _hasSavedChanges = true,
                );
              }

              if (state.isFailure) {
                return AppErrorView(
                  message: state.errorMessage ?? context.tr('common.error'),
                  onRetry: context.read<MyProfileCubit>().load,
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  void _close() {
    Navigator.of(context).pop(_hasSavedChanges);
  }
}
