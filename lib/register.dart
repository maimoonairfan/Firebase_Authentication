import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    register() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      final String username = usernameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;

      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('you have successfully registered');
      try {
        final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(
              height: 14,
            ),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                  labelText: 'Enter Name', hintText: 'Enter Your Name'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Enter email', hintText: 'Enter email'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'Enter  Password', hintText: 'Enter Password'),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child:
                  ElevatedButton(onPressed: register, child: Text("Register")),
            )
          ],
        ),
      ),
    );
  }
}
