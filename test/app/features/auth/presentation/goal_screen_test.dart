import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_cubit.dart';
import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_form_data.dart';
import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/app/features/auth/presentation/screens/goal_screen.dart';

import 'goal_screen_test.mocks.dart';

@GenerateMocks([SignUpCubit])
void main() {
  late MockSignUpCubit mockCubit;

  setUp(() {
    mockCubit = MockSignUpCubit();
    when(mockCubit.state).thenReturn(const SignUpState.initial());
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.formData).thenReturn(const SignUpFormData());
  });

  Widget buildSubject() => MaterialApp(
    builder: EasyLoading.init(),
    home: BlocProvider<SignUpCubit>.value(
      value: mockCubit,
      child: const GoalScreen(),
    ),
  );

  group('GoalScreen widget tests', () {
    testWidgets('renders all 5 goal options', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.text('Gain Weight'), findsOneWidget);
      expect(find.text('Lose Weight'), findsOneWidget);
      expect(find.text('Get Fitter'), findsOneWidget);
      expect(find.text('Gain More Flexibility'), findsOneWidget);
      expect(find.text('Learn The Basic'), findsOneWidget);
    });

    testWidgets('Next button is disabled when no option selected', (
      tester,
    ) async {
      await tester.pumpWidget(buildSubject());
      final button = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Next'),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('Next button enables after selecting an option', (
      tester,
    ) async {
      await tester.pumpWidget(buildSubject());
      await tester.tap(find.text('Gain Weight'));
      await tester.pump();
      final button = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Next'),
      );
      expect(button.onPressed, isNotNull);
    });

    testWidgets('renders step indicator 5/6', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.text('5/6'), findsOneWidget);
    });
  });
}
