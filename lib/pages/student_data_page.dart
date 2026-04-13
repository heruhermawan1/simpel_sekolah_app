import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class StudentDataPage extends StatefulWidget {
  const StudentDataPage({super.key});

  @override
  State<StudentDataPage> createState() => _StudentDataPageState();
}

class _StudentDataPageState extends State<StudentDataPage> {
  final _searchController = TextEditingController();
  String _selectedClass = 'Semua';

  final List<StudentData> _students = [
    StudentData(
      name: 'Heru Hermawan',
      nis: '2024001',
      kelas: 'XI IPA 1',
      jurusan: 'IPA',
      gender: 'Laki-laki',
      status: 'aktif',
    ),
    StudentData(
      name: 'Rado Hikawa Saragih',
      nis: '2024002',
      kelas: 'XI IPA 1',
      jurusan: 'IPA',
      gender: 'Laki-laki',
      status: 'aktif',
    ),
    StudentData(
      name: 'Djoko Fezatirta',
      nis: '2024003',
      kelas: 'XI IPS 2',
      jurusan: 'IPS',
      gender: 'Laki-laki',
      status: 'aktif',
    ),
    StudentData(
      name: 'Ilham Fauji',
      nis: '2024004',
      kelas: 'X IPA 1',
      jurusan: 'IPA',
      gender: 'Laki-laki',
      status: 'aktif',
    ),
    StudentData(
      name: 'Niko Aji Nugroho',
      nis: '2024005',
      kelas: 'XII IPA 1',
      jurusan: 'IPA',
      gender: 'Laki-laki',
      status: 'aktif',
    ),
        StudentData(
      name: 'Rafly Ramadhan Ananda Rusli',
      nis: '2024123',
      kelas: 'XII IPA 1',
      jurusan: 'IPA',
      gender: 'Laki-laki',
      status: 'aktif',
    ),
  ];

  List<StudentData> get _filteredStudents {
    final query = _searchController.text.toLowerCase().trim();
    return _students.where((student) {
      if (_selectedClass != 'Semua' && student.kelas != _selectedClass) {
        return false;
      }
      if (query.isEmpty) return true;
      return student.name.toLowerCase().contains(query) ||
          student.nis.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterOptions = [
      'Semua',
      'XI IPA 1',
      'XI IPS 2',
      'X IPA 1',
      'XII IPA 1',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.adminBluePrimary,
        title: const Text('Data Siswa'),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kelola semua data siswa aktif di sekolah Anda.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black87),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Cari nama atau NIS...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: filterOptions.map((option) {
                    final selected = option == _selectedClass;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(option),
                        selected: selected,
                        selectedColor: AppColors.adminBluePrimary,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: selected ? Colors.white : Colors.black87,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                        elevation: 2,
                        onSelected: (_) {
                          setState(() {
                            _selectedClass = option;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _filteredStudents.isEmpty
                    ? Center(
                        child: Text(
                          'Tidak ada siswa yang cocok.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    : ListView.separated(
                        itemCount: _filteredStudents.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final student = _filteredStudents[index];
                          return StudentCard(student: student);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentData {
  final String name;
  final String nis;
  final String kelas;
  final String jurusan;
  final String gender;
  final String status;

  StudentData({
    required this.name,
    required this.nis,
    required this.kelas,
    required this.jurusan,
    required this.gender,
    required this.status,
  });
}

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.student});

  final StudentData student;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF0B4DCA),
                child: Text(
                  student.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'NIS: ${student.nis}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: student.status == 'aktif'
                      ? const Color(0xFFE8F7E9)
                      : const Color(0xFFFFEBE6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  student.status,
                  style: TextStyle(
                    color: student.status == 'aktif'
                        ? const Color(0xFF1B7A3E)
                        : const Color(0xFFC62828),
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
              _InfoPill(label: student.kelas, icon: AppIcons.groups),
              const SizedBox(width: 8),
              _InfoPill(label: student.jurusan, icon: AppIcons.school),
              const SizedBox(width: 8),
              _InfoPill(label: student.gender, icon: AppIcons.person),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: Colors.black54),
            const SizedBox(width: 6),
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
