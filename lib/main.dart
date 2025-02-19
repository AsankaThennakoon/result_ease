import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:result_ease/screen/lecture/home_lecture.dart';
import 'package:result_ease/screen/onboarding/login.dart';
import 'package:result_ease/screen/onboarding/splash.dart';
import 'package:result_ease/screen/student/home_student.dart';
import 'package:result_ease/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }

            final user = snapshot.data;

            if (user != null && user.uid.isNotEmpty) {
              // Check if user is a lecture

              var providerId=user.providerData;

              print(providerId.toString()+"hahahhahahahahahahhah");
              if (providerId.isNotEmpty){
                return const HomeLecture();
              } else {
                return const StudentHome();
              }
            }

            return const Login();
          }),
    );
  }
}
