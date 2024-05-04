import 'package:bank/blocs/user_profile/user_profile_event.dart';
import 'package:bank/blocs/user_profile/user_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/form_status.dart';
import '../../data/models/user_model.dart';
import '../../data/net_work/net_work.dart';
import '../../data/repositories/user_profile_repo/user_profile_repo.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc(this.userProfileRepository)
      : super(UserProfileState(
          userModel: UserModel.initial(),
          formStatus: FormStatus.pure,
          errorMessage: "",
          statusMessage: "",
        )) {
    on<AddUserEvent>(_addUser);
    on<UpdateUserEvent>(_updateUser);
    on<DeleteUserEvent>(_deleteUser);
    on<GetUserByDocIdEvent>(_getUserByDocId);
    on<GetCurrentUserEvent>(_getUser);
  }

  final UserProfileRepo userProfileRepository;

  _addUser(AddUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userProfileRepository.insertUser(event.userModel);

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          userModel: event.userModel,
        ),
      );
    } else {
      emit(state.copyWith(
        statusMessage: networkResponse.errorCode,
        formStatus: FormStatus.error,
      ));
    }
  }

  _updateUser(UpdateUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userProfileRepository.updateUser(event.userModel);

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          userModel: event.userModel,
        ),
      );
    } else {
      emit(state.copyWith(
        statusMessage: networkResponse.errorCode,
        formStatus: FormStatus.error,
      ));
    }
  }

  _deleteUser(DeleteUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userProfileRepository.deleteUser(event.userModel.userId);

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          userModel: UserModel.initial(),
        ),
      );
    } else {
      emit(state.copyWith(
        statusMessage: networkResponse.errorCode,
        formStatus: FormStatus.error,
      ));
    }
  }

  _getUserByDocId(GetUserByDocIdEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userProfileRepository.getUserByDocId(event.docId);

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          userModel: networkResponse.data as UserModel,
        ),
      );
    } else {
      emit(
        state.copyWith(
          statusMessage: networkResponse.errorCode,
          formStatus: FormStatus.error,
        ),
      );
    }
  }

  _getUser(GetCurrentUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userProfileRepository.getUserByUUId();

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          userModel: networkResponse.data as UserModel,
        ),
      );
    } else {
      emit(
        state.copyWith(
          statusMessage: networkResponse.errorCode,
          formStatus: FormStatus.error,
        ),
      );
    }
  }
}
