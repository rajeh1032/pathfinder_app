import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../../data/repositories/demo_profile_repository.dart';
import '../../domain/use_cases/get_profile_use_case.dart';
import '../../domain/use_cases/update_profile_use_case.dart';
import '../cubit/edit_profile_cubit.dart';
import '../cubit/edit_profile_state.dart';
import '../widgets/edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        const repository = DemoProfileRepository();
        return EditProfileCubit(
          getProfileUseCase: const GetProfileUseCase(repository),
          updateProfileUseCase: const UpdateProfileUseCase(repository),
        )..loadProfile();
      },
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
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSaved) {
          _hasSavedChanges = true;
          CustomSnackbar.showSuccessKey(
            context: context,
            messageKey: 'profile.updateSuccess',
          );
        }
        if (state is EditProfileError) {
          CustomSnackbar.showErrorKey(
            context: context,
            messageKey: state.messageKey,
          );
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) _close();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: AppGradientBackButton(onPressed: _close),
            title: Text('profile.editProfile'.tr()),
          ),
          body: SafeArea(
            child: BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) {
                if (state is EditProfileReady) {
                  return EditProfileForm(
                    profile: state.profile,
                    isSubmitting: state.isSubmitting,
                  );
                }

                if (state is EditProfileError) {
                  return AppErrorView(
                    message: state.messageKey.tr(),
                    onRetry: context.read<EditProfileCubit>().loadProfile,
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }

  void _close() {
    Navigator.of(context).pop(_hasSavedChanges);
  }
}
