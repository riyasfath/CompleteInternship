import 'package:flutter/material.dart';
import 'package:my_grocery/starting_pages/welcome_screen.dart';
import 'package:my_grocery/view/dashboard/dashboard_screen.dart';
import 'package:my_grocery/view/home/home_screen.dart';

import '../view/account/auth/sign_in_screen.dart';

class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/starting.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'onDoor',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
                // Action when "Get Started" button is pressed
              },
              child: Text('Get Started'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange, // Set the button color to orange
                onPrimary: Colors.white, // Set the text color to white
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomePage()));

                // Action when "Sign in" button is pressed
              },
              child: const Text(
                'Already have an account? Sign in',
                style: TextStyle(
                  color: Colors.orange, // Set the text color to orange
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
