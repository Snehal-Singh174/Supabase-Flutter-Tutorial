import 'package:flutter/material.dart';
import 'package:supabase_auth/supabase_state/auth_require_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends AuthRequiredState<DashboardScreen> {
  User? user;

  @override
  void onAuthenticated(Session session) {
    final _user = session.user;
    user = _user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 34,
            width: 264,
            margin: const EdgeInsets.only(
              left: 15,
              right: 16,
            ),
            child: const Text(
              "Welcome to Supabase",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(
            height: 70.0,
            child: Image.asset(
              "assets/images/logo.png",
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 30, bottom: 20),
              child: Text(
                "User: ${user!.userMetadata['full_name'] ?? user!.email}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onTapSignOut();
            },
            child: const Text('SignOut'),
          )
        ],
      ),
    );
  }

  void onTapSignOut() async {
    await Supabase.instance.client.auth.signOut();
  }
}
