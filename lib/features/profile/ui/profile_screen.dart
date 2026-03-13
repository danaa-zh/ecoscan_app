import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:ecoscan_app/features/profile/bloc/profile_bloc.dart';
import 'package:ecoscan_app/features/profile/ui/edit_profile_screen.dart';
import 'package:ecoscan_app/widgets/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _tabIndex = 0;

@override
void initState() {
  super.initState();
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid != null) {
    context.read<ProfileBloc>().loadProfile(uid);
  }
}

  String _formatCreatedAt(dynamic createdAtMillis) {
    if (createdAtMillis == null) return 'дата создания неизвестна';

    final date = DateTime.fromMillisecondsSinceEpoch(createdAtMillis as int);
    return 'было создано в ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, Map<String, dynamic>?>(
      builder: (context, user) {
        final username = user?['username'] ?? 'loading...';
        final createdAtText = _formatCreatedAt(user?['createdAtMillis']);
        final avatarUrl = user?['avatarUrl'];

        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 39, right: 37),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 21),
                          Text(
                            username,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.brandGreen,
                            ),
                          ),
                          Text(
                            createdAtText,
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.brandGreen,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: avatarUrl != null && avatarUrl.toString().isNotEmpty
                              ? Image.network(
                                  avatarUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.person,
                                    size: 36,
                                    color: AppColors.brandGreen,
                                  ),
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 36,
                                  color: AppColors.brandGreen,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 39, right: 37),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 186,
                            height: 26,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const EditProfilePage(),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AppColors.btn,
                                  width: 1,
                                ),
                                foregroundColor: AppColors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/edit-icon.png',
                                    width: 15,
                                    height: 12,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text('Редактировать профиль'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          SizedBox(
                            width: 127,
                            height: 26,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AppColors.btn,
                                  width: 1,
                                ),
                                foregroundColor: AppColors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/settings-icon.png',
                                    width: 16,
                                    height: 12,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text('Настройки'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 317,
                        height: 26,
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.btn,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          child: Text(
                            'Бонусы: ${user?['bonusBalance'] ?? 0}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                _ProfileTabs(
                  index: _tabIndex,
                  onChanged: (i) => setState(() => _tabIndex = i),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildTabContent(),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const EcoBottomNavBar(active: BottomNavItem.profile),
        );
      },
    );
  }

  Widget _buildTabContent() {
    switch (_tabIndex) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(height: 128),
            Center(
              child: Text(
                'У вас пока нету достижений',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBox(height: 4),
            Center(
              child: Text(
                'Начните сдавать мусор в фандомат и выполнять таски чтобы\n'
                'вам начислялись бонусы и получать награды',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        );
      case 1:
        return ListView(
          padding: const EdgeInsets.only(top: 30),
          children: const [
            _TaskItem(
              imagePath: 'assets/bottle-icon.png',
              label: 'пластиковые бутылки',
              progressFraction: 0.5,
              progressColor: Color(0xFF2175AD),
            ),
            SizedBox(height: 16),
            _TaskItem(
              imagePath: 'assets/can-icon.png',
              label: 'алюминевые банки',
              progressFraction: 0.3,
              progressColor: Color(0xFF282435),
            ),
            SizedBox(height: 16),
            _TaskItem(
              imagePath: 'assets/box-icon.png',
              label: 'тетрапакет',
              progressFraction: 0.7,
              progressColor: Color(0xFF26AF61),
            ),
            SizedBox(height: 16),
            _TaskItem(
              imagePath: 'assets/glass-icon.png',
              label: 'стеклянные бутылки',
              progressFraction: 0.2,
              progressColor: Color(0xFFD72221),
            ),
          ],
        );
      case 2:
        return ListView(
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 80,
                    height: 28,
                    child: _FilterButton(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 37, bottom: 7),
              child: Text(
                'За последнюю неделю',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ),
            _HistoryItem(
              title: '5 пластиковые бутылки',
              subtitle: '21.02.2026 11:45 ТРЦ “Mega”',
              bonusText: '+ 50 бонусов',
            ),
            SizedBox(height: 5),
            _HistoryItem(
              title: '3 алюминевые банки',
              subtitle: '20.02.2026 11:45 Университет “МУИТ”',
              bonusText: '+ 30 бонусов',
            ),
            SizedBox(height: 5),
            _HistoryItem(
              title: '7 тетрапакет',
              subtitle: '18.02.2026 11:45 Банк “Halyk”',
              bonusText: '+ 70 бонусов',
            ),
            SizedBox(height: 5),
            _HistoryItem(
              title: '3 стеклянные бутылки',
              subtitle: '17.02.2026 11:45 Колледж “МАБ”',
              bonusText: '+ 30 бонусов',
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: const BorderSide(
          color: AppColors.theGrey,
          width: 1,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        foregroundColor: AppColors.theGrey,
        textStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/filter.png',
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 2),
          const Text('Фильтр'),
        ],
      ),
    );
  }
}

class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs({
    required this.index,
    required this.onChanged,
  });

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 37, right: 37),
          child: Row(
            children: [
              _TabText(
                label: 'Достижения',
                isActive: index == 0,
                onTap: () => onChanged(0),
              ),
              const SizedBox(width: 55),
              _TabText(
                label: 'Таски на неделю',
                isActive: index == 1,
                onTap: () => onChanged(1),
              ),
              const SizedBox(width: 34),
              _TabText(
                label: 'История действий',
                isActive: index == 2,
                onTap: () => onChanged(2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          height: 4,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const Align(
                alignment: Alignment.bottomCenter,
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.theGrey,
                ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: index == 0
                    ? Alignment.bottomLeft
                    : index == 1
                        ? Alignment.bottomCenter
                        : Alignment.bottomRight,
                child: Container(
                  width: index == 0
                      ? 136
                      : index == 1
                          ? 115
                          : 149,
                  height: 4,
                  color: AppColors.btn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TabText extends StatelessWidget {
  const _TabText({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: isActive ? AppColors.black : AppColors.theGrey,
        ),
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  const _TaskItem({
    required this.imagePath,
    required this.label,
    required this.progressFraction,
    required this.progressColor,
  });

  final String imagePath;
  final String label;
  final double progressFraction;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 359,
      height: 62,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.brandGreen, width: 1.5),
              ),
              child: Center(
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brandGreen,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 251.42,
                    height: 12.14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(74),
                      border: Border.all(
                        color: AppColors.brandGreen,
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(74),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: progressFraction,
                          child: Container(color: progressColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({
    required this.title,
    required this.subtitle,
    this.bonusText,
  });

  final String title;
  final String subtitle;
  final String? bonusText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 32,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(color: AppColors.btn, width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(7, 5, 8, 5),
                child: Image.asset(
                  'assets/history-icon.png',
                  width: 15,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.theGrey,
                        ),
                      ),
                    ],
                  ),
                  if (bonusText != null)
                    Positioned(
                      top: 10,
                      right: 16,
                      child: Text(
                        bonusText!,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bonus,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}