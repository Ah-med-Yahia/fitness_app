import 'package:fitness_app/app/core/constants/auth_constants.dart';
import 'package:fitness_app/app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/app/core/theme/app_colors.dart';
import 'package:fitness_app/app/core/validators/app_validators.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'custom_text_field.dart';
import 'social_login_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePasswordVisibility,
    required this.isLoading,
    required this.onLoginPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePasswordVisibility;
  final bool isLoading;
  final VoidCallback onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text(
            AuthTextConstants.login,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: AuthTextConstants.email,
            prefixIcon: Icons.email_outlined,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.validateEmail,
          ),
          const SizedBox(height: 8),
          CustomTextField(
            hint: AuthTextConstants.password,
            prefixIcon: Icons.lock_outline,
            controller: passwordController,
            obscureText: obscurePassword,
            validator: AppValidators.validateLoginPassword,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.white,
                size: 20,
              ),
              onPressed: onTogglePasswordVisibility,
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => context.push(AppRoutesConstants.forgotPasswordRoute),
              child: Text(
                AuthTextConstants.forgotPassword,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(child: Divider(color: AppColors.lightDivider)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  AuthTextConstants.or,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.lightDivider,
                  ),
                ),
              ),
              const Expanded(child: Divider(color: AppColors.lightDivider)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialLoginButton(
                icon: Icons.facebook,
                iconSize: 16,
                onTap: () {},
              ),
              const SizedBox(width: 16),
              SocialLoginButton(
                icon: Icons.g_mobiledata,
                iconSize: 16,
                onTap: () {},
              ),
              const SizedBox(width: 16),
              SocialLoginButton(icon: Icons.apple, iconSize: 18, onTap: () {}),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : onLoginPressed,
              child: const Text(AuthTextConstants.login),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AuthTextConstants.noAccount,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: () => context.push(AppRoutesConstants.signUpRoute),
                child: Text(
                  AuthTextConstants.register,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.accentOrange,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.accentOrange,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
