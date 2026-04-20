import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class QRCodeAttendancePage extends StatelessWidget {
    const QRCodeAttendancePage({super.key});

    @verride
    Widget build(BuildContext context) {
       return Scaffold(
         backgroundColor: AppColors.backgroundLight,
         appBar: AppBar(
            title: const Text('QR Code'),
            background: AppColors.adminBluePrimary,
            elevation: 0,
         ),
         body: SafeArea(
            child: Padding(
               padding: const EdgeInsets.all(16),
               child: Column(
                 crossAxisAligment: CrossAxisAligment.stretch,
                 children: [
                    const SizedBox(height: 24),
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
                        mainAxisAligment: MainAxisAligment.center,
                        children: const [
                          Icon(
                            Icons.qr_code,
                            size: 72,
                            color: AppColors.adminBluePrimary,
                          ),
                          SizeBox(height: 20),
                          Text(
                            'Contoh halamam QR Code',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          SizeBox(height: 12),
                          Text(
                            'Arahkan kamera ke QR Code siswa untuk melakukan absensi.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizeBox(height: 24),
                    ElevetedButton(
                      style: ElevetedButton,styleForm(
                        backgroundColor: const Size.adminBluePrimary,
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Contoh Scan QR'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }    
      }