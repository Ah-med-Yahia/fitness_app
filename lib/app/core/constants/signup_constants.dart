abstract class SignUpConstants {
  SignUpConstants._();

  // ── Register Screen ──────────────────────────
  static const String heyThere = 'Hey There';
  static const String createAccount = 'CREATE AN ACCOUNT';
  static const String registerTitle = 'Register';
  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';
  static const String alreadyHave = 'Already Have An Account ? ';
  static const String loginLink = 'Login';

  // ── Onboarding Labels ─────────────────────────
  static const String genderStepLabel = '1/6';
  static const String ageStepLabel = '2/6';
  static const String weightStepLabel = '3/6';
  static const String heightStepLabel = '4/6';
  static const String goalStepLabel = '5/6';
  static const String activityStepLabel = '6/6';

  // ── Gender Options ───────────────────────────
  static const String maleLabel = 'Male';
  static const String femaleLabel = 'Female';
  static const String maleSymbol = '♂';
  static const String femaleSymbol = '♀';

  // ── Titles ────────────────────────
  static const String genderTitle = 'TELL US ABOUT YOURSELF!';
  static const String genderSubtitle = 'We Need To Know Your Gender';
  static const String ageTitle = 'HOW OLD ARE YOU ?';
  static const String weightTitle = 'WHAT IS YOUR WEIGHT ?';
  static const String heightTitle = 'WHAT IS YOUR HEIGHT ?';
  static const String goalTitle = 'WHAT IS YOUR GOAL ?';
  static const String activityTitle =
      'YOUR REGULAR PHYSICAL\n ACTIVITY LEVEL ?';
  static const String onboardingSub =
      'This Helps Us Create Your Personalized Plan';

  // ── Options ──────────────────────────────────
  static const List<String> goalOptions = [
    'Gain Weight',
    'Lose Weight',
    'Get Fitter',
    'Gain More Flexibility',
    'Learn The Basic',
  ];

  static const List<String> activityOptions = [
    'Rookie',
    'Beginner',
    'Intermediate',
    'Advance',
    'True Beast',
  ];

  static const List<String> activityApiValues = [
    'level1',
    'level2',
    'level3',
    'level4',
    'level5',
  ];

  // ── Units ───────────────────────────────────
  static const String yearUnit = 'Year';
  static const String kgUnit = 'Kg';
  static const String cmUnit = 'CM';

  // ── Buttons ─────────────────────────────────
  static const String doneLabel = 'Done';
}
