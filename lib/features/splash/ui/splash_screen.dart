import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 600), () {
      if (mounted) context.go(RouteNames.onboardingPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.brandGreen,
      body: Center(
        child: Text(
          'ECOSCAN',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: AppColors.accent,
          ),
        ),
      ),
    );
  }
}