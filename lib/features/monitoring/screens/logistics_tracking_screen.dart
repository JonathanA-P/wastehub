import 'package:flutter/material.dart';
import '../../transaction/screens/transaction_success_screen.dart';

class LogisticsTrackingScreen extends StatefulWidget {
  final String contractCode;
  final String commodityName;
  final String licensePlate;
  final String driverName;
  final String driverPhone;
  final String origin;
  final String destination;
  final double netWeightTon;
  final int grossWeightKg;
  final int tareWeightKg;

  const LogisticsTrackingScreen({
    super.key,
    this.contractCode = '#WH-CTR-2026-0941',
    this.commodityName = 'Kardus Bekas OCC Bal (Grade Industri)',
    this.licensePlate = 'B 9241 UZ',
    this.driverName = 'Ahmad Supriadi',
    this.driverPhone = '+62 812-8821-9041',
    this.origin = 'Depo Agregator Cikande, Banten',
    this.destination = 'Pabrik Daur Ulang Bitung, Tangerang',
    this.netWeightTon = 8.0,
    this.grossWeightKg = 13480,
    this.tareWeightKg = 5480,
  });

  @override
  State<LogisticsTrackingScreen> createState() =>
      _LogisticsTrackingScreenState();
}

class _LogisticsTrackingScreenState extends State<LogisticsTrackingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  int _selectedTab = 0; // 0: Rute & GPS, 1: Jembatan Timbang, 2: Dokumen e-DO
  bool _isArrived = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  int get _netWeightKg => widget.grossWeightKg - widget.tareWeightKg;

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
            // Status Banner with Live Pulse Beacon
            _buildLiveStatusBanner(),
            const SizedBox(height: 14),

            // Tab Navigation Selector
            _buildTabSelector(),
            const SizedBox(height: 14),

            if (_selectedTab == 0) ...[
              // Live Route Visual Map Canvas Card
              _buildRouteMapCard(),
              const SizedBox(height: 14),

              // Vehicle & Driver Details Card
              _buildDriverVehicleCard(),
              const SizedBox(height: 14),

              // Checkpoint Stepper Timeline
              _buildTimelineStepper(),
            ] else if (_selectedTab == 1) ...[
              // Weighbridge (Jembatan Timbang Digital)
              _buildWeighbridgeCard(),
              const SizedBox(height: 14),

              // ANPR Camera & Gate Sensor Card
              _buildAnprCameraCard(),
            ] else ...[
              // Document & Compliance summary
              _buildComplianceDocsCard(),
            ],

            const SizedBox(height: 18),

            // Sticky Bottom Action CTA
            _buildActionButtons(context),
          ],
        ),
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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded,
            color: Color(0xFF0F172A), size: 22),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Monitoring & Tracking Logistik',
            style: TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),
          Text(
            widget.contractCode,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined,
              color: Color(0xFF334155), size: 20),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color(0xFF0A4D3C),
                content: Text(
                  'Tautan live tracking ${widget.contractCode} disalin ke clipboard!',
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: const Color(0xFFE2E8F0), height: 1),
      ),
    );
  }

  // ---------------------------------------------------------
  // LIVE STATUS BANNER
  // ---------------------------------------------------------
  Widget _buildLiveStatusBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _isArrived ? const Color(0xFFECFDF5) : const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:
              _isArrived ? const Color(0xFFA7F3D0) : const Color(0xFFFDE68A),
        ),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isArrived
                      ? const Color(0xFF059669)
                      : Color.lerp(
                          const Color(0xFFD97706),
                          const Color(0xFFF59E0B),
                          _pulseController.value,
                        ),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isArrived
                      ? 'Truk Tiba di Gerbang Timbang Bitung'
                      : 'Armada Dalam Perjalanan (15 km lagi)',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: _isArrived
                        ? const Color(0xFF065F46)
                        : const Color(0xFF92400E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _isArrived
                      ? 'Menunggu verifikasi timbang bruto & sampling lab'
                      : 'Estimasi tiba pukul 10:45 WIB',
                  style: TextStyle(
                    fontSize: 11,
                    color: _isArrived
                        ? const Color(0xFF047857)
                        : const Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // TAB SELECTOR (Rute GPS / Timbangan / e-DO)
  // ---------------------------------------------------------
  Widget _buildTabSelector() {
    final tabs = [
      {'title': 'Rute & GPS', 'icon': Icons.map_outlined},
      {'title': 'Jembatan Timbang', 'icon': Icons.scale_outlined},
      {'title': 'Dokumen e-DO', 'icon': Icons.description_outlined},
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _selectedTab == index;
          return Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedTab = index),
              borderRadius: BorderRadius.circular(9),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: isSelected
                      ? const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          )
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tabs[index]['icon'] as IconData,
                      size: 15,
                      color: isSelected
                          ? const Color(0xFF0A4D3C)
                          : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        tabs[index]['title'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.w800
                              : FontWeight.w600,
                          color: isSelected
                              ? const Color(0xFF0A4D3C)
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ---------------------------------------------------------
  // ROUTE MAP CANVAS CARD
  // ---------------------------------------------------------
  Widget _buildRouteMapCard() {
    return Container(
      width: double.infinity,
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
          // Simulated Satellite/Highway Map Surface
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: Stack(
                children: [
                  CustomPaint(
                    size: const Size(double.infinity, 180),
                    painter: _HighwayRoutePainter(isArrived: _isArrived),
                  ),
                  // Map Overlays: Speed & Toll Marker
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A).withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.speed_rounded,
                              size: 13, color: Color(0xFF38BDF8)),
                          SizedBox(width: 5),
                          Text(
                            'Kecepatan: 64 km/jam',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.satellite_alt_outlined,
                              size: 13, color: Color(0xFF0A4D3C)),
                          SizedBox(width: 4),
                          Text(
                            'GPS Akurat (±2m)',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
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

          // Route Points Summary
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _buildRoutePointRow(
                  icon: Icons.trip_origin_rounded,
                  iconColor: const Color(0xFF0A4D3C),
                  title: 'Titik Asal: Depo Cikande, Banten',
                  subtitle: 'Berangkat: 08:30 WIB • Timbang Awal Selesai',
                  isLast: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 11),
                  child: Row(
                    children: [
                      Container(
                        width: 2,
                        height: 20,
                        color: const Color(0xFFCBD5E1),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        'Jarak Tempuh Total: 42 km • Tol Jakarta-Merak',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildRoutePointRow(
                  icon: Icons.location_on_rounded,
                  iconColor: const Color(0xFFEF4444),
                  title: 'Tujuan: Pabrik Daur Ulang Bitung, Tangerang',
                  subtitle: 'Target Tiba: 10:45 WIB • Gerbang Timbang 2',
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutePointRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: iconColor),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10.5,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------
  // DRIVER & VEHICLE DETAILS CARD
  // ---------------------------------------------------------
  Widget _buildDriverVehicleCard() {
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
              const Text(
                'Data Armada & Pengemudi',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'SIUP & KIR Valid',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF166534),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              // Truck Icon Box
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A4D3C),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.local_shipping_rounded,
                      color: Colors.white, size: 24),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.licensePlate,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFFCBD5E1)),
                          ),
                          child: const Text(
                            'Fuso Box 6 Roda',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF475569),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Sopir: ${widget.driverName} • SIM B2 Umum',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              // Call & WA buttons
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFECFDF5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xFFA7F3D0)),
                  ),
                ),
                icon: const Icon(Icons.phone_outlined,
                    size: 18, color: Color(0xFF059669)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Menghubungi ${widget.driverName} (${widget.driverPhone})...'),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // TIMELINE STEPPER
  // ---------------------------------------------------------
  Widget _buildTimelineStepper() {
    final steps = [
      {
        'time': '08:30 WIB',
        'title': 'Muat Barang di Depo Asal',
        'desc': '8.000 kg Kardus Bekas dimuat dan disegel tamper-evident',
        'isDone': true,
      },
      {
        'time': '08:50 WIB',
        'title': 'Timbang Bruto Awal (#WB-982)',
        'desc': 'Bruto: 13.480 kg, Tarra: 5.480 kg • Netto: 8.000 kg',
        'isDone': true,
      },
      {
        'time': '09:25 WIB',
        'title': 'Melintasi Gerbang Tol Balaraja Barat',
        'desc': 'Kecepatan rata-rata 62 km/jam • GPS Sensor Aktif',
        'isDone': true,
      },
      {
        'time': '10:45 WIB (Estimasi)',
        'title': 'Masuk Gerbang Timbang Bitung',
        'desc': 'Verifikasi pelat nomor otomatis (ANPR) & jembatan timbang',
        'isDone': _isArrived,
      },
      {
        'time': '11:15 WIB (Estimasi)',
        'title': 'Bongkar Muatan & Penerbitan BAST Digital',
        'desc': 'Pemeriksaan kadar air maks 12% oleh inspektur pabrik',
        'isDone': false,
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
          const Text(
            'Histori Perjalanan & Checkpoint SPK',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(steps.length, (index) {
            final step = steps[index];
            final isDone = step['isDone'] as bool;
            final isLast = index == steps.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone
                            ? const Color(0xFF0A4D3C)
                            : const Color(0xFFE2E8F0),
                      ),
                      child: Center(
                        child: Icon(
                          isDone ? Icons.check : Icons.circle,
                          size: isDone ? 12 : 6,
                          color: isDone ? Colors.white : const Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 36,
                        color: isDone
                            ? const Color(0xFF0A4D3C)
                            : const Color(0xFFE2E8F0),
                      ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              step['title'] as String,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                                color: isDone
                                    ? const Color(0xFF0F172A)
                                    : const Color(0xFF64748B),
                              ),
                            ),
                            Text(
                              step['time'] as String,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: isDone
                                    ? const Color(0xFF059669)
                                    : const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          step['desc'] as String,
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // WEIGHBRIDGE CARD (Jembatan Timbang Metrologi)
  // ---------------------------------------------------------
  Widget _buildWeighbridgeCard() {
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
            children: [
              Row(
                children: const [
                  Icon(Icons.scale_rounded, color: Color(0xFF0A4D3C), size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Tiket Timbang Elektronik',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'TERA METROLOGI LEGAL',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF065F46),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 3 Big Metric Columns
          Row(
            children: [
              _buildWeightMetricBox('BRUTO (TOTAL)', '${widget.grossWeightKg} kg',
                  const Color(0xFF64748B)),
              const SizedBox(width: 8),
              _buildWeightMetricBox('TARRA (TRUK)', '${widget.tareWeightKg} kg',
                  const Color(0xFF64748B)),
              const SizedBox(width: 8),
              _buildWeightMetricBox('NETTO (KOMODITAS)', '$_netWeightKg kg',
                  const Color(0xFF0A4D3C), isHighlight: true),
            ],
          ),
          const SizedBox(height: 14),

          // Scale Metadata Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                _buildWeightDetailRow('Nomor Tiket Timbang', 'WB-20261005-0982'),
                const Divider(height: 14, color: Color(0xFFE2E8F0)),
                _buildWeightDetailRow(
                    'Operator Jembatan Timbang', 'Depo Cikande - Pos 01'),
                const Divider(height: 14, color: Color(0xFFE2E8F0)),
                _buildWeightDetailRow('Sertifikasi Kalibrasi',
                    'SK Metrologi No. 510/ML-BTN/2026 (Berlaku s/d Des 2026)'),
                const Divider(height: 14, color: Color(0xFFE2E8F0)),
                _buildWeightDetailRow('Toleransi Berat SPK', '0.0% (Tepat Sesuai Kontrak)'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightMetricBox(String label, String value, Color valueColor,
      {bool isHighlight = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isHighlight ? const Color(0xFFECFDF5) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isHighlight
                ? const Color(0xFFA7F3D0)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 8.5,
                fontWeight: FontWeight.w800,
                color: isHighlight
                    ? const Color(0xFF065F46)
                    : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: valueColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------
  // ANPR CAMERA & GATE SENSOR
  // ---------------------------------------------------------
  Widget _buildAnprCameraCard() {
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
            children: const [
              Text(
                'Kamera ANPR & Sensor RFID',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                'Match Rate: 99.4%',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF059669),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.videocam_outlined,
                          color: Color(0xFF38BDF8), size: 28),
                      const SizedBox(height: 6),
                      Text(
                        'CCTV SNAPSHOT • POS GATE CIKANDE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade400,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Detected: ${widget.licensePlate} (VERIFIED)',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF4ADE80),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 10,
                  child: Text(
                    'CAM-01 • 05/10/2026 08:31:14 WIB',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.white.withValues(alpha: 0.6),
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // COMPLIANCE DOCS CARD
  // ---------------------------------------------------------
  Widget _buildComplianceDocsCard() {
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
            'Dokumen & Izin Angkut Limbah Industri',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          _buildDocRow('Surat Jalan Elektronik (e-DO)', 'EDO-2026-0941/WH', true),
          const SizedBox(height: 8),
          _buildDocRow('Surat Perintah Kerja (SPK)', 'SPK/WH/2026/0891', true),
          const SizedBox(height: 8),
          _buildDocRow('Manifest Pengangkutan Non-B3 (KLHK)', 'MNF-98124/2026', true),
          const SizedBox(height: 8),
          _buildDocRow('Surat Keterangan Bebas Kontaminasi', 'COA-DAL-PET-088', true),
        ],
      ),
    );
  }

  Widget _buildDocRow(String title, String ref, bool isVerified) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.picture_as_pdf_outlined,
                  size: 16, color: Color(0xFFB45309)),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    ref,
                    style: const TextStyle(
                      fontSize: 9.5,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.check_circle_rounded,
              size: 16, color: Color(0xFF059669)),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // ACTION BUTTONS
  // ---------------------------------------------------------
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Button 1: Konfirmasi Truk Tiba di Gerbang
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _isArrived = !_isArrived;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF0A4D3C),
                  content: Text(
                    _isArrived
                        ? 'Status diperbarui: Truk B 9241 UZ telah tiba di Gerbang Pabrik Bitung!'
                        : 'Status dikembalikan ke Dalam Perjalanan.',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: Icon(
              _isArrived ? Icons.undo_rounded : Icons.check_circle_outline,
              size: 18,
            ),
            label: Text(
              _isArrived
                  ? 'Batalkan Konfirmasi Kedatangan'
                  : 'Konfirmasi Truk Tiba di Gerbang',
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _isArrived
                  ? const Color(0xFF334155)
                  : const Color(0xFF0A4D3C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Button 2: Lihat Surat Jalan e-DO & SPK
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TransactionSuccessScreen(),
                ),
              );
            },
            icon: const Icon(Icons.qr_code_2_rounded,
                size: 18, color: Color(0xFF0A4D3C)),
            label: const Text(
              'Buka Surat Jalan Digital (e-DO & QR)',
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
      ],
    );
  }
}

// ---------------------------------------------------------
// CUSTOM HIGHWAY ROUTE PAINTER
// ---------------------------------------------------------
class _HighwayRoutePainter extends CustomPainter {
  final bool isArrived;

  _HighwayRoutePainter({required this.isArrived});

  @override
  void paint(Canvas canvas, Size size) {
    // Map background surface (soft topographic grey-blue)
    final bgPaint = Paint()..color = const Color(0xFFE2E8F0);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Minor roads & landscape grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1.0;

    for (double i = 20; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double j = 20; j < size.height; j += 40) {
      canvas.drawLine(Offset(0, j), Offset(size.width, j), gridPaint);
    }

    // Highway Road Path (Tol Jakarta-Merak)
    final highwayBgPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final highwayPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final routePath = Path();
    routePath.moveTo(size.width * 0.15, size.height * 0.75);
    routePath.cubicTo(
      size.width * 0.35,
      size.height * 0.85,
      size.width * 0.50,
      size.height * 0.35,
      size.width * 0.85,
      size.height * 0.25,
    );

    canvas.drawPath(routePath, highwayBgPaint);
    canvas.drawPath(routePath, highwayPaint);

    // Active Route Traveled Highlight (Green)
    final activePaint = Paint()
      ..color = const Color(0xFF059669)
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progress = isArrived ? 1.0 : 0.65;
    final metrics = routePath.computeMetrics().first;
    final traveledPath = metrics.extractPath(0, metrics.length * progress);
    canvas.drawPath(traveledPath, activePaint);

    // Origin Marker (Cikande)
    final originCenter = Offset(size.width * 0.15, size.height * 0.75);
    final originPaint = Paint()..color = const Color(0xFF0A4D3C);
    canvas.drawCircle(originCenter, 8, originPaint);
    canvas.drawCircle(originCenter, 4, Paint()..color = Colors.white);

    // Destination Marker (Bitung Factory)
    final destCenter = Offset(size.width * 0.85, size.height * 0.25);
    final destPaint = Paint()..color = const Color(0xFFEF4444);
    canvas.drawCircle(destCenter, 9, destPaint);
    canvas.drawCircle(destCenter, 5, Paint()..color = Colors.white);

    // Current Moving Truck Marker
    final truckTangent = metrics.getTangentForOffset(metrics.length * progress);
    if (truckTangent != null) {
      final truckPos = truckTangent.position;

      // Pulse aura
      final auraPaint = Paint()
        ..color = const Color(0xFF38BDF8).withValues(alpha: 0.3)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(truckPos, 14, auraPaint);

      // Core icon point
      final truckCorePaint = Paint()..color = const Color(0xFF0284C7);
      canvas.drawCircle(truckPos, 8, truckCorePaint);
      canvas.drawCircle(truckPos, 4, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant _HighwayRoutePainter oldDelegate) =>
      oldDelegate.isArrived != isArrived;
}
