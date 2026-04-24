import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_like_app/features/home/users/controller/users_state.dart';
import 'package:talabat_like_app/features/home/users/model/user_model.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial()) {
    getUsers();
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String selectedUserId = '';
  Stream collectionStream = FirebaseFirestore.instance
      .collection('users')
      .snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  addUser() async {
    await users.add({
      'full_name': nameController.text,
      'age': int.parse(ageController.text),
    });
    nameController.clear();
    ageController.clear();
    getUsers();
  }

  getUsersStream() {
    collectionStream.listen(
      (snapshot) {
        List<UserModel> userList = [];
        for (var doc in snapshot.docs) {
          userList.add(
            UserModel(
              id: doc.id,
              fullName: doc['full_name'] as String,
              age: doc['age'] as int,
            ),
          );
        }
        emit(UsersLoaded(userList));
      },
      onError: (error) {
        emit(UsersError(error.toString()));
      },
    );
  }

  void selectUpdateUser(UserModel user) {
    selectedUserId = user.id!;
    nameController.text = user.fullName;
    ageController.text = user.age.toString();
  }

  void updateUser() async {
    try {
      Map<String, dynamic> updatedData = {};
      updatedData.addEntries([
        if (nameController.text.isNotEmpty)
          MapEntry('full_name', nameController.text),
        if (ageController.text.isNotEmpty)
          MapEntry('age', int.parse(ageController.text)),
      ]);
      await users.doc(selectedUserId).update(updatedData);
      nameController.clear();
      ageController.clear();
      selectedUserId = '';
      getUsers();
    } catch (e) {
      emit(UsersError('Failed to update user: $e'));
    }
  }

  void deleteUser(String id) async {
    try {
      await users.doc(id).delete();

      getUsers();
    } catch (e) {
      emit(UsersError('Failed to update user: $e'));
    }
  }

  void getUsers() async {
    emit(UsersLoading());
    try {
      QuerySnapshot snapshot = await users
          .where('age', isGreaterThan: 5)
          .orderBy('age')
          .get();
      log('snapshot: ${snapshot.docs}');
      List<UserModel> userList = snapshot.docs
          .map(
            (doc) => UserModel(
              id: doc.id,
              fullName: doc['full_name'] as String,
              age: doc['age'] as int,
            ),
          )
          .toList();
      emit(UsersLoaded(userList));
    } on Exception catch (e) {
      emit(UsersError(e.toString()));
    }
  }
}
