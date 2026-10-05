import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final String companyName;
  final String entityType;
  final String nibNumber;
  final String address;
  final String picName;
  final String picRole;
  final String email;
  final String phone;

  const UserProfileScreen({
    super.key,
    this.companyName = 'PT Circular Recycler Indonesia',
    this.entityType = 'Industri Manufaktur Daur Ulang (Recycler Utama)',
    this.nibNumber = '9120003418902',
    this.address = 'Kawasan Industri Jababeka V Blok C-12, Cikarang, Jawa Barat',
    this.picName = 'Budi Santoso, ST',
    this.picRole = 'VP Procurement & Raw Material',
    this.email = 'procurement@circular-recycler.co.id',
    this.phone = '+62 21-8983-2000',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Identification Hero Card
            _buildCompanyHeroCard(),
            const SizedBox(height: 14),

            // Legal & Regulatory Compliance
            _buildLegalCertificationsCard(context),
            const SizedBox(height: 14),

            // PIC & User Credentials
            _buildPicCredentialsCard(),
            const SizedBox(height: 14),

            // Security & Digital Signatures (PrivyID & Peruri)
            _buildSecuritySettingsCard(context),
            const SizedBox(height: 20),

            // Action Buttons (Switch Entity / Logout)
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded,
            color: Color(0xFF0F172A), size: 22),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: const Text(
        'Profil Perusahaan & Legalitas',
        style: TextStyle(
          fontSize: 15.5,
          fontWeight: FontWeight.w800,
          color: Color(0xFF0F172A),
          letterSpacing: -0.3,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: const Color(0xFFE2E8F0), height: 1),
      ),
    );
  }

  Widget _buildCompanyHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Logo Box
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A4D3C),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    'CR',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            companyName,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.verified,
                            size: 16, color: Color(0xFF059669)),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      entityType,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                _buildInfoRow('Nomor Induk Berusaha (NIB)', nibNumber,
                    isVerified: true),
                const Divider(height: 14, color: Color(0xFFE2E8F0)),
                _buildInfoRow('Status OSS RBA', 'Terverifikasi Berisiko Menengah-Tinggi',
                    highlightColor: const Color(0xFF059669)),
                const Divider(height: 14, color: Color(0xFFE2E8F0)),
                _buildInfoRow('Domisili Fasilitas', address),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {bool isVerified = false, Color? highlightColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: highlightColor ?? const Color(0xFF0F172A),
                  ),
                ),
              ),
              if (isVerified) ...[
                const SizedBox(width: 4),
                const Icon(Icons.check_circle_rounded,
                    size: 13, color: Color(0xFF16A34A)),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegalCertificationsCard(BuildContext context) {
    final certs = [
      {
        'title': 'Izin Pengelolaan Limbah Non-B3 (KLHK RI)',
        'number': 'SK.MENLHK/PSLB3/2024/0981',
        'status': 'Aktif s/d 2029',
      },
      {
        'title': 'Sertifikat Standar Industri Hijau (Kemenperin)',
        'number': 'SIH-IND-2025-4410',
        'status': 'Terakreditasi BSN',
      },
      {
        'title': 'ISO 14001:2015 (Environmental Management)',
        'number': 'ISO-14001-ID-88219',
        'status': 'Sucofindo Certified',
      },
      {
        'title': 'Sertifikat Verifikasi Legalitas Kayu/Kertas (SVLK)',
        'number': 'SVLK-KEMENLHK-002194',
        'status': 'Lulus Audit 2026',
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.workspace_premium_outlined,
                      size: 18, color: Color(0xFF0A4D3C)),
                  SizedBox(width: 6),
                  Text(
                    'Sertifikasi & Kepatuhan Regulasi',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Text(
                '${certs.length} Terdaftar',
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0A4D3C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          ...certs.map((c) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c['title']!,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              c['number']!,
                              style: const TextStyle(
                                fontSize: 9.5,
                                color: Color(0xFF64748B),
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          c['status']!,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF166534),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPicCredentialsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Penanggung Jawab Akun (PIC Terdaftar)',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          _buildInfoRow('Nama Lengkap', picName),
          const Divider(height: 14, color: Color(0xFFE2E8F0)),
          _buildInfoRow('Jabatan / Departemen', picRole),
          const Divider(height: 14, color: Color(0xFFE2E8F0)),
          _buildInfoRow('Email Resmi Korporat', email),
          const Divider(height: 14, color: Color(0xFFE2E8F0)),
          _buildInfoRow('Nomor Kontak', phone),
        ],
      ),
    );
  }

  Widget _buildSecuritySettingsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Keamanan & Tanda Tangan Elektronik',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          _buildSecurityRow(
            icon: Icons.fingerprint_rounded,
            title: 'Sertifikat Digital PrivyID / Peruri',
            subtitle: 'Tersumpah & Diakui Kominfo untuk Pengesahan e-MoA',
            badge: 'AKTIF',
            badgeColor: const Color(0xFF059669),
          ),
          const Divider(height: 14, color: Color(0xFFE2E8F0)),
          _buildSecurityRow(
            icon: Icons.lock_outline_rounded,
            title: 'Otentikasi Dua Faktor (2FA)',
            subtitle: 'Verifikasi SMS / Telegram saat pencairan Escrow',
            badge: 'TERPROTEKSI',
            badgeColor: const Color(0xFF059669),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required String badge,
    required Color badgeColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF0A4D3C)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFDCFCE7),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            badge,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: badgeColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Color(0xFF0A4D3C),
                  content: Text(
                    'Akun Anda terhubung dengan 2 entitas pabrik: Cikarang & Karawang.',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.swap_horiz_rounded,
                size: 18, color: Color(0xFF0A4D3C)),
            label: const Text(
              'Ganti Entitas Anak Perusahaan',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0A4D3C),
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        SizedBox(
          width: double.infinity,
          height: 44,
          child: TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Keluar dari Sesi?'),
                  content: const Text(
                    'Anda akan keluar dari sesi enterprise PT Circular Recycler Indonesia.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Batal'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC2626),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pop(context);
                      },
                      child: const Text('Keluar'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout_rounded,
                size: 16, color: Color(0xFFDC2626)),
            label: const Text(
              'Keluar dari Sesi (Logout)',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFFDC2626),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
