import 'package:flutter/material.dart';
import '../../../core/widgets/wastehub_bottom_nav.dart';
import '../../catalog/screens/catalog_screen.dart';
import '../../monitoring/screens/logistics_tracking_screen.dart';
import '../../negotiation/screens/negotiation_inbox_screen.dart';
import '../../notifications/screens/notification_center_screen.dart';
import '../../profile/screens/user_profile_screen.dart';
import '../../transaction/screens/transaction_list_screen.dart';

class BusinessDashboardScreen extends StatefulWidget {
  const BusinessDashboardScreen({super.key});

  @override
  State<BusinessDashboardScreen> createState() =>
      _BusinessDashboardScreenState();
}

class _BusinessDashboardScreenState extends State<BusinessDashboardScreen> {
  final int _currentNavIndex = 3; // Tab 3: Bisnis

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Profile Header Card
            _buildCompanyCard(),
            const SizedBox(height: 14),

            // Escrow Balance & Financial Summary
            _buildEscrowFinancialCard(context),
            const SizedBox(height: 14),

            // ESG & Circular Economy Impact
            _buildEsgImpactCard(),
            const SizedBox(height: 14),

            // Warehouse & Facility Utilization
            _buildWarehouseFacilityCard(),
            const SizedBox(height: 14),

            // Enterprise Settings & Certifications
            _buildEnterpriseQuickActions(context),
          ],
        ),
      ),
      bottomNavigationBar: WasteHubBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          if (index == 0) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const CatalogScreen()),
              );
            }
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const TransactionListScreen(),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const NegotiationInboxScreen(),
              ),
            );
          }
        },
      ),
    );
  }

  // ---------------------------------------------------------
  // APP BAR
  // ---------------------------------------------------------
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF0A4D3C),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.apartment_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Profil Bisnis & Fasilitas',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: Color(0xFF334155),
            size: 22,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NotificationCenterScreen(),
              ),
            );
          },
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UserProfileScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            margin: const EdgeInsets.only(right: 16, left: 4),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF1F5F9),
              border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2),
            ),
            child: const Center(
              child: Text(
                'WH',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0A4D3C),
                ),
              ),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: const Color(0xFFE2E8F0),
          height: 1,
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // COMPANY PROFILE CARD
  // ---------------------------------------------------------
  Widget _buildCompanyCard() {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'WI',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF166534),
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
                      children: const [
                        Flexible(
                          child: Text(
                            'PT WasteHub Industri Indonesia',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.verified,
                          size: 14,
                          color: Color(0xFF0A4D3C),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Pabrik Peleburan & Offtaker Resmi • NIB: 0220008819281',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _buildVerificationTag('NIB Terverifikasi', true),
                        const SizedBox(width: 6),
                        _buildVerificationTag('PROPER Hijau', true),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(color: Color(0xFFF1F5F9), height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 15,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'Kawasan Industri KIIC Lot C-4, Karawang Barat, Jawa Barat',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationTag(String text, bool verified) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            size: 11,
            color: Color(0xFF166534),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF166534),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // ESCROW FINANCIAL CARD
  // ---------------------------------------------------------
  Widget _buildEscrowFinancialCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0A4D3C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 16,
                    color: Colors.white70,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Saldo Escrow Operasional',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Bank Mandiri (VA)',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Rp 184.250.000',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            '4 transaksi aktif • Terproteksi Asuransi B2B',
            style: TextStyle(
              fontSize: 10.5,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Buka halaman Top Up Saldo Escrow Bank Terintegrasi'),
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_circle_outline_rounded,
                      size: 15, color: Color(0xFF0A4D3C)),
                  label: const Text(
                    'Top Up Escrow',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A4D3C),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Menampilkan mutasi & riwayat pencairan dana'),
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.receipt_long_outlined,
                      size: 15, color: Colors.white),
                  label: const Text(
                    'Riwayat Dana',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // ESG & CIRCULAR ECONOMY CARD
  // ---------------------------------------------------------
  Widget _buildEsgImpactCard() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Dampak Keberlanjutan (ESG)',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0A4D3C),
                ),
              ),
              Icon(Icons.eco_rounded, size: 16, color: Color(0xFF16A34A)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildEsgMetricItem(
                  title: 'Material Terdiversi',
                  value: '48,5 Ton',
                  subtitle: 'Dari TPA ke Industri',
                  color: const Color(0xFF0A4D3C),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildEsgMetricItem(
                  title: 'Reduksi Karbon',
                  value: '72,8 Ton',
                  subtitle: 'CO₂ Equivalent Terhindar',
                  color: const Color(0xFF15803D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEsgMetricItem({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // WAREHOUSE FACILITY CARD
  // ---------------------------------------------------------
  Widget _buildWarehouseFacilityCard() {
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
          const Text(
            'Utilisasi Fasilitas Gudang',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Gudang Hub Karawang (Kapasitas 120 Ton)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                '78% Penuh',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFB45309),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 0.78,
              minHeight: 8,
              backgroundColor: const Color(0xFFF1F5F9),
              color: const Color(0xFFD97706),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Kapasitas tersisa 26,4 Ton untuk pengiriman masuk minggu ini',
            style: TextStyle(
              fontSize: 10.5,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LogisticsTrackingScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.local_shipping_outlined,
                  size: 15, color: Color(0xFF0A4D3C)),
              label: const Text(
                'Lacak Pengiriman Aktif (Truk B 9241 UZ)',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0A4D3C),
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // QUICK ENTERPRISE ACTIONS
  // ---------------------------------------------------------
  Widget _buildEnterpriseQuickActions(BuildContext context) {
    return Column(
      children: [
        _buildActionTile(
          icon: Icons.badge_outlined,
          title: 'Sertifikasi Mutu & Legalitas NIB',
          subtitle: 'Sucofindo, ISO 14001, SK KLHK & Kemenperin',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UserProfileScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        _buildActionTile(
          icon: Icons.integration_instructions_outlined,
          title: 'Integrasi Webhook ERP Pabrik',
          subtitle: 'Sinkronisasi otomatis dengan SAP, Odoo, atau Oracle ERP',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Buka API Key & Konfigurasi Webhook SAP/Odoo'),
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        _buildActionTile(
          icon: Icons.support_agent_rounded,
          title: 'Account Manager Industri Prioritas',
          subtitle: 'Hubungi tim bantuan B2B WasteHub (WhatsApp & Hotline)',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Menghubungkan ke B2B Priority Support WasteHub'),
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 18, color: const Color(0xFF0A4D3C)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 1),
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
            const Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }
}
