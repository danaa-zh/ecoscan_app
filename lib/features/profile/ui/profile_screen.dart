import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:ecoscan_app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _tabIndex = 0; // 0 = achievements, 1 = tasks, 2 = history

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: username + subtitle + avatar
            Padding(
              padding: const EdgeInsets.only(top: 35, left: 39, right: 37),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 21), // 56 (title top) - 35 (avatar top)
                      Text(
                        'danaa_zh',
                        style: TextStyle(
                          // fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.brandGreen,
                        ),
                      ),
                      Text(
                        'было создано в 2026',
                        style: TextStyle(
                          // fontFamily: 'Inter',
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
                      image: const DecorationImage(
                        image: AssetImage('assets/avatar.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            // Buttons row + bonus button
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
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.btn, width: 1),
                            foregroundColor: AppColors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: const TextStyle(
                              // fontFamily: 'Inter',
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
                            side: const BorderSide(color: AppColors.btn, width: 1),
                            foregroundColor: AppColors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: const TextStyle(
                              // fontFamily: 'Inter',
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
                          // fontFamily: 'Inter',
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      child: const Text('Бонусы'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // Tabs row + animated underline
            _ProfileTabs(
              index: _tabIndex,
              onChanged: (i) => setState(() => _tabIndex = i),
            ),
            const SizedBox(height: 10),
            // Tab content
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
  }

  Widget _buildTabContent() {
    switch (_tabIndex) {
      case 0:
        // Achievements empty state
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(height: 128),
            Center(
              child: Text(
                'У вас пока нету достижений',
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontFamily: 'Inter',
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
                  // fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        );
      case 1:
        // Weekly tasks with progress bars
        return ListView(
          padding: const EdgeInsets.only(top: 30),
          children: const [
            _TaskItem(
              imagePath: 'assets/bottle-icon.png',
              label: 'пластиковые бутылки',
              progressFraction: 0.5, // 5/10
              progressColor: Color(0xFF2175AD),
            ),
            SizedBox(height: 16),
            _TaskItem(
              imagePath: 'assets/can-icon.png',
              label: 'алюминевые банки',
              progressFraction: 0.3, // 3/10
              progressColor: Color(0xFF282435),
            ),
            SizedBox(height: 16),
            _TaskItem(
              imagePath: 'assets/box-icon.png',
              label: 'тетрапакет',
              progressFraction: 0.7, // 7/10
              progressColor: Color(0xFF26AF61),
            ),
            SizedBox(height: 16),
            _TaskItem(
              imagePath: 'assets/glass-icon.png',
              label: 'стеклянные бутылки',
              progressFraction: 0.2, // 3/10 (approx)
              progressColor: Color(0xFFD72221),
            ),
          ],
        );
      case 2:
        // History with filter and list
        return ListView(
          children: [
            // Filter button row
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 80,
                    height: 28,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: AppColors.theGrey, width: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        foregroundColor: AppColors.theGrey,
                        textStyle: const TextStyle(
                          // fontFamily: 'Inter',
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
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(left: 37, bottom: 7),
              child: Text(
                'За последнюю неделю',
                style: TextStyle(
                  // fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ),
            const _HistoryItem(
              title: '5 пластиковые бутылки',
              subtitle: '21.02.2026 11:45 ТРЦ “Mega”',
            ),
            const SizedBox(height: 5),
            const _HistoryItem(
              title: '3 алюминевые банки',
              subtitle: '20.02.2026 11:45 Университет “МУИТ”',
            ),
            const SizedBox(height: 5),
            const _HistoryItem(
              title: '7 тетрапакет',
              subtitle: '18.02.2026 11:45 Банк “Halyk”',
            ),
            const SizedBox(height: 5),
            const _HistoryItem(
              title: '3 стеклянные бутылки',
              subtitle: '17.02.2026 11:45 Колледж “МАБ”',
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
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
        // Grey baseline with animated green segment
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
          // fontFamily: 'Inter',
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
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
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
                      // fontFamily: 'Inter',
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
                          child: Container(
                            color: progressColor,
                          ),
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
  });

  final String title;
  final String subtitle;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      // fontFamily: 'Inter',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      // fontFamily: 'Inter',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.theGrey,
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
