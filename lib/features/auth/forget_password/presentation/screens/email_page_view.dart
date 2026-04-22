import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/presentation/widgets/blurred_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/validators/app_validators.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_intents.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailPageView extends StatefulWidget {
  const EmailPageView({super.key});

  @override
  State<EmailPageView> createState() => _EmailPageViewState();
}

class _EmailPageViewState extends State<EmailPageView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  late TextTheme _textTheme;
  late Size _screenSize;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textTheme = Theme.of(context).textTheme;
    _screenSize = MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTextConstants.enterYourEmail,
            style: _textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppTextConstants.forgetPassword,
            style: _textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: _screenSize.height * .08),
          BlurredCard(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        style: _textTheme.bodyMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          context.read<ForgetPasswordCubit>().doIntent(
                            EmailChangedIntent(email: value.toLowerCase()),
                          );
                        },
                        cursorColor: AppColors.white,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined, size: 25),
                          hintText: AppTextConstants.email,
                        ),
                        validator: (value) =>
                            AppValidators.validateEmail(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onTapOutside: (_) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: _screenSize.height * .06,
                        child:
                            BlocBuilder<
                              ForgetPasswordCubit,
                              ForgetPasswordStates
                            >(
                              buildWhen: (previous, current) =>
                                  previous.isSendOtpLoading !=
                                      current.isSendOtpLoading ||
                                  previous.isEmailValid != current.isEmailValid,
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: state.isEmailValid
                                      ? () {
                                          if (state.isSendOtpLoading) return;
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<ForgetPasswordCubit>()
                                                .doIntent(SendOtpIntent());
                                          }
                                        }
                                      : null,
                                  child: state.isSendOtpLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: AppColors.white,
                                          ),
                                        )
                                      : Text(
                                          AppTextConstants.sendOtp,
                                          style: _textTheme.bodyMedium
                                              ?.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                );
                              },
                            ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
