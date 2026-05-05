import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class RFIDScanPage extends StatefulWidget {
  final void Function(String name, String kelas) onScan;

  const RFIDScanPage({super.key, required this.onScan});

  @override
  State<RFIDScanPage> createState() => _RFIDScanPageState();
}

class _RFIDScanPageState extends State<RFIDScanPage> {
  final _codeController = TextEditingController();
  final _focusNode = FocusNode();
  String _scanResult =
      'Siap menerima scan RFID. Pastikan fokus di field input.';
  RFIDStudent? _matchedStudent;

  static const List<RFIDStudent> _students = [
    RFIDStudent(
      name: 'Heru Hermawan',
      kelas: 'XI IPA 1',
      alamat: 'Jl. Merpati No. 12, Medan',
      code: '0012270021,187,14789',
    ),
    RFIDStudent(
      name: 'Ilham Maulana',
      kelas: 'XI IPA 1',
      alamat: 'Jl. Garuda No. 8, Medan',
      code: '0012348117,188,27349',
    ),
    RFIDStudent(
      name: 'Djoko Fezatirta',
      kelas: 'XI IPS 2',
      alamat: 'Jl. Kencana No. 5, Medan',
      code: '0012286523,187,31291',
    ),
    RFIDStudent(
      name: 'Nurhasan Sholeh',
      kelas: 'XI IPS 2',
      alamat: 'Jl. Sakura No. 21, Medan',
      code: '0012308455,187,53223',
    ),
    RFIDStudent(
      name: 'Syahril Siregar',
      kelas: 'XI IPA 1',
      alamat: 'Jl. Mawar No. 7, Medan',
      code: '0012425525,189,39221',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _normalizeCode(String code) {
    return code.replaceAll(RegExp(r'[^0-9]'), '');
  }

  void _processScan(String code) {
    final cleaned = _normalizeCode(code);
    if (cleaned.isEmpty) {
      setState(() {
        _scanResult = 'Tidak ada kode RFID yang terbaca.';
        _matchedStudent = null;
      });
      return;
    }

    final student = _students.firstWhere((item) {
      final normalizedItem = _normalizeCode(item.code);
      final normalizedFirstSegment = _normalizeCode(item.code.split(',').first);
      return normalizedItem == cleaned ||
          normalizedFirstSegment == cleaned ||
          normalizedItem.startsWith(cleaned) ||
          cleaned.startsWith(normalizedItem);
    }, orElse: () => RFIDStudent.notFound());

    setState(() {
      if (student.isFound) {
        _matchedStudent = student;
        _scanResult = 'Hadir: ${student.name} terinput ke absensi.';
        widget.onScan(student.name, student.kelas);
      } else {
        _matchedStudent = null;
        _scanResult = 'Kode RFID tidak dikenali: $code';
      }
      _codeController.clear();
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Scanner RFID'),
        backgroundColor: AppColors.adminBluePrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.credit_card,
                              size: 72,
                              color: AppColors.adminBluePrimary,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Letakkan fokus di kotak input, lalu scan kartu RFID Anda.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Kartu RFID yang dipindai oleh mesin akan langsung terbaca di sini.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        focusNode: _focusNode,
                        controller: _codeController,
                        autofocus: true,
                        textInputAction: TextInputAction.done,
                        onSubmitted: _processScan,
                        decoration: InputDecoration(
                          labelText: 'Kode RFID',
                          hintText: 'Scan kartu RFID di sini',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.adminBluePrimary,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () => _processScan(_codeController.text),
                        child: const Text('Proses Scan'),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hasil Scan',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _scanResult,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_matchedStudent != null) ...[
                        _buildStudentCard(_matchedStudent!),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentCard(RFIDStudent student) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.adminBluePrimary,
            child: Text(
              student.initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
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
                  student.kelas,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 12),
                Text(
                  'Alamat: ${student.alamat}',
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  'Kode RFID: ${student.code}',
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RFIDStudent {
  final String name;
  final String kelas;
  final String alamat;
  final String code;
  final bool isFound;

  const RFIDStudent({
    required this.name,
    required this.kelas,
    required this.alamat,
    required this.code,
  }) : isFound = true;

  const RFIDStudent.notFound()
    : name = '',
      kelas = '',
      alamat = '',
      code = '',
      isFound = false;

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isEmpty ? '' : name[0].toUpperCase();
  }
}
