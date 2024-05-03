import 'package:bank/data/models/form_status.dart';
import 'package:bank/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String errorMessage;
  final String statusMessage;
  final FormStatus formStatus;
  final UserModel userModel;

  const AuthState({
    required this.statusMessage,
    required this.formStatus,
    required this.errorMessage,
    required this.userModel,
  });

  AuthState copyWith({
    String? errorMessage,
    String? statusMessage,
    FormStatus? formStatus,
    UserModel? userModel,
  }) {
    return AuthState(
      statusMessage: statusMessage ?? this.statusMessage,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object?> get props => [
    statusMessage,
    errorMessage,
    formStatus,
    userModel,
  ];
}
