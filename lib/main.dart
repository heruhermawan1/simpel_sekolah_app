import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'constants/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIMPel Sekolah',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF061D3E),
        textTheme: Typography.whiteMountainView,
        cardTheme: CardThemeData(
          color: Colors.white.withAlpha((0.08 * 255).round()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.white,
        );
    final subtitleStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Colors.white70,
          height: 1.4,
        );
    final sectionLabelStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B264F), Color(0xFF0F4A7B), Color(0xFF073457)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4F8CFF), Color(0xFF2A6EBB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 10),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const Icon(
                      AppIcons.school,
                      size: 42,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text('SIMPel Sekolah', style: titleStyle),
                const SizedBox(height: 8),
                Text('Sistem Informasi Manajemen Pendidikan', style: subtitleStyle),
                const SizedBox(height: 28),
                Text('Masuk sebagai', style: sectionLabelStyle),
                const SizedBox(height: 18),
                Expanded(
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.98,
                    children: [
                      DashboardCard(
                        icon: AppIcons.adminPanel,
                        title: 'Admin Sekolah',
                        subtitle: 'Kelola seluruh sistem',
                        iconColor: const Color(0xFF5AB0FF),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                      ),
                      DashboardCard(
                        icon: AppIcons.workspacePremium,
                        title: 'Kepala Sekolah',
                        subtitle: 'Monitor & laporan',
                        iconColor: const Color(0xFF8FD6FF),
                      ),
                      DashboardCard(
                        icon: AppIcons.person,
                        title: 'Guru / Wali Kelas',
                        subtitle: 'Absensi & nilai',
                        iconColor: const Color(0xFFFFD36B),
                      ),
                      DashboardCard(
                        icon: AppIcons.school,
                        title: 'Siswa',
                        subtitle: 'Jadwal & nilai saya',
                        iconColor: const Color(0xFF81D4FA),
                      ),
                      DashboardCard(
                        icon: AppIcons.familyRestroom,
                        title: 'Orang Tua',
                        subtitle: 'Pantau perkembangan anak',
                        iconColor: const Color(0xFF76E6B1),
                      ),
                      DashboardCard(
                        icon: AppIcons.historyEdu,
                        title: 'Alumni',
                        subtitle: 'Data alumni',
                        iconColor: const Color(0xFFFFA66B),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'SIMPel Sekolah v1.0 - 2025',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white54,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap ?? () {},
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: iconColor.withAlpha((0.18 * 255).round()),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: iconColor, size: 24),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white54),
                ],
              ),
              const Spacer(),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
