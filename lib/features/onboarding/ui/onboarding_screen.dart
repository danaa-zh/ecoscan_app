import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:ecoscan_app/features/register/ui/register_screen.dart';
import 'package:ecoscan_app/features/login/ui/login_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 56),
              const _EcoScanLogo(),
              const SizedBox(height: 64),
              SizedBox(
                width: 294,
                height: 57,
                child: Text(
                  'Бросай мусор - получай бонусы!\n'
                  'Внеси свой вклад в природу вместе\n'
                  'с нами!',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: SizedBox(
                  width: 345,
                  height: 51,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const RegisterPage(),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.btn,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17.25),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('НАЧАТЬ'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: 345,
                  height: 51,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: AppColors.btnHaveAccText,
                      side: const BorderSide(
                        color: AppColors.btnHaveAcc,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17.25),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('У МЕНЯ УЖЕ ЕСТЬ АККАУНТ'),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _EcoScanLogo extends StatelessWidget {
  const _EcoScanLogo();

  @override
  Widget build(BuildContext context) {
    const double fontSize = 96;
    const fontWeight = FontWeight.w800;

    const TextStyle ecoStyle = TextStyle(
      color: AppColors.lightGreen,
      fontSize: fontSize,
      fontWeight: fontWeight,
      shadows: [
        Shadow(color: AppColors.brandGreen, offset: Offset(-1, 0), blurRadius: 0),
        Shadow(color: AppColors.brandGreen, offset: Offset(1, 0), blurRadius: 0),
        Shadow(color: AppColors.brandGreen, offset: Offset(0, -1), blurRadius: 0),
        Shadow(color: AppColors.brandGreen, offset: Offset(0, 1), blurRadius: 0),
      ],
    );

    const TextStyle scanStyle = TextStyle(
      color: AppColors.brandGreen,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );

    return SizedBox(
      width: 294,
      child: Stack(
        clipBehavior: Clip.none,
        children: const [
          Text('Eco', style: ecoStyle),
          Positioned(
            left: 0,
            top: 72,
            child: Text('Scan', style: scanStyle),
          ),
        ],
      ),
    );
  }
}