import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../cubit/login_cubit.dart';
import '../widgets/google_sign_in_button.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';
import '../widgets/login_or_divider.dart';
import '../widgets/trusted_intelligence_badge.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            Navigator.pushReplacementNamed(context, AppRoutes.root);
          }
          if (state.status == LoginStatus.failure &&
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
                        const LoginHeader(),
                        SizedBox(height: 28.h),
                        Text(
                          'auth.loginTitle'.tr(),
                          style: AppTextStyles.headlineLarge(
                              colorScheme.onSurface),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'auth.loginSubtitle'.tr(),
                          style: AppTextStyles.bodyMedium(
                              colorScheme.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 28.h),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) => GoogleSignInButton(
                            isLoading: state.isLoading,
                            onPressed: () =>
                                context.read<LoginCubit>().loginWithGoogle(),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        const LoginOrDivider(),
                        SizedBox(height: 20.h),
                        LoginForm(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                        SizedBox(height: 24.h),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) => AppButton(
                            label: 'auth.login'.tr(),
                            isLoading: state.isLoading,
                            onPressed: state.canSubmit
                                ? () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      context
                                          .read<LoginCubit>()
                                          .loginWithEmail();
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
                              "auth.dontHaveAccount".tr(),
                              style: AppTextStyles.bodyMedium(
                                  colorScheme.onSurfaceVariant),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, AppRoutes.register),
                              child: Text(
                                'auth.createAccount'.tr(),
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
