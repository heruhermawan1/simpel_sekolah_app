import 'package:flutter/material.dart';

/// Icons used throughout the SIMPel Sekolah application
class AppIcons {
  // Navigation & General
  static const IconData menu = Icons.menu;
  static const IconData accountCircle = Icons.account_circle_rounded;
  static const IconData arrowBack = Icons.chevron_left_rounded;
  static const IconData arrowForward = Icons.chevron_right_rounded;
  static const IconData close = Icons.close_rounded;

  // Dashboard Main (Home)
  static const IconData school = Icons.school_rounded;
  static const IconData adminPanel = Icons.admin_panel_settings_rounded;
  static const IconData workspacePremium = Icons.workspace_premium_rounded;
  static const IconData person = Icons.person;
  static const IconData familyRestroom = Icons.family_restroom;
  static const IconData historyEdu = Icons.history;

  // Admin Dashboard Stats
  static const IconData people = Icons.people;
  static const IconData checkCircle = Icons.check_circle;
  static const IconData apps = Icons.apps;
  static const IconData laptop = Icons.laptop;
  static const IconData trendingUp = Icons.trending_up;

  // Admin Dashboard Menu
  static const IconData peopleAlt = Icons.people_alt;
  static const IconData grid3x3 = Icons.grid_view;
  static const IconData checkBox = Icons.check_box;
  static const IconData computer = Icons.computer;
  static const IconData note = Icons.note;
  static const IconData home = Icons.home;
  static const IconData groups = Icons.groups;

  // Login Form
  static const IconData email = Icons.email;
  static const IconData lock = Icons.lock;
  static const IconData visibility = Icons.visibility;
  static const IconData visibilityOff = Icons.visibility_off;
}

/// Color constants used throughout the application
class AppColors {
  // Primary Blue Gradient
  static const Color primaryDark = Color(0xFF061D3E);
  static const Color primaryMedium = Color(0xFF0B264F);
  static const Color primaryLight = Color(0xFF0F4A7B);
  static const Color primaryDarker = Color(0xFF073457);

  // Admin Dashboard
  static const Color adminBluePrimary = Color(0xFF0B4DCA);
  static const Color adminBlueLight = Color(0xFF4A90FF);
  static const Color adminGreen = Color(0xFF2ABE7A);

  // Icon Colors
  static const Color iconBlue = Color(0xFF5AB0FF);
  static const Color iconGreen = Color(0xFF2ABE7A);
  static const Color iconYellow = Color(0xFFFFC107);
  static const Color iconOrange = Color(0xFFFF9800);
  static const Color iconRed = Color(0xFFE91E63);

  // Gradients
  static const List<Color> gradientBlueGreen = [
    Color(0xFF0B264F),
    Color(0xFF0F4A7B),
    Color(0xFF073457),
  ];

  static const List<Color> gradientIconBlue = [
    Color(0xFF4F8CFF),
    Color(0xFF2A6EBB),
  ];

  static const List<Color> gradientAdminBlue = [
    Color(0xFF1F3B7A),
    Color(0xFF16688F),
    Color(0xFF1B8D95),
  ];

  // Text Colors
  static const Color textWhite = Colors.white;
  static const Color textWhiteLight = Colors.white70;
  static const Color textGrey = Colors.grey;
  static const Color textDark = Colors.black87;

  // Background
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color backgroundWhite = Colors.white;
}

/// Dashboard Card Data
class DashboardCardData {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  DashboardCardData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}

/// Pre-defined dashboard cards for main dashboard
final mainDashboardCards = [
  DashboardCardData(
    icon: AppIcons.adminPanel,
    title: 'Admin Sekolah',
    subtitle: 'Kelola seluruh sistem',
    color: const Color(0xFF5AB0FF),
  ),
  DashboardCardData(
    icon: AppIcons.workspacePremium,
    title: 'Kepala Sekolah',
    subtitle: 'Monitor & laporan',
    color: const Color(0xFF8FD6FF),
  ),
  DashboardCardData(
    icon: AppIcons.person,
    title: 'Guru / Wali Kelas',
    subtitle: 'Absensi & nilai',
    color: const Color(0xFFFFD36B),
  ),
  DashboardCardData(
    icon: AppIcons.school,
    title: 'Siswa',
    subtitle: 'Jadwal & nilai saya',
    color: const Color(0xFF81D4FA),
  ),
  DashboardCardData(
    icon: AppIcons.familyRestroom,
    title: 'Orang Tua',
    subtitle: 'Pantau perkembangan anak',
    color: const Color(0xFF76E6B1),
  ),
  DashboardCardData(
    icon: AppIcons.historyEdu,
    title: 'Alumni',
    subtitle: 'Data alumni',
    color: const Color(0xFFFFA66B),
  ),
];

/// Stats card data for admin dashboard
final adminDashboardStats = [
  {
    'icon': AppIcons.people,
    'number': '6',
    'label': 'Total Siswa',
    'color': AppColors.iconBlue,
  },
  {
    'icon': AppIcons.school,
    'number': '4',
    'label': 'Total Guru',
    'color': AppColors.iconGreen,
  },
  {
    'icon': AppIcons.checkCircle,
    'number': '2',
    'label': 'Hadir Hari Ini',
    'color': AppColors.iconYellow,
  },
  {
    'icon': AppIcons.apps,
    'number': '6',
    'label': 'Kelas Aktif',
    'color': AppColors.iconOrange,
  },
  {
    'icon': AppIcons.laptop,
    'number': '1',
    'label': 'Ujian Aktif',
    'color': const Color(0xFF2196F3),
  },
  {
    'icon': AppIcons.trendingUp,
    'number': '1',
    'label': 'Pencapaian Baru',
    'color': AppColors.iconRed,
  },
];

/// Menu items for admin dashboard
final adminDashboardMenu = [
  {
    'icon': AppIcons.peopleAlt,
    'label': 'Data Siswa',
  },
  {
    'icon': AppIcons.person,
    'label': 'Data Guru',
  },
  {
    'icon': AppIcons.grid3x3,
    'label': 'Kelas',
  },
  {
    'icon': AppIcons.checkBox,
    'label': 'Absensi',
  },
  {
    'icon': AppIcons.computer,
    'label': 'CBT',
  },
  {
    'icon': AppIcons.note,
    'label': 'SPMB',
  },
];

/// Bottom navigation menu items
final bottomNavItems = [
  {
    'icon': AppIcons.home,
    'label': 'Beranda',
  },
  {
    'icon': AppIcons.checkBox,
    'label': 'Absensi',
  },
  {
    'icon': AppIcons.computer,
    'label': 'CBT',
  },
  {
    'icon': AppIcons.note,
    'label': 'SPMB',
  },
  {
    'icon': AppIcons.person,
    'label': 'Profil',
  },
];


