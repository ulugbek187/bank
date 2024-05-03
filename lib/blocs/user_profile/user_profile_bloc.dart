import 'package:bank/blocs/user_profile/user_profile_state.dart';
import 'package:bank/data/models/form_status.dart';
import 'package:bank/data/models/user_model.dart';
import 'package:bank/data/net_work/net_work.dart';
import 'package:bank/data/repositories/user_profile_repo/user_profile_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_profile_event.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepo userProfileRepo;

  UserProfileBloc(
    this.userProfileRepo,
  ) : super(
          UserProfileState(
            formStatus: FormStatus.pure,
            userModel: UserModel.initial(),
            errorMessage: "",
            statusMessage: "",
          ),
        ) {
    on<AddUserEvent>(_addUser);
    on<UpdateUserEvent>(_updateUser);
    on<GetCurrentUserEvent>(_getUserByUUID);
    on<DeleteUserEvent>(_deleteUser);
    on<GetUserByDocIdEvent>(_getUserByDocID);
  }

  _addUser(AddUserEvent event, emit) async {
    debugPrint(
        "\$\$\$\$\$\$\$\$\$\nADD USER TO TABLE GA TUSHDI\n\$\$\$\$\$\$\$\$\$");
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userProfileRepo.insertUser(event.userModel);

    if (networkResponse.errorText.isEmpty &&
        networkResponse.errorCode.isEmpty) {
      state.copyWith(
        formStatus: FormStatus.success,
        userModel: event.userModel,
      );
      debugPrint(
          "\$\$\$\$\$\$\$\$\$\nADD USER TO TABLE DA XATOLIKKA  TUSHDI: ${networkResponse.errorText}\n\$\$\$\$\$\$\$\$\$");
    } else {
      debugPrint(
          "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$ERRORS: ${networkResponse.errorText} =====================${networkResponse.errorCode}");
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
        statusMessage: networkResponse.errorCode,
      ));
    }
  }

  _updateUser(UpdateUserEvent event, emit) async {
    debugPrint("\$\$\$\$\$\$\$\$\$\nUPDATE USER TO TABLE GA TUSHDI\n\$\$\$\$\$\$\$\$\$");
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userProfileRepo.updateUser(event.userModel);

    if (networkResponse.errorText.isEmpty &&
        networkResponse.errorCode.isEmpty) {
      state.copyWith(
        formStatus: FormStatus.success,
        userModel: event.userModel,
      );
    } else {
      debugPrint(
          "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$ UPDATE USERDA XATOLIKKA TUSHDI: ${networkResponse.errorText} =====================${networkResponse.errorCode}");
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
        statusMessage: networkResponse.errorCode,
      ));
    }
  }

  _deleteUser(DeleteUserEvent event, emit) async {
    debugPrint("\$\$\$\$\$\$\$\$\$  DELETE USER FROM TABLE GA TUSHDI\n\$\$\$\$\$\$\$\$\$");
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse = await userProfileRepo.deleteUser(
      event.userModel.userId,
    );

    if (networkResponse.errorText.isEmpty &&
        networkResponse.errorCode.isEmpty) {
      state.copyWith(
        formStatus: FormStatus.success,
        userModel: UserModel.initial(),
      );
    } else {
      debugPrint(
          "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$ DELETE USER FROM TABLEDA XATOLIKKA TUSHDI: ${networkResponse.errorText} =====================${networkResponse.errorCode}");
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
        statusMessage: networkResponse.errorCode,
      ));
    }
  }

  _getUserByUUID(GetCurrentUserEvent event, emit) async {
    debugPrint("\$\$\$\$\$\$\$\$\$  GET USER BY UUID GA TUSHDI\n\$\$\$\$\$\$\$\$\$");

    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse = await userProfileRepo.getUserByUUId(
      event.uuid,
    );

    if (networkResponse.errorText.isEmpty &&
        networkResponse.errorCode.isEmpty) {
      state.copyWith(
        formStatus: FormStatus.success,
        userModel: networkResponse.data as UserModel,
      );
    } else {
      debugPrint(
          "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$ GET USER BY UUIDDA XATOLIKKA TUSHDI: ${networkResponse.errorText} =====================${networkResponse.errorCode}");
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
        statusMessage: networkResponse.errorCode,
      ));
    }
  }

  _getUserByDocID(GetUserByDocIdEvent event, emit) async {
    debugPrint("\$\$\$\$\$\$\$\$\$  GET USER BY DOC ID GA TUSHDI\n\$\$\$\$\$\$\$\$\$");

    emit(state.copyWith(formStatus: FormStatus.loading));

    debugPrint(
        "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$${event.docId}");

    NetworkResponse networkResponse = await userProfileRepo.getUserByDocId(
      event.docId,
    );

    if (networkResponse.errorText.isEmpty &&
        networkResponse.errorCode.isEmpty) {
      state.copyWith(
        formStatus: FormStatus.success,
        userModel: networkResponse.data as UserModel,
      );
    } else {
      debugPrint(
          "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$ GET USER BY DOC IDDA XATOLIKKA TUSHDI: ${networkResponse.errorText} =====================${networkResponse.errorCode}");
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
        statusMessage: networkResponse.errorCode,
      ));
    }
  }
}
