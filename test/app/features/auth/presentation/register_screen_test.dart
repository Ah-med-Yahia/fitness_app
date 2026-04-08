import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_cubit.dart';
import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_form_data.dart';
import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/app/features/auth/presentation/screens/register_screen.dart';
import 'package:go_router/go_router.dart';
import 'register_screen_test.mocks.dart';

@GenerateMocks([SignUpCubit])
void main() {
  late MockSignUpCubit mockCubit;

  setUp(() {
    mockCubit = MockSignUpCubit();
    when(mockCubit.state).thenReturn(const SignUpState.initial());
    when(mockCubit.stream).thenAnswer((_) => const Stream<SignUpState>.empty());
    when(mockCubit.formData).thenReturn(const SignUpFormData());
  });

  Widget buildSubject() => MaterialApp.router(
    builder: EasyLoading.init(),
    routerConfig: GoRouter(
      initialLocation: AppRoutesConstants.signUpRoute,
      routes: [
        GoRoute(
          path: AppRoutesConstants.signUpRoute,
          builder: (context, state) => BlocProvider<SignUpCubit>.value(
            value: mockCubit,
            child: const RegisterScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutesConstants.genderRoute,
          builder: (context, state) => const SizedBox.shrink(),
        ),
      ],
    ),
  );

  /// Register layout is taller than the default 600px test viewport; widen the
  /// surface so the bottom [ElevatedButton] is hittable.
  Future<void> pumpRegisterScreen(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(buildSubject());
  }

  group('RegisterScreen widget tests', () {
    testWidgets('renders all key UI elements', (tester) async {
      await pumpRegisterScreen(tester);
      expect(find.text('Register'), findsWidgets);
      expect(find.text('Hey There'), findsOneWidget);
      expect(find.text('CREATE AN ACCOUNT'), findsOneWidget);
      expect(find.text('Already Have An Account ? '), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('shows validation errors on empty submit', (tester) async {
      await pumpRegisterScreen(tester);
      await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
      await tester.pump();
      expect(find.text('This field is required'), findsWidgets);
    });

    testWidgets('shows email error on invalid email', (tester) async {
      await pumpRegisterScreen(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'notanemail',
      );
      await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
      await tester.pump();
      expect(find.text('Enter a valid email address'), findsOneWidget);
    });

    testWidgets('toggles password visibility', (tester) async {
      await pumpRegisterScreen(tester);
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pump();
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    testWidgets('calls updateFormData on valid submit', (tester) async {
      when(mockCubit.updateFormData(any)).thenReturn(null);
      await pumpRegisterScreen(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'First Name'),
        'Ahmed',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Last Name'),
        'Yousef',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'test@test.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Password@1',
      );
      await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
      await tester.pump();
      verify(mockCubit.updateFormData(any)).called(1);
    });
  });
}
