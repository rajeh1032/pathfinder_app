import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
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
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
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
                          'Welcome Back',
                          style:
                              AppTextStyles.headlineLarge(AppColors.lightText),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Continue your journey to mastery with AI\nguidance.',
                          style: AppTextStyles.bodyMedium(
                              AppColors.lightTextMuted),
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
                            label: 'Sign In →',
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
                              "Don't have an account? ",
                              style: AppTextStyles.bodyMedium(
                                  AppColors.lightTextMuted),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, AppRoutes.register),
                              child: Text(
                                'Create Account',
                                style:
                                    AppTextStyles.bodyMedium(AppColors.primary)
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
