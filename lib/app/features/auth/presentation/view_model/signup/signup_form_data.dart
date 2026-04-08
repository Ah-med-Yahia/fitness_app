class SignUpFormData {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String gender;
  final int age;
  final int weight;
  final int height;
  final String goal;
  final String activityLevel;

  const SignUpFormData({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.rePassword = '',
    this.gender = 'male',
    this.age = 25,
    this.weight = 70,
    this.height = 170,
    this.goal = '',
    this.activityLevel = '',
  });

  SignUpFormData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? gender,
    int? age,
    int? weight,
    int? height,
    String? goal,
    String? activityLevel,
  }) => SignUpFormData(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    password: password ?? this.password,
    rePassword: rePassword ?? this.rePassword,
    gender: gender ?? this.gender,
    age: age ?? this.age,
    weight: weight ?? this.weight,
    height: height ?? this.height,
    goal: goal ?? this.goal,
    activityLevel: activityLevel ?? this.activityLevel,
  );
}
