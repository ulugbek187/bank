import 'package:bank/data/models/user_model.dart';
import 'package:bank/data/net_work/net_work.dart';
import 'package:bank/utils/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserProfileRepo {
  Future<NetworkResponse> insertUser(UserModel userModel) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
            AppConstants.users,
          )
          .get();

      List<UserModel> users = querySnapshot.docs
          .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      bool isExists = false;

      for (var user in users) {
        if (user.email == userModel.email) {
          isExists = true;
        }
      }

      if (!isExists) {
        DocumentReference documentReference = await FirebaseFirestore.instance
            .collection(
              AppConstants.users,
            )
            .add(
              userModel.toJson(),
            );
        await FirebaseFirestore.instance
            .collection(
              AppConstants.users,
            )
            .doc(
              documentReference.id,
            )
            .update({
          "userId": documentReference.id,
        });
      }

      return NetworkResponse(
        data: "success",
      );
    } on FirebaseException catch (error) {
      debugPrint(
        error.message,
      );
      return NetworkResponse(
        errorCode: error.code,
        errorText: error.message ?? '',
      );
    }
  }

  Future<NetworkResponse> updateUser(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(
            AppConstants.users,
          )
          .doc()
          .update(
            userModel.toJsonForUpdate(),
          );

      return NetworkResponse(
        data: "success",
      );
    } on FirebaseException catch (error) {
      debugPrint(
        error.message,
      );
      return NetworkResponse(
        errorCode: error.code,
        errorText: error.message ?? '',
      );
    }
  }

  Future<NetworkResponse> deleteUser(String uuid) async {
    try {
      await FirebaseFirestore.instance
          .collection(
            AppConstants.users,
          )
          .doc(
            uuid,
          )
          .delete();

      return NetworkResponse(
        data: "success",
      );
    } on FirebaseException catch (error) {
      debugPrint(
        error.message,
      );
      return NetworkResponse(
        errorText: error.message ?? '',
        errorCode: error.code,
      );
    }
  }

  Future<NetworkResponse> getUserByDocId(String docID) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(
            AppConstants.users,
          )
          .doc(
            docID,
          )
          .get();

      return NetworkResponse(
        data: documentSnapshot.data() as Map<String, dynamic>,
      );
    } on FirebaseException catch (error) {
      debugPrint(
        error.message,
      );
      return NetworkResponse(
        errorCode: error.code,
        errorText: error.message ?? '',
      );
    }
  }

  Future<NetworkResponse> getUserByUUId(String uuid) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
            AppConstants.users,
          )
          .where("authUUId", isEqualTo: uuid)
          .get();

      List<UserModel> users = querySnapshot.docs
          .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      return NetworkResponse(
        data: users.isEmpty ? UserModel.initial() : users.first,
      );
    } on FirebaseException catch (error) {
      debugPrint(
        error.message,
      );
      return NetworkResponse(
        errorCode: error.code,
        errorText: error.message ?? '',
      );
    }
  }
}
