import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../monitoring/screens/logistics_tracking_screen.dart';

class TransactionSuccessScreen extends StatelessWidget {
  final String contractNumber;
  final String spkNumber;
  final String edoNumber;
  final String doToken;
  final String truckType;
  final String licensePlate;
  final String driverName;
  final String driverId;
  final String commodityName;
  final String commodityCategory;
  final String specs;
  final int tonnageKg;
  final int pricePerKg;

  const TransactionSuccessScreen({
    super.key,
    this.contractNumber = 'WH-CTR-2026-8941',
    this.spkNumber = 'SPK-0842/WH/X',
    this.edoNumber = '#eDO-2026-X81-JKT',
    this.doToken = '8A29-CX-2826',
    this.truckType = 'Truk Tronton / Fuso Wingbox',
    this.licensePlate = 'B 9481 UXT',
    this.driverName = 'Bambang Susilo',
    this.driverId = 'DRV-8810-ID',
    this.commodityName = 'Kardus OCC Bal Kering (Grade A)',
    this.commodityCategory = 'Limbah Kertas Industri',
    this.specs = 'Kadar air ≤ 12% • Kontaminasi ≤ 2%',
    this.tonnageKg = 5000,
    this.pricePerKg = 2050,
  });

  int get _totalContractValue => tonnageKg * pricePerKg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 130),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. BANNER: TRANSAKSI BERHASIL
            _buildSuccessBanner(context),
            const SizedBox(height: 14),

            // 2. CARD: PROGRES SIKLUS TRANSAKSI (Tahap 3 dari 5)
            _buildTransactionCycleCard(),
            const SizedBox(height: 14),

            // 3. CARD: SURAT JALAN DIGITAL (e-DO) & QR CODE
            _buildDigitalSuratJalanCard(context),
            const SizedBox(height: 14),

            // 4. CARD: SPESIFIKASI KOMODITAS
            _buildCommoditySpecsCard(),
          ],
        ),
      ),
      bottomSheet: _buildBottomStickyBar(context),
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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A)),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'RINCIAN TRANSAKSI',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F766E),
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 1),
          Text(
            'Surat Jalan Digital & SPK',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Color(0xFF475569)),
          onPressed: () {},
        ),
        Container(
          margin: const EdgeInsets.only(right: 16),
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            color: Color(0xFF0A4D3C),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'WH',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.white,
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
  // 1. BANNER: TRANSAKSI BERHASIL (Dark Green Card)
  // ---------------------------------------------------------
  Widget _buildSuccessBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0A4D3C),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A0A4D3C),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaksi Berhasil',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Kontrak digital telah ditandatangani. Pembayaran telah diverifikasi dan pesanan siap diproses ke tahap pengiriman.',
            style: TextStyle(
              fontSize: 11.5,
              color: Color(0xFFE2E8F0),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),

          // 2 Number boxes side-by-side
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: contractNumber));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nomor kontrak $contractNumber disalin!'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0x24FFFFFF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0x33FFFFFF)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NOMOR KONTRAK & SPK',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA7F3D0),
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                contractNumber,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.copy_rounded,
                              size: 11,
                              color: Color(0xFFA7F3D0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: spkNumber));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nomor SPK $spkNumber disalin!'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0x24FFFFFF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0x33FFFFFF)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NO. SPK RESMI',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA7F3D0),
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                spkNumber,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.assignment_outlined,
                              size: 11,
                              color: Color(0xFFA7F3D0),
                            ),
                          ],
                        ),
                      ],
                    ),
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
  // 2. CARD: PROGRES SIKLUS TRANSAKSI (Tahap 3 dari 5)
  // ---------------------------------------------------------
  Widget _buildTransactionCycleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x04000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'PROGRES SIKLUS TRANSAKSI',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A4D3C),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Tahap 3 dari 5',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stepper Items
          _buildTimelineStep(
            icon: Icons.check_circle_rounded,
            iconColor: const Color(0xFF0A4D3C),
            title: '1. Negosiasi & Toleransi',
            badgeText: 'Selesai ⌵',
            badgeBgColor: Colors.transparent,
            badgeTextColor: const Color(0xFF15803D),
            subtitle: 'Kesepakatan kuantitas & batas deviasi muatan',
            showLineBelow: true,
          ),
          _buildTimelineStep(
            icon: Icons.check_circle_rounded,
            iconColor: const Color(0xFF0A4D3C),
            title: '2. Pengesahan SPK & Kontrak',
            badgeText: 'Selesai ⌵',
            badgeBgColor: Colors.transparent,
            badgeTextColor: const Color(0xFF15803D),
            subtitle: 'Tanda tangan digital via BSrE terverifikasi',
            showLineBelow: true,
          ),
          _buildActiveStep3(),
          _buildTimelineStep(
            customIconWidget: _buildNumberCircle('4', isCompleted: false),
            title: '4. Logistik Armada & Timbang',
            badgeText: 'Jadwal: 03 Okt 2026',
            badgeBgColor: const Color(0xFFFEF3C7),
            badgeTextColor: const Color(0xFFB45309),
            subtitle: 'Armada bergerak menuju gerbang jembatan timbang',
            showLineBelow: true,
          ),
          _buildTimelineStep(
            customIconWidget: _buildNumberCircle('5', isCompleted: false),
            title: '5. Pencairan Otomatis',
            badgeText: 'Menunggu Slip Tare/Netto',
            badgeBgColor: Colors.transparent,
            badgeTextColor: const Color(0xFF94A3B8),
            subtitle: 'Penyelesaian transaksi pasca verifikasi muatan',
            showLineBelow: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNumberCircle(String num, {required bool isCompleted}) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFF0A4D3C) : const Color(0xFFF1F5F9),
        shape: BoxShape.circle,
        border: Border.all(
          color: isCompleted
              ? const Color(0xFF0A4D3C)
              : const Color(0xFFCBD5E1),
        ),
      ),
      child: Center(
        child: Text(
          num,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: isCompleted ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineStep({
    IconData? icon,
    Color? iconColor,
    Widget? customIconWidget,
    required String title,
    required String badgeText,
    required Color badgeBgColor,
    required Color badgeTextColor,
    required String subtitle,
    required bool showLineBelow,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            customIconWidget ??
                Icon(icon, size: 20, color: iconColor ?? const Color(0xFF0A4D3C)),
            if (showLineBelow)
              Container(
                width: 2,
                height: 32,
                color: const Color(0xFFCBD5E1),
              ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: badgeBgColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: badgeTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF64748B),
                ),
              ),
              if (showLineBelow) const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  // Active Step 3 (Pembayaran Diterima - Dana Terverifikasi)
  Widget _buildActiveStep3() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF166534), width: 1.5),
              ),
              child: const Icon(
                Icons.account_balance_wallet_rounded,
                size: 11,
                color: Color(0xFF166534),
              ),
            ),
            Container(
              width: 2,
              height: 38,
              color: const Color(0xFFCBD5E1),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      '3. Pembayaran Diterima',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Aktif',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF15803D),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dana Terverifikasi',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  Text(
                    'Rp ${CurrencyFormatter.formatRupiah(_totalContractValue)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------
  // 3. CARD: SURAT JALAN DIGITAL (e-DO) & QR CODE
  // ---------------------------------------------------------
  Widget _buildDigitalSuratJalanCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x04000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Surat Jalan Digital (e-DO)',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      edoNumber,
                      style: const TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFC7D2FE)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2563EB),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Siap Scan',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1D4ED8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Big QR Code Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                // Custom Painted QR Code matching Figma aesthetic
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CustomPaint(
                    size: const Size(130, 130),
                    painter: _FigmaQrCodePainter(),
                  ),
                ),
                const SizedBox(height: 14),

                const Text(
                  'TOKEN AKSES GERBANG & TIMBANGAN',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF475569),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),

                // Token Pill with Copy
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: doToken));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('DO-TOKEN $doToken disalin!'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'DO-TOKEN: $doToken',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.copy_rounded,
                          size: 12,
                          color: Color(0xFF475569),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                const Text(
                  'Tunjukkan kode QR ini ke pos jembatan timbang pabrik pengolah untuk input data penimbangan awal (tare).',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Sub-card A: Armada Pengangkut
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.local_shipping_outlined,
                    size: 18,
                    color: Color(0xFF2563EB),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ARMADA PENGANGKUT',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF64748B),
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        truckType,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFF0F172A), width: 1.2),
                  ),
                  child: Text(
                    licensePlate,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Sub-card B: Pengemudi Ditugaskan
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.badge_outlined,
                    size: 18,
                    color: Color(0xFF2563EB),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PENGEMUDI DITUGASKAN',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF64748B),
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        driverName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      driverId,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.verified,
                          size: 11,
                          color: Color(0xFF059669),
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Terverifikasi',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF059669),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // 4. CARD: SPESIFIKASI KOMODITAS
  // ---------------------------------------------------------
  Widget _buildCommoditySpecsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x04000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'SPESIFIKASI KOMODITAS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  commodityCategory,
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Commodity Row Preview
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 52,
                    height: 52,
                    color: const Color(0xFFE2E8F0),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=300&auto=format&fit=crop&q=80',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.inventory_2_outlined,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        commodityName,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        specs,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Estimasi Muatan Truk',
                  style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${CurrencyFormatter.formatRupiah(tonnageKg)} kg (${(tonnageKg / 1000).toStringAsFixed(2).replaceAll('.', ',')} Ton)',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Harga Satuan Terkunci',
                  style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Rp ${CurrencyFormatter.formatRupiah(pricePerKg)} / kg',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Total Nilai Kontrak',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Rp ${CurrencyFormatter.formatRupiah(_totalContractValue)}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0A4D3C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // 5. BOTTOM STICKY ACTION BAR (Pantau Logistik & Unduh PDF)
  // ---------------------------------------------------------
  Widget _buildBottomStickyBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Button 1: Pantau Logistik
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LogisticsTrackingScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.local_shipping_rounded, size: 16),
                label: const Text(
                  'Pantau Logistik',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A4D3C),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Button 2: Unduh e-DO & Kontrak PDF
            SizedBox(
              width: double.infinity,
              height: 46,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF0A4D3C),
                      content: Text(
                        'Mengunduh dokumen PDF e-DO & SPK $spkNumber...',
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.picture_as_pdf_outlined,
                    size: 16, color: Color(0xFFB45309)),
                label: const Text(
                  'Unduh e-DO & Kontrak PDF',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
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
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// CUSTOM PAINTER: QR CODE DESIGN (Figma accurate)
// ---------------------------------------------------------
class _FigmaQrCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0A4D3C)
      ..style = PaintingStyle.fill;

    final step = size.width / 21;

    void drawSquare(int x, int y, int w, int h) {
      canvas.drawRect(
        Rect.fromLTWH(x * step, y * step, w * step, h * step),
        paint,
      );
    }

    void drawFinder(int x, int y) {
      // Outer 7x7
      drawSquare(x, y, 7, 7);
      // Cut inner 5x5
      final whitePaint = Paint()..color = Colors.white;
      canvas.drawRect(
        Rect.fromLTWH((x + 1) * step, (y + 1) * step, 5 * step, 5 * step),
        whitePaint,
      );
      // Center 3x3
      drawSquare(x + 2, y + 2, 3, 3);
    }

    // 3 Finder patterns
    drawFinder(0, 0); // Top-left
    drawFinder(14, 0); // Top-right
    drawFinder(0, 14); // Bottom-left

    // Alignment and data blocks
    // Timing lines
    for (int i = 8; i < 13; i += 2) {
      drawSquare(6, i, 1, 1);
      drawSquare(i, 6, 1, 1);
    }

    // Inner blocks (WasteHub SPK Token pattern)
    final points = [
      [9, 1], [11, 2], [8, 3], [12, 4],
      [9, 8], [10, 8], [11, 9], [13, 9],
      [8, 10], [9, 11], [10, 12], [8, 13],
      [14, 8], [15, 9], [17, 8], [19, 9],
      [15, 11], [17, 12], [18, 13], [20, 11],
      [9, 14], [11, 15], [10, 17], [12, 18],
      [14, 15], [16, 16], [17, 18], [19, 17],
      [14, 19], [16, 20], [18, 19], [20, 20],
      [2, 9], [4, 10], [3, 12],
    ];

    for (final pt in points) {
      drawSquare(pt[0], pt[1], 1, 1);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
