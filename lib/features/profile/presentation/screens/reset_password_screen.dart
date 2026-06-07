import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../../data/repositories/demo_profile_repository.dart';
import '../../domain/use_cases/reset_profile_password_use_case.dart';
import '../cubit/reset_password_cubit.dart';
import '../cubit/reset_password_state.dart';
import '../widgets/reset_password_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        const repository = DemoProfileRepository();
        return ResetPasswordCubit(
          resetPasswordUseCase: const ResetProfilePasswordUseCase(repository),
        );
      },
      child: const _ResetPasswordView(),
    );
  }
}

class _ResetPasswordView extends StatelessWidget {
  const _ResetPasswordView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          CustomSnackbar.showSuccessKey(
            context: context,
            messageKey: 'profile.passwordUpdated',
          );
        }
        if (state is ResetPasswordError) {
          CustomSnackbar.showErrorKey(
            context: context,
            messageKey: state.messageKey,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const AppGradientBackButton(),
          title: Text('profile.resetPassword'.tr()),
        ),
        body: const SafeArea(child: ResetPasswordForm()),
      ),
    );
  }
}
