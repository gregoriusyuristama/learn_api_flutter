import 'package:fetch_api_flutter/user_controller.dart';
import 'package:fetch_api_flutter/user_model.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<User> futureUser;
  late Future<List<User>> futureUserList;

  @override
  void initState() {
    super.initState();
    futureUser = UserController.fetchUser();
    futureUserList = UserController.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                "Single User:",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              FutureBuilder<User>(
                future: futureUser,
                builder: (context, snapshot) {
                  //MARK: when loading display loading progress
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  //MARK: If no data available
                  else if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text("Title: ${snapshot.data!.title}"),
                        Text("User ID: ${snapshot.data!.userId}"),
                      ],
                    );
                  }
                  //MARK: If no data available
                  else {
                    return const Text("No data available");
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "List of User:",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              FutureBuilder<List<User>>(
                future: futureUserList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    //MARK: Build widget from buildUsers function
                    return buildUsers(snapshot.data!);
                  } else {
                    return const Text("No data available");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUsers(List<User> userList) {
    return Flexible(
      child: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return Column(
            children: [
              Text("Title: ${user.title}"),
              Text("User ID: ${user.userId}"),
            ],
          );
        },
      ),
    );
  }
}
