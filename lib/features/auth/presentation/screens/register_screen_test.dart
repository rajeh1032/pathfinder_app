import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pathfinder_app/features/auth/presentation/cubit/register_state.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../cubit/register_cubit.dart';
import '../widgets/google_sign_in_button.dart';
import '../widgets/register_form.dart';
import '../widgets/register_header.dart';
import '../widgets/login_or_divider.dart';
import '../widgets/trusted_intelligence_badge.dart';

class RegisterScreenTest extends StatefulWidget {
  const RegisterScreenTest({super.key});

  @override
  State<RegisterScreenTest> createState() => _RegisterScreenTestState();
}

class _RegisterScreenTestState extends State<RegisterScreenTest> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.success) {
            Navigator.pushReplacementNamed(context, AppRoutes.root);
          }
          if (state.status == RegisterStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: colorScheme.error,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: colorScheme.surface,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8.h),
                        const RegisterHeader(),
                        SizedBox(height: 28.h),
                        Text(
                          'auth.registerTitle'.tr(),
                          style: AppTextStyles.headlineLarge(
                              colorScheme.onSurface),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'auth.registerSubtitle'.tr(),
                          style: AppTextStyles.bodyMedium(
                              colorScheme.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 28.h),
                        BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) => GoogleSignInButton(
                            isLoading: state.isLoading,
                            onPressed: () =>
                                context.read<RegisterCubit>().registerWithGoogle(),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        const LoginOrDivider(),
                        SizedBox(height: 20.h),
                        RegisterForm(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          confirmPasswordController: _confirmPasswordController,
                        ),
                        SizedBox(height: 24.h),
                        BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) => AppButton(
                            label: 'auth.register'.tr(),
                            isLoading: state.isLoading,
                            onPressed: state.canSubmit
                                ? () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      context
                                          .read<RegisterCubit>()
                                          .register(email: '', password: '');
                                    }
                                  }
                                : null,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "auth.haveAccount".tr(),
                              style: AppTextStyles.bodyMedium(
                                  colorScheme.onSurfaceVariant),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, AppRoutes.login),
                              child: Text(
                                'auth.login'.tr(),
                                style: AppTextStyles.bodyMedium(
                                        colorScheme.primary)
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32.h),
                        const TrustedIntelligenceBadge(),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
