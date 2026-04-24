import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_like_app/features/home/users/controller/users_cubit.dart';
import 'package:talabat_like_app/features/home/users/controller/users_state.dart';

class UserListScreen extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(),
      child: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UsersError) {
            return Scaffold(
              appBar: AppBar(title: Text('Users')),
              body: Center(child: Text(state.message)),
            );
          }
          if (state is UsersLoading) {
            return Scaffold(
              appBar: AppBar(title: Text('Users')),
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is UsersLoaded) {
            return Scaffold(
              appBar: AppBar(title: Text('Users')),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    children: [
                      TextField(
                        controller: context.read<UsersCubit>().nameController,
                        decoration: InputDecoration(
                          labelText: 'Enter user name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      TextField(
                        controller: context.read<UsersCubit>().ageController,
                        decoration: InputDecoration(
                          labelText: 'Enter user age',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.read<UsersCubit>().addUser();
                            },
                            child: Text('Add user'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<UsersCubit>().updateUser();
                            },
                            child: Text('Update user'),
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.users[index].fullName),
                            subtitle: Text('Age: ${state.users[index].age}'),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                context.read<UsersCubit>().selectUpdateUser(
                                  state.users[index],
                                );
                              },
                            ),
                            leading: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                context.read<UsersCubit>().deleteUser(
                                  state.users[index].id ?? '',
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(title: Text('Users')),
            body: Center(child: Text('No users found')),
          );
        },
      ),
    );
  }
}
