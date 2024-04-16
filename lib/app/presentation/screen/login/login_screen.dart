import 'dart:math';

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/ptit_background.jpg'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
          ),
          Container(color: const Color.fromRGBO(255, 255, 255, 0.6)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(right: min(200, MediaQuery.of(context).size.width * 0.1)),
                  child: Container(
                    width: max(MediaQuery.of(context).size.width * 0.2, 480),
                    height: max(MediaQuery.of(context).size.height * 0.4, 600),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 20,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 60,
                        bottom: 60,
                        left: 40,
                        right: 40,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome to PTIT Quiz !',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 60),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Forgot password ?'),
                            ),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 54),
                            ),
                            onPressed: () {},
                            child: const Text('Login'),
                          ),
                          const SizedBox(height: 32),
                          Container(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Create new account'),
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                )
              )
            ],
          )
        ],
      )
      ),
    );
  }
}