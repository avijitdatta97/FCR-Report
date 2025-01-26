import 'package:fcr_report/CategoryPage.dart';
import 'package:fcr_report/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCasePage extends StatelessWidget {
  static const String routeName = '/users';
  const UserCasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).getAllUsers();
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.userList.length,
          itemBuilder: (context, index) {
            final user = provider.userList[index];
            return ListTile(
              title: Text(user.name ?? 'No Display name'),
              subtitle: Text(user.email.toString()),
              // trailing: Text(
              //     'Joined \n${getDifference(user.userCreationTime!.toDate()).inDays} day(s) ago'),
            );
          },
        ),
      ),
    );
  }
}
