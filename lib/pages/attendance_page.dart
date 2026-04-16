import 'package:flutter/material.dart';
import 'face_attendance_page.dart';
import 'manual_attendance_page.dart';
import 'qr_code_attendance_page.dart';
import 'rfid_scan_page.dart';
import '../constants/app_constants.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final _searchController = TextEditingController();
  int _activeTabIndex = 0;
  String _selectedMethod = 'RFID';
  String _selectedStatus = 'Hadir';
  int _selectedStudentIndex = 0;

  final List<AttendanceRecord> _records = [
    AttendanceRecord(
      name: 'Ilham Fauji',
      kelas: 'XI IPA 1',
      status: 'HADIR',
      date: '2025-04-07',
      time: '06:55',
      source: 'QR',
    ),
    AttendanceRecord(
      name: 'Niko Aji Nugroho',
      kelas: 'XI IPA 1',
      status: 'HADIR',
      date: '2025-04-07',
      time: '07:02',
      source: 'RFID',
    ),
    AttendanceRecord(
      name: 'Rafly Ramadhan Ananda Rusli',
      kelas: 'XI IPS 2',
      status: 'SAKIT',
      date: '2025-04-07',
      time: 'MANUAL',
      source: 'Demam',
    ),
    AttendanceRecord(
      name: 'Ahmad Kusuma',
      kelas: 'XI IPA 1',
      status: 'IZIN',
      date: '2025-04-06',
      time: 'MANUAL',
      source: 'Keluarga',
    ),
    AttendanceRecord(
      name: 'Natasya Putri',
      kelas: 'X IPA 1',
      status: 'HADIR',
      date: '2025-04-06',
      time: '07:10',
      source: 'QR',
    ),
  ];

  final List<StudentItem> _students = [
    StudentItem(name: 'Ilham Fauji', nis: '2024001', kelas: 'XI IPA 1'),
    StudentItem(name: 'Niko Aji Nugroho', nis: '2024002', kelas: 'XI IPA 1'),
    StudentItem(name: 'Rafly Ramadhan Ananda Rusli', nis: '2024003', kelas: 'XI IPS 2'),
  ];

  void _addAttendanceRecord(String name, String kelas) {
    final now = DateTime.now();
    final formattedDate =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final formattedTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    setState(() {
      _records.insert(
        0,
        AttendanceRecord(
          name: name,
          kelas: kelas,
          status: 'HADIR',
          date: formattedDate,
          time: formattedTime,
          source: 'RFID',
        ),
      );
    });
  }

  List<AttendanceRecord> get _filteredRecords {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) return _records;
    return _records.where((record) {
      return record.name.toLowerCase().contains(query) ||
          record.kelas.toLowerCase().contains(query);
    }).toList();
  }

  List<StudentItem> get _filteredStudents {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) return _students;
    return _students.where((student) {
      return student.name.toLowerCase().contains(query) ||
          student.nis.toLowerCase().contains(query) ||
          student.kelas.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.adminBluePrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(AppIcons.arrowBack, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Absensi Digital'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.adminBluePrimary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildTabButton('Rekap', 0)),
                      const SizedBox(width: 10),
                      Expanded(child: _buildTabButton('Input Absensi', 1)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
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
                            style: const TextStyle(color: Colors.black87),
                            decoration: const InputDecoration(
                              hintText: 'Cari nama atau kelas...',
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
              child: Container(
                color: AppColors.backgroundLight,
                child: _activeTabIndex == 0
                    ? _buildRecapList()
                    : _buildInputList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final selected = index == _activeTabIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTabIndex = index;
        });
      },
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white.withAlpha(200),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.adminBluePrimary : Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildRecapList() {
    final records = _filteredRecords;
    return records.isEmpty
        ? Center(
            child: Text(
              'Tidak ada absensi yang sesuai.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: records.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return AttendanceCard(record: records[index]);
            },
          );
  }

  Widget _buildInputList() {
    final students = _filteredStudents;
    final methods = [
      {'label': 'QR Code', 'icon': Icons.qr_code},
      {'label': 'RFID', 'icon': Icons.credit_card},
      {'label': 'Wajah', 'icon': Icons.face},
      {'label': 'Manual', 'icon': Icons.edit},
    ];
    final statuses = ['Hadir', 'Sakit', 'Izin', 'Alpha'];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Metode Absensi',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: methods.map((method) {
              final label = method['label'] as String;
              final icon = method['icon'] as IconData;
              final selected = label == _selectedMethod;

              void openMethodPage() {
                Widget page;
                switch (label) {
                  case 'QR Code':
                    page = const QRCodeAttendancePage();
                    break;
                  case 'RFID':
                    page = RFIDScanPage(onScan: _addAttendanceRecord);
                    break;
                  case 'Wajah':
                    page = const FaceAttendancePage();
                    break;
                  default:
                    page = const ManualAttendancePage();
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              }

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedMethod = label);
                  openMethodPage();
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width - 64) / 2,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white
                        : Colors.white.withAlpha(230),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selected
                          ? AppColors.adminBluePrimary
                          : Colors.transparent,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        icon,
                        size: 28,
                        color: selected
                            ? AppColors.adminBluePrimary
                            : Colors.black54,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        label,
                        style: TextStyle(
                          color: selected
                              ? AppColors.adminBluePrimary
                              : Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 22),
          const Text(
            'Pilih Siswa',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ...students.asMap().entries.map((entry) {
            final index = entry.key;
            final student = entry.value;
            final selected = index == _selectedStudentIndex;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => setState(() => _selectedStudentIndex = index),
                child: Container(
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white
                        : Colors.white.withAlpha(230),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selected
                          ? AppColors.adminBluePrimary
                          : Colors.transparent,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.adminBluePrimary,
                        child: Text(
                          student.name.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${student.nis} • ${student.kelas}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          const Text(
            'Status Kehadiran',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Row(
            children: statuses.map((status) {
              final selected = status == _selectedStatus;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selected
                          ? AppColors.adminBluePrimary
                          : Colors.white,
                      foregroundColor: selected ? Colors.white : Colors.black87,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: selected
                              ? Colors.transparent
                              : Colors.grey.withOpacity(0.25),
                        ),
                      ),
                    ),
                    onPressed: () => setState(() => _selectedStatus = status),
                    child: Text(status),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.adminBluePrimary,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {},
            child: const Text('Simpan Absensi'),
          ),
        ],
      ),
    );
  }
}

class AttendanceRecord {
  final String name;
  final String kelas;
  final String status;
  final String date;
  final String time;
  final String source;

  AttendanceRecord({
    required this.name,
    required this.kelas,
    required this.status,
    required this.date,
    required this.time,
    required this.source,
  });
}

class StudentItem {
  final String name;
  final String nis;
  final String kelas;

  StudentItem({required this.name, required this.nis, required this.kelas});
}

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({super.key, required this.record});

  final AttendanceRecord record;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(record.status);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      record.kelas,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  record.status,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                record.date,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(width: 14),
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                record.time,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(width: 14),
              const Icon(Icons.qr_code, size: 14, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                record.source,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toUpperCase()) {
      case 'HADIR':
        return const Color(0xFF1B7A3E);
      case 'SAKIT':
        return const Color(0xFFB56E00);
      case 'IZIN':
        return const Color(0xFF1976D2);
      default:
        return const Color(0xFF616161);
    }
  }
}