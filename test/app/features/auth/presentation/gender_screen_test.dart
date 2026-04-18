import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_cubit.dart';
import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_form_data.dart';
import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/app/features/auth/presentation/screens/gender_screen.dart';
import 'gender_screen_test.mocks.dart';

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
      child: const GenderScreen(),
    ),
  );

  group('GenderScreen widget tests', () {
    testWidgets('renders male and female buttons', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.text('Male'), findsOneWidget);
      expect(find.text('Female'), findsOneWidget);
    });

    testWidgets('next button disabled until gender picked', (tester) async {
      await tester.pumpWidget(buildSubject());
      final button = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Next'),
      );
      expect(button.onPressed, isNull);

      await tester.tap(find.text('Male'));
      await tester.pump();

      final updatedButton = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Next'),
      );
      expect(updatedButton.onPressed, isNotNull);
    });

    testWidgets('renders step indicator 1/6', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.text('1/6'), findsOneWidget);
    });

    testWidgets('renders Next button', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.widgetWithText(ElevatedButton, 'Next'), findsOneWidget);
    });
  });
}
