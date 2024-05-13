import 'package:equatable/equatable.dart';

import '../../data/models/form_status.dart';
import '../../data/models/user_cards_model.dart';

class UserCardsState extends Equatable {
  final FormStatus formStatus;
  final List<UserCardsModel> userCards;
  final List<UserCardsModel> db;
  final String? errorMessage;
  final String? statusMessage;

  const UserCardsState({
    required this.formStatus,
    this.userCards = const [],
    this.errorMessage,
    this.statusMessage,
    this.db = const [],
  });

  UserCardsState copyWith({
    List<UserCardsModel>? userCards,
    List<UserCardsModel>? db,
    FormStatus? formStatus,
    String? errorMessage,
    String? statusMessage,
  }) {
    return UserCardsState(
      db: db ?? this.db,
      formStatus: formStatus ?? this.formStatus,
      userCards: userCards ?? this.userCards,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object?> get props => [
        db,
        userCards,
        formStatus,
        errorMessage,
        statusMessage,
      ];
}
