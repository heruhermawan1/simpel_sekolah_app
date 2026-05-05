import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ClassDataPage extends StatefulWidget {
  const ClassDataPage({super.key});

  @override
  State<ClassDataPage> createState() => _ClassDataPageState();
}

class _ClassDataPageState extends State<ClassDataPage> {
  final _searchController = TextEditingController();

  final List<ClassData> _classes = [
    ClassData(
      name: 'X IPA 1',
      homeroomTeacher: 'Sari Dewi, S.Pd',
      subject: 'IPA',
      studentCount: 34,
      schoolYear: '2025/2026',
    ),
    ClassData(
      name: 'X IPA 2',
      homeroomTeacher: 'Hendra Gunawan, M.Sc',
      subject: 'IPA',
      studentCount: 35,
      schoolYear: '2025/2026',
    ),
    ClassData(
      name: 'X IPS 1',
      homeroomTeacher: 'Rina Yuliani, S.Pd',
      subject: 'IPS',
      studentCount: 32,
      schoolYear: '2025/2026',
    ),
    ClassData(
      name: 'XI IPA 1',
      homeroomTeacher: 'Rina Yuliani, S.Pd',
      subject: 'IPA',
      studentCount: 33,
      schoolYear: '2025/2026',
    ),
    ClassData(
      name: 'XI IPS 2',
      homeroomTeacher: 'Dian Pertiwi, S.E',
      subject: 'IPS',
      studentCount: 30,
      schoolYear: '2025/2026',
    ),
    ClassData(
      name: 'XII IPA 1',
      homeroomTeacher: 'Aulia Firdaus, S.Pd',
      subject: 'IPA',
      studentCount: 31,
      schoolYear: '2025/2026',
    ),
  ];

  List<ClassData> get _filteredClasses {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) return _classes;
    return _classes.where((item) {
      return item.name.toLowerCase().contains(query) ||
          item.homeroomTeacher.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleCount = _filteredClasses.length;
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.adminBluePrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(AppIcons.arrowBack, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Data Kelas'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: const BoxDecoration(
                color: AppColors.adminBluePrimary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$visibleCount kelas - TA 2025/2026',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.black45),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              hintText: 'Cari kelas atau wali kelas...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: _filteredClasses.isEmpty
                    ? Center(
                        child: Text(
                          'Tidak ditemukan kelas.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    : ListView.separated(
                        itemCount: _filteredClasses.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = _filteredClasses[index];
                          return _ClassCard(item: item);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassData {
  final String name;
  final String homeroomTeacher;
  final String subject;
  final int studentCount;
  final String schoolYear;

  ClassData({
    required this.name,
    required this.homeroomTeacher,
    required this.subject,
    required this.studentCount,
    required this.schoolYear,
  });
}

class _ClassCard extends StatelessWidget {
  const _ClassCard({required this.item, super.key});

  final ClassData item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _buildAbbreviation(item.name),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Wali: ${item.homeroomTeacher}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: item.subject == 'IPA'
                        ? const Color(0xFFEAF4FF)
                        : const Color(0xFFFFF4E6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item.subject,
                    style: TextStyle(
                      color: item.subject == 'IPA'
                          ? const Color(0xFF0B4DCA)
                          : const Color(0xFFB15C00),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _InfoChip(
                  icon: AppIcons.people,
                  label: '${item.studentCount} siswa',
                ),
                const SizedBox(width: 8),
                _InfoChip(icon: AppIcons.school, label: item.schoolYear),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _buildAbbreviation(String className) {
    final parts = className.split(' ');
    if (parts.isEmpty) return className;
    if (parts[0].length <= 2) return parts[0];
    return parts[0].substring(0, 2).toUpperCase();
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label, super.key});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FB),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: Colors.black45),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
