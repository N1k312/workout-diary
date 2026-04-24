import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/utils/snackbar_helper.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/buttons/app_text_button.dart';
import '../../../core/widgets/buttons/google_button.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/dividers/divider_with_text.dart';
import '../../../core/widgets/inputs/text_input.dart';
import '../../../data/models/app_user.dart';
import '../providers/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    final emailErr = Validators.email(_emailController.text);
    final passwordErr = Validators.password(_passwordController.text);
    setState(() {
      _emailError = emailErr;
      _passwordError = passwordErr;
    });
    return emailErr == null && passwordErr == null;
  }

  Future<void> _handleLogin() async {
    if (!_validateInputs()) return;
    await ref.read(authNotifierProvider.notifier).signInWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  Future<void> _handleForgotPassword() async {
    final emailErr = Validators.email(_emailController.text);
    setState(() => _emailError = emailErr);
    if (emailErr != null) return;

    await ref.read(authNotifierProvider.notifier).sendPasswordResetEmail(
          email: _emailController.text.trim(),
        );
    final authState = ref.read(authNotifierProvider);
    if (!authState.hasError && mounted) {
      showSuccessSnackBar(
        context,
        'Password reset email sent to ${_emailController.text.trim()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(authNotifierProvider, (prev, next) {
      next.whenOrNull(
        error: (error, _) => showErrorSnackBar(context, error.toString()),
      );
    });

    ref.listen<AsyncValue<AppUser?>>(authStateProvider, (prev, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null && mounted) context.go(AppRoutes.home);
        },
      );
    });

    final isLoading = ref.watch(authNotifierProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: AppLogo(size: 32)),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Welcome back',
                style: AppTextStyles.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Log in to continue',
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              AppTextInput(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                errorText: _emailError,
                hintText: 'you@example.com',
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextInput(
                label: 'Password',
                controller: _passwordController,
                isPassword: _obscurePassword,
                errorText: _passwordError,
                hintText: '••••••••',
                trailingIcon:
                    _obscurePassword ? LucideIcons.eye : LucideIcons.eyeOff,
                onTrailingTap: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: AppTextButton(
                  label: 'Forgot password?',
                  onPressed: _handleForgotPassword,
                ),
              ),
              const SizedBox(height: AppSpacing.base),
              PrimaryButton(
                label: 'Log in',
                onPressed: isLoading ? null : _handleLogin,
                isLoading: isLoading,
              ),
              const SizedBox(height: AppSpacing.base),
              const DividerWithText(text: 'or'),
              const SizedBox(height: AppSpacing.base),
              GoogleButton(
                label: 'Log in with Google',
                onPressed: null,
              ),
              const SizedBox(height: AppSpacing.xl),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppTextStyles.bodyMedium,
                    ),
                    AppTextButton(
                      label: 'Sign up',
                      onPressed: () => context.go(AppRoutes.register),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
