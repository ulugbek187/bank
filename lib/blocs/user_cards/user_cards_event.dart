import 'package:equatable/equatable.dart';

import '../../data/models/user_cards_model.dart';

sealed class UserCardsEvent extends Equatable {}

class AddUserCardEvent extends UserCardsEvent {
  final UserCardsModel userCard;

  AddUserCardEvent({
    required this.userCard,
  });

  @override
  List<Object?> get props => [
        userCard,
      ];
}

class UpdateUserCardEvent extends UserCardsEvent {
  final UserCardsModel userCard;

  UpdateUserCardEvent({
    required this.userCard,
  });

  @override
  List<Object?> get props => [
        userCard,
      ];
}

class DeleteUserCardEvent extends UserCardsEvent {
  final UserCardsModel userCard;

  DeleteUserCardEvent({
    required this.userCard,
  });

  @override
  List<Object?> get props => [
        userCard,
      ];
}

class GetUserCardEvent extends UserCardsEvent {
  final String userId;

  GetUserCardEvent({
    required this.userId,
  });

  @override
  List<Object?> get props => [
        userId,
      ];
}

class GetAllUserCardsEvent extends UserCardsEvent {
  @override
  List<Object?> get props => [];
}
