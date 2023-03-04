import 'package:flutter/material.dart';
import 'package:hapii/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: IconButton(
          onPressed: () {
            final provider = Provider.of<GoogleSignInProvider>(context);
            provider.logout();
          },
          icon: const Icon(UniconsLine.exit),
        ),
      ),
    );
  }
}
