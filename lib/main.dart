import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/myuser.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:brew_crew/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(StreamProvider<MyUser?>.value(
    value: AuthService().user,
    initialData: null,
    child: const MaterialApp(
      home: Wrapper()
    ),
  ));
}
