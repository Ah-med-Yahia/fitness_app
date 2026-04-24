import 'package:fitness_app/features/auth/presentation/view_model/state/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/features/auth/presentation/view_model/login_cubit.dart';


import 'login_screen_test.mocks.dart';

@GenerateMocks([LoginCubit])
void main() {
  late MockLoginCubit mockCubit;

  setUp(() {
    mockCubit = MockLoginCubit();
    when(mockCubit.state).thenReturn(const LoginState.initial());
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildSubject() => MaterialApp(
    // ✅ Required so EasyLoading doesn't throw in tests
    builder: EasyLoading.init(),
    home: BlocProvider<LoginCubit>.value(
      value: mockCubit,
      child: const LoginScreen(),
    ),
  );

  group('LoginScreen widget tests', () {
    testWidgets('renders all key UI elements', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.text('Login'), findsWidgets);
      expect(find.text('Hey There'), findsOneWidget);
      expect(find.text('WELCOME BACK'), findsOneWidget);
      expect(find.text('Forget Password ?'), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);
      expect(find.text('Or'), findsOneWidget);
    });

    testWidgets('shows email validation error on empty submit', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();
      expect(find.text('Email is required'), findsOneWidget);
    });

    testWidgets('shows password validation error on empty submit', (
      tester,
    ) async {
      await tester.pumpWidget(buildSubject());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('toggles password visibility on eye icon tap', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pump();
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    testWidgets('calls login with correct credentials on valid submit', (
      tester,
    ) async {
      when(
        mockCubit.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
      ).thenAnswer((_) async {});

      await tester.pumpWidget(buildSubject());
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'test@test.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Password@1',
      );
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();

      verify(
        mockCubit.login(email: 'test@test.com', password: 'Password@1'),
      ).called(1);
    });

    testWidgets('button is disabled when state is loading', (tester) async {
      when(mockCubit.state).thenReturn(const LoginState.loading());
      when(
        mockCubit.stream,
      ).thenAnswer((_) => Stream.value(const LoginState.loading()));

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      final button = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Login'),
      );
      expect(button.onPressed, isNull);
    });
  });
}
