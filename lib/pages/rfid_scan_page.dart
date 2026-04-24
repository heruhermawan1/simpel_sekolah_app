import 'package:flutter/material.dart';
import'rfid_scan_page.dart';
import'../constants/app_constants.dart';

class RfidAttendancePage extends StatelessWidget {
  const RfidAttendancePage({super.key});

  final List<RFIDStudent> _students = const [
    RFIDStudent(
      name: 'Heru Hermawan',
      kelas: 'XI IPA 1',
      alamat: 'JL. Rawadas No. 157, Jakarta'
      code: '0012270021,187,14789',
    ),
    RFIDStudent(
      name: 'Ilham Maulana',
      kelas: 'XI IPA 1',
      alamat: 'JL. Bintara 14 No. 8, Bandung'
      code: '0012348117,188,27349',
    ),
    RFIDStudent(
      name: 'Djoko Fezatirta',
      kelas: 'XI IPS 2',
      alamat: 'JL. Mawar Merah No. 5, Bogor'
      code: '0012286523,187,31291',
    ),
    RFIDStudent(
      name: 'Nurhasan Sholeh',
      kelas: 'XI IPS 2',
      alamat: 'JL. Sukar Jaya No. 21, Cikarang'
      code: '0012308455,187,53223',
    ),
    RFIDStudent(
      name: 'Syahril Siregar',
      kelas: 'XI IPA 1',
      alamat: 'JL. Bintara 12 No. 7, Jakarta Timur'
      code: '0012425525,189,39221',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('RFID'),
        backgroundColor:AppColors.adminBluePrimary,
        Elevation: 0,

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const[
                    Text(
                      'Contoh halaman RFID',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Sistem membaca kartu RFID siswa dan menampilkan data siswa secara cepat.',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              
const SizedBox(height: 18),
           Expanded(
            child: ListView.separated(
              itemCount: _students.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final student = _students[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.adminBluePrimary,
                        child: const Text(
                          student.initials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        )
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
                            const SizedBox(height: 6),
                            Text(
                              student.kelas,
                              style: const TextStyle(color: Colors.black87, fontSize: 13,),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'kode RFID: ${student.code}',
                              style: const TextStyle(color: Colors.black54, fontSize: 12,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RFIDScanPage(),
                    ),
                  );
                },
                child: const Text(
                  'Buka Scanner RFID'),
                ),
            ],
          ),   
        ),
      ),
    );
  }
}
class RFIDStudent {
  final String name;
  final String kelas;
  final String alamat;
  final String code;

  const RFIDStudent({
    required this.name,
    required this.kelas,
    required this.alamat,
    required this.code,
  });

  String get initials {
    final names = name.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } 
    return name.substring(0, 1).toUpperCase();
    }
  }

            
  

