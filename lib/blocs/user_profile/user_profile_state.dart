import 'package:equatable/equatable.dart';

import '../../data/models/form_status.dart';
import '../../data/models/user_model.dart';

class UserProfileState extends Equatable {
  final UserModel userModel;
  final FormStatus formStatus;
  final String errorMessage;
  final String statusMessage;

  const UserProfileState({
    required this.formStatus,
    required this.userModel,
    required this.errorMessage,
    required this.statusMessage,
  });

  UserProfileState copyWith({
    UserModel? userModel,
    FormStatus? formStatus,
    String? errorMessage,
    String? statusMessage,
  }) {
    return UserProfileState(
      formStatus: formStatus ?? this.formStatus,
      userModel: userModel ?? this.userModel,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object?> get props => [
        userModel,
        formStatus,
        errorMessage,
        statusMessage,
      ];
}
