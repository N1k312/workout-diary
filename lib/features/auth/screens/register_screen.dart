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
import '../../../core/widgets/buttons/app_text_button.dart';
import '../../../core/widgets/buttons/google_button.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/dividers/divider_with_text.dart';
import '../../../core/widgets/inputs/text_input.dart';
import '../../../data/models/app_user.dart';
import '../providers/auth_providers.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String? _emailError;
  String? _passwordError;
  String? _confirmError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    final emailErr = Validators.email(_emailController.text);
    final passwordErr = Validators.password(_passwordController.text);
    final confirmErr = Validators.confirmPassword(
      _confirmPasswordController.text,
      _passwordController.text,
    );
    setState(() {
      _emailError = emailErr;
      _passwordError = passwordErr;
      _confirmError = confirmErr;
    });
    return emailErr == null && passwordErr == null && confirmErr == null;
  }

  Future<void> _handleRegister() async {
    if (!_validateInputs()) return;
    await ref.read(authNotifierProvider.notifier).registerWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
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
            vertical: AppSpacing.base,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(AppRoutes.login);
                    }
                  },
                  child: const Icon(
                    LucideIcons.arrowLeft,
                    size: 20,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.base),
              Text('Create account', style: AppTextStyles.headlineLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Start tracking your workouts',
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
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
              if (_passwordError == null) ...[
                const SizedBox(height: 4),
                Text(
                  'Min 6 characters',
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textTertiary),
                ),
              ],
              const SizedBox(height: AppSpacing.sm),
              AppTextInput(
                label: 'Confirm password',
                controller: _confirmPasswordController,
                isPassword: _obscureConfirm,
                errorText: _confirmError,
                hintText: '••••••••',
                trailingIcon:
                    _obscureConfirm ? LucideIcons.eye : LucideIcons.eyeOff,
                onTrailingTap: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              const SizedBox(height: AppSpacing.base),
              PrimaryButton(
                label: 'Sign up',
                onPressed: isLoading ? null : _handleRegister,
                isLoading: isLoading,
              ),
              const SizedBox(height: AppSpacing.base),
              const DividerWithText(text: 'or'),
              const SizedBox(height: AppSpacing.base),
              GoogleButton(
                label: 'Sign up with Google',
                onPressed: null,
              ),
              const SizedBox(height: AppSpacing.lg),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTextStyles.bodyMedium,
                    ),
                    AppTextButton(
                      label: 'Log in',
                      onPressed: () => context.go(AppRoutes.login),
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
