import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const navy = Color(0xFF102B50);
const blue = Color(0xFF24558A);
const lightBlue = Color(0xFFEAF3FC);
const background = Color(0xFFF4F7FC);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pendaftaran Organisasi',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
      ),
      home: const FormPendaftaran(),
    );
  }
}

class FormPendaftaran extends StatefulWidget {
  const FormPendaftaran({super.key});

  @override
  State<FormPendaftaran> createState() => _FormPendaftaranState();
}

class _FormPendaftaranState extends State<FormPendaftaran> {
  final formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? jenisKelamin;
  String? programStudi;
  bool tampilPassword = false;

  List<String> minat = [];

  final pilihanMinat = [
    'Kominfo',
    'Kesejahteraan dan Sosial',
    'Sumber Daya Manusia',
    'Kreatif',
    'Minat dan Bakat',
  ];

  final pilihanProdi = [
    'Informatika',
    'Teknologi Pangan',
    'Manajemen',
    'Akuntansi',
    'Pendidikan',
  ];

  @override
  void dispose() {
    namaController.dispose();
    nimController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void simpanData() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (jenisKelamin == null ||
        minat.isEmpty ||
        programStudi == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi semua pilihan terlebih dahulu!'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 55,
              ),
              SizedBox(height: 10),
              Text(
                'Pendaftaran Berhasil!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: navy,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                hasil('Nama Lengkap', namaController.text),
                hasil('NIM', nimController.text),
                hasil('Email', emailController.text),
                hasil('Jenis Kelamin', jenisKelamin!),
                hasil('Minat Bidang', minat.join(', ')),
                hasil('Program Studi', programStudi!),
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: navy,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Selesai'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget hasil(String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 13,
          ),
          children: [
            TextSpan(
              text: '$judul\n',
              style: const TextStyle(
                color: blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: isi),
          ],
        ),
      ),
    );
  }

  Widget judulBagian(String teks, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: blue, size: 22),
          const SizedBox(width: 9),
          Text(
            teks,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
        ],
      ),
    );
  }

  Widget inputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool password = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: password && !tampilPassword,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: blue),
          suffixIcon: password
              ? IconButton(
                  icon: Icon(
                    tampilPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: blue,
                  ),
                  onPressed: () {
                    setState(() {
                      tampilPassword = !tampilPassword;
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFDCE6F2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: blue,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 35, 24, 35),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [navy, blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/logo_organisasi.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.groups_rounded,
                            size: 55,
                            color: navy,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 17),
                    const Text(
                      'FORMULIR PENDAFTARAN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'ANGGOTA ORGANISASI MAHASISWA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Bergabung dan kembangkan potensimu bersama kami!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      judulBagian(
                        'Data Diri',
                        Icons.person_outline,
                      ),

                      inputField(
                        label: 'Nama Lengkap',
                        icon: Icons.person,
                        controller: namaController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama lengkap wajib diisi';
                          }
                          return null;
                        },
                      ),

                      inputField(
                        label: 'NIM',
                        icon: Icons.badge_outlined,
                        controller: nimController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'NIM wajib diisi';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'NIM harus berupa angka';
                          }
                          if (value.length < 8) {
                            return 'NIM minimal 8 digit';
                          }
                          return null;
                        },
                      ),

                      inputField(
                        label: 'Email',
                        icon: Icons.email_outlined,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email wajib diisi';
                          }
                          if (!RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          ).hasMatch(value)) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                      ),

                      inputField(
                        label: 'Password',
                        icon: Icons.lock_outline,
                        controller: passwordController,
                        password: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password wajib diisi';
                          }
                          if (value.length < 8) {
                            return 'Password minimal 8 karakter';
                          }
                          return null;
                        },
                      ),

                      judulBagian(
                        'Jenis Kelamin',
                        Icons.wc_outlined,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFDCE6F2),
                          ),
                        ),
                        child: Column(
                          children: [
                            RadioListTile<String>(
                              title: const Text('Laki-laki'),
                              value: 'Laki-laki',
                              groupValue: jenisKelamin,
                              activeColor: blue,
                              onChanged: (value) {
                                setState(() {
                                  jenisKelamin = value;
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text('Perempuan'),
                              value: 'Perempuan',
                              groupValue: jenisKelamin,
                              activeColor: blue,
                              onChanged: (value) {
                                setState(() {
                                  jenisKelamin = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      judulBagian(
                        'Minat Bidang',
                        Icons.interests_outlined,
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFDCE6F2),
                          ),
                        ),
                        child: Column(
                          children: pilihanMinat.map((bidang) {
                            return CheckboxListTile(
                              title: Text(
                                bidang,
                                style: const TextStyle(fontSize: 14),
                              ),
                              value: minat.contains(bidang),
                              activeColor: blue,
                              controlAffinity:
                                  ListTileControlAffinity.leading,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    minat.add(bidang);
                                  } else {
                                    minat.remove(bidang);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),

                      judulBagian(
                        'Program Studi',
                        Icons.school_outlined,
                      ),

                      DropdownButtonFormField<String>(
                        value: programStudi,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: 'Pilih Program Studi',
                          prefixIcon: const Icon(
                            Icons.school,
                            color: blue,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Color(0xFFDCE6F2),
                            ),
                          ),
                        ),
                        items: pilihanProdi.map((prodi) {
                          return DropdownMenuItem(
                            value: prodi,
                            child: Text(prodi),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            programStudi = value;
                          });
                        },
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton.icon(
                          onPressed: simpanData,
                          icon: const Icon(Icons.save_outlined),
                          label: const Text(
                            'SIMPAN PENDAFTARAN',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 0.5,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: navy,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Center(
                        child: Text(
                          'Formulir Pendaftaran Organisasi Mahasiswa',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 11,
                          ),
                        ),
                      ),
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
}
