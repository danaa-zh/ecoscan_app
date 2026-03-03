import 'package:flutter/material.dart';
import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:ecoscan_app/features/login/ui/login_screen.dart';
import 'package:ecoscan_app/features/onboarding/ui/onboarding_screen.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: SafeArea(
        child: Stack(
          children: [
            // Back arrow
            Positioned(
              top: 16,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const OnboardingScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/green-left-arrow.png',
                  width: 16,
                  height: 9,
                ),
              ),
            ),
            // Content
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 216),
                  const Text(
                    'EcoScan',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brandGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Добро пожаловать, Дана!\nТвой уровень: новичок',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4D7664),
                    ),
                  ),
                  const SizedBox(height: 54),
                  const _AuthTextField(hint: 'Введите имя'),
                  const SizedBox(height: 12),
                  const _AuthTextField(hint: 'Введите фамилию'),
                  const SizedBox(height: 12),
                  const _AuthTextField(hint: 'Введите логин'),
                  const SizedBox(height: 12),
                  const _AuthTextField(hint: 'Введите пароль', obscureText: true),
                  const SizedBox(height: 12),
                  const _AuthTextField(hint: 'Повторите пароль', obscureText: true),
                  const Spacer(),
                  SizedBox(
                    width: 345,
                    height: 51,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const LoginPage(),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.btn,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      child: const Text(
                        'Зарегистрироваться',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 37),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.hint,
    this.obscureText = false,
  });

  final String hint;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315,
      height: 58,
      child: TextField(
        obscureText: obscureText,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.placeholder,
          ),
          filled: true,
          fillColor: AppColors.white,
          contentPadding: const EdgeInsets.only(left: 40),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(31),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(31),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(31),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}