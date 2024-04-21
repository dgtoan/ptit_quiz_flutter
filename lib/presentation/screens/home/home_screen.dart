import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.go('/auth/login');
                    },
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/auth/register');
                    },
                    child: const Text('Register'),
                  ),
                ]
              )
            ),
          ],
        ),
      ),
    );
  }
}