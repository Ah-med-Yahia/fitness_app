import 'dart:ui';

import 'package:fitness_app/app/core/constants/auth_constants.dart';
import 'package:fitness_app/app/core/constants/signup_constants.dart';
import 'package:fitness_app/app/core/theme/app_colors.dart';
import 'package:fitness_app/app/core/validators/app_validators.dart';
import 'package:fitness_app/app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:fitness_app/app/features/auth/presentation/widgets/register/register_footer.dart';
import 'package:fitness_app/app/features/auth/presentation/widgets/social_login_button.dart';
import 'package:flutter/material.dart';

class RegisterFormCard extends StatelessWidget {
  const RegisterFormCard({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePasswordVisibility,
    required this.onRegisterPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onRegisterPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 34.6, sigmaY: 34.6),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          decoration: BoxDecoration(
            color: AppColors.authGlassCard,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  SignUpConstants.registerTitle,
                  style: TextStyle(
                    fontFamily: 'BaloThambi2',
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hint: SignUpConstants.firstName,
                  prefixIcon: Icons.person_outline,
                  controller: firstNameController,
                  validator: AppValidators.validateRequired,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hint: SignUpConstants.lastName,
                  prefixIcon: Icons.person_outline,
                  controller: lastNameController,
                  validator: AppValidators.validateRequired,
                ),
                const SizedBox(height: 8),
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
                  validator: AppValidators.validatePassword,
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
                const SizedBox(height: 16),
                const RegisterOrDivider(label: AuthTextConstants.or),
                const SizedBox(height: 12),
                const _SocialButtonsRow(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onRegisterPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      SignUpConstants.registerTitle,
                      style: TextStyle(
                        fontFamily: 'BaloThambi2',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
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

class _SocialButtonsRow extends StatelessWidget {
  const _SocialButtonsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
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
        SocialLoginButton(
          icon: Icons.apple,
          iconSize: 18,
          onTap: () {},
        ),
      ],
    );
  }
}

