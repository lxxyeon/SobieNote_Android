import 'package:json_annotation/json_annotation.dart';

part 'sign_up_form.g.dart';

@JsonSerializable()
class SignUpForm {
  final String name;
  final String email;
  final String password;
  final String? schoolName;
  final int? age;
  final String? studentName;

  SignUpForm({
    required this.name,
    required this.email,
    required this.password,
    this.schoolName,
    this.age,
    this.studentName,
  });

  factory SignUpForm.fromJson(Map<String, dynamic> json) =>
      _$SignUpFormFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpFormToJson(this);
}
