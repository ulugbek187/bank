import 'package:bank/blocs/user_cards/user_cards_event.dart';
import 'package:bank/blocs/user_cards/user_cards_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/form_status.dart';
import '../../data/models/user_cards_model.dart';
import '../../data/net_work/net_work.dart';
import '../../data/repositories/user_cards_repo/user_cards_repo.dart';

class UserCardsBlock extends Bloc<UserCardsEvent, UserCardsState> {
  UserCardsBlock(this.userCardsRepo)
      : super(const UserCardsState(formStatus: FormStatus.pure)) {
    on<AddUserCardEvent>(_addUserCard);
    on<UpdateUserCardEvent>(_updateUserCard);
    on<DeleteUserCardEvent>(_deleteUserCard);
    on<GetUserCardEvent>(_listenUserCards);
    on<GetAllUserCardsEvent>(_listenAllCards);
  }

  final UserCardsRepo userCardsRepo;

  _addUserCard(AddUserCardEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    NetworkResponse networkResponse = await userCardsRepo.insertCard(
      event.userCard,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
        formStatus: FormStatus.showMessage,
        statusMessage: 'added',
      ));
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }

  _updateUserCard(UpdateUserCardEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    NetworkResponse networkResponse = await userCardsRepo.updateCard(
      event.userCard,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.showMessage,
          statusMessage: 'updated',
        ),
      );
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }

  _deleteUserCard(DeleteUserCardEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    NetworkResponse networkResponse = await userCardsRepo.deleteCard(
      event.userCard.cardId,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.showMessage,
          statusMessage: 'deleted',
        ),
      );
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }

  _listenUserCards(GetUserCardEvent event, Emitter emit) async {
    await emit.onEach(userCardsRepo.getCardsByUserId(event.userId),
        onData: (List<UserCardsModel> userCards) {
      emit(state.copyWith(
        userCards: userCards,
      ));
    });
  }

  _listenAllCards(GetAllUserCardsEvent event, Emitter emit) async {
    await emit.onEach(userCardsRepo.getCardsFromDb(),
        onData: (List<UserCardsModel> userCards) {
      emit(state.copyWith(
        userCards: userCards,
      ));
    });
  }
}
