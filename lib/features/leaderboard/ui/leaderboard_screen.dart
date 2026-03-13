import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:ecoscan_app/widgets/bottom_nav_bar.dart';

enum LeaderboardTab { people, companies }

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  LeaderboardTab activeTab = LeaderboardTab.people;
  final Random random = Random();

  final topUsers = const [
    ('ecolette_346', '50 143кг'),
    ('batman_batyr', '50 143кг'),
    ('user01546152', '50 143кг'),
  ];

  final users = const [
    ('Жанар Дугалова', '5226кг'),
    ('Дина Шынарова', '4896кг'),
    ('Аскар Рахатулы', '4863кг'),
    ('Лейла Сериккызы', '4798кг'),
    ('Жанна Ахметкызы', '4796кг'),
  ];

  final companies = const [
    'Halyk Bank',
    'Freedom Bank',
    'Otbasy Bank',
    'KIMEP University',
  ];

  Color randomColor() {
    return Color.fromARGB(
      255,
      random.nextInt(200),
      random.nextInt(200),
      random.nextInt(200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPeople = activeTab == LeaderboardTab.people;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:
          const EcoBottomNavBar(active: BottomNavItem.leaderboard),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding:
                  const EdgeInsets.only(top: 63, left: 29, right: 29),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  isPeople
                      ? 'Рейтинг эко-героев'
                      : 'Список партнеров',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 29),

            Container(
              width: 335,
              height: 41,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFB5D7BB)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  GestureDetector(
                    onTap: () =>
                        setState(() => activeTab = LeaderboardTab.people),
                    child: Container(
                      width: 152,
                      height: 27,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            isPeople ? AppColors.btn : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Люди',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          letterSpacing: 0.6,
                          color:
                              isPeople ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  GestureDetector(
                    onTap: () => setState(
                        () => activeTab = LeaderboardTab.companies),
                    child: Container(
                      width: 152,
                      height: 27,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: !isPeople
                            ? AppColors.btn
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Компании',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          letterSpacing: 0.6,
                          color:
                              !isPeople ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (isPeople) ...buildPeople() else ...buildCompanies(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildPeople() {
    return [

      const SizedBox(height: 29),

      ...List.generate(3, (i) {
        final data = topUsers[i];
        final colors = [
          AppColors.accent,
          const Color(0xFF612D7F),
          const Color(0xFF7F2D56),
        ];

        return Center(
          child: SizedBox(
            width: 330,
            height: 65,
            child: Stack(
              clipBehavior: Clip.none,
              children: [

                Positioned(
                  top: 7,
                  left: 5,
                  child: Container(
                    width: 325,
                    height: 58,
                    decoration: BoxDecoration(
                      color: colors[i],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [

                        Container(
                          width: 44,
                          height: 46,
                          margin:
                              const EdgeInsets.only(top: 6, left: 10),
                          decoration: BoxDecoration(
                            color: colors[i],
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.25),
                                blurRadius: 7,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              data.$1[0].toUpperCase(),
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.$1,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: i == 0
                                    ? AppColors.brandGreen
                                    : Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              data.$2,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: i == 0
                                    ? AppColors.brandGreen
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        Padding(
                          padding:
                              const EdgeInsets.only(right: 11),
                          child: Image.asset(
                            'assets/black-right-arrow.png',
                            width: 14,
                            height: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  right: 310,
                  bottom: 45,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: colors[i],
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),

      const SizedBox(height: 25),

      ...users.asMap().entries.map((entry) {
        final index = entry.key;
        final data = entry.value;
        final color = randomColor();

        return Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: Center(
            child: Container(
              width: 355,
              height: 41,
              padding:
                  const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [

                  SizedBox(
                    width: 26,
                    child: Center(
                      child: Text(
                        '${index + 4}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Container(
                    width: 44,
                    height: 41,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    child: Center(
                      child: Text(
                        data.$1[0].toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 11),

                  Expanded(
                    child: Text(
                      data.$1,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Text(
                    data.$2,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      color: AppColors.bonus,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Image.asset(
                    'assets/black-right-arrow.png',
                    width: 10,
                    height: 6,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ];
  }

  List<Widget> buildCompanies() {
    return [

      const SizedBox(height: 15),

      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 29),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Компании которые сотрудничают с ECOSCAN',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              color: AppColors.theGrey,
            ),
          ),
        ),
      ),

      const SizedBox(height: 15),

      ...companies.map((name) {
        final color = randomColor();

        return Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: Center(
            child: Container(
              width: 355,
              height: 41,
              padding:
                  const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [

                  Container(
                    width: 40,
                    height: 41,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    child: Center(
                      child: Text(
                        name[0].toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 11),

                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ];
  }
}