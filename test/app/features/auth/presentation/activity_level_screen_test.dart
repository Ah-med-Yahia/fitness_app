import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_cubit.dart';
import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_form_data.dart';
import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/app/features/auth/presentation/screens/activity_level_screen.dart';
import 'activity_level_screen_test.mocks.dart';

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
      child: const ActivityLevelScreen(),
    ),
  );

  group('ActivityLevelScreen widget tests', () {
    testWidgets('renders all 5 activity options', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.text('Rookie'), findsOneWidget);
      expect(find.text('Beginner'), findsOneWidget);
      expect(find.text('Intermediate'), findsOneWidget);
      expect(find.text('Advance'), findsOneWidget);
      expect(find.text('True Beast'), findsOneWidget);
    });

    testWidgets('Done button is disabled when no option selected', (
      tester,
    ) async {
      await tester.pumpWidget(buildSubject());
      final button = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Done'),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('Done button enables after selecting option', (tester) async {
      when(mockCubit.updateFormData(any)).thenReturn(null);
      await tester.pumpWidget(buildSubject());
      await tester.tap(find.text('Rookie'));
      await tester.pump();
      final button = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Done'),
      );
      expect(button.onPressed, isNotNull);
    });

    testWidgets('renders step indicator 6/6', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.text('6/6'), findsOneWidget);
    });
  });
}
