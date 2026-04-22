import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/presentation/widgets/blurred_card.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_intents.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_state.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/widgets/passwords_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTextConstants.makeSureIts8CharactersOrMore,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppTextConstants.createNewPassword,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          BlurredCard(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  PasswordsField(
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child:
                        BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
                          buildWhen: (previous, current) =>
                              previous.isFormValid != current.isFormValid,
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state.isFormValid
                                  ? () {
                                      context
                                          .read<ForgetPasswordCubit>()
                                          .doIntent(ResetPasswordIntent());
                                    }
                                  : null,
                              child: Text(
                                AppTextConstants.done,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
