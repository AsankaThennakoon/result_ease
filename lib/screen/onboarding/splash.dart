import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:result_ease/screen/onboarding/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _navigateToLoginScreen();
  }

  Future<void> _navigateToLoginScreen() async {
    // Wait for 5 seconds using Future.delayed
    await Future.delayed(const Duration(seconds: 5));

    // Navigate to the login screen
    // _navigatorKey.currentState!.pushReplacement(
    //   MaterialPageRoute(builder: (context) => Login()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: SvgPicture.asset(
                          'assets/images/top_circle.svg',
                          width: 200, // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                        ),
                      ),

                      Center(
                          child: Text("Result Ease",
                              style: Theme.of(context).textTheme.headline1)),

                      Positioned(
                        top: (MediaQuery.of(context).size.height) / 2,
                        left: (MediaQuery.of(context).size.width - 300) /
                            2, // Assuming SVG width is 100

                        child: SvgPicture.asset(
                          'assets/images/splash_image.svg',
                          width: 300, // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: SvgPicture.asset(
                          'assets/images/bottom_circle.svg',
                          width: 100, // Adjust the width as needed
                          height: 100, // Adjust the height as needed
                        ),
                      ),
                      // Add other widgets here
                    ],
                  ),
                ));
      },
    );
  }
}
