import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // sing user out
  void SingUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: SingUserOut, icon: const Icon(Icons.logout))
      ]),
      body: Center(
          child: Text(
        "وارد شدید با ${user.email!}",
        style: const TextStyle(fontSize: 20),
      )),
    );
  }
}
