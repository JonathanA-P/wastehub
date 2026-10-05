import 'package:flutter/material.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/wastehub_bottom_nav.dart';
import '../../business/screens/business_dashboard_screen.dart';
import '../../monitoring/screens/logistics_tracking_screen.dart';
import '../../negotiation/screens/negotiation_inbox_screen.dart';
import '../../negotiation/screens/new_negotiation_screen.dart';
import '../../notifications/screens/notification_center_screen.dart';
import '../../profile/screens/user_profile_screen.dart';
import 'bast_digital_screen.dart';
import 'contract_signing_screen.dart';
import 'transaction_success_screen.dart';

class TransactionContractItem {
  final String id;
  final String contractCode;
  final String dateText;
  final String materialTitle;
  final String partnerName;
  final int tonnageKg;
  final double tonnageTon;
  final String? statusLabel;
  final Color? statusBadgeBg;
  final Color? statusBadgeBorder;
  final Color? statusTextColor;
  final Color? statusDotColor;
  final String? logisticsText;
  final String actionButtonLabel;
  final Widget destination;

  const TransactionContractItem({
    required this.id,
    required this.contractCode,
    required this.dateText,
    required this.materialTitle,
    required this.partnerName,
    required this.tonnageKg,
    required this.tonnageTon,
    this.statusLabel,
    this.statusBadgeBg,
    this.statusBadgeBorder,
    this.statusTextColor,
    this.statusDotColor,
    this.logisticsText,
    required this.actionButtonLabel,
    required this.destination,
  });
}

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterIndex = 0;
  final int _currentNavIndex = 1; // Tab 1: Kontrak

  final List<String> _filters = [
    'Semua (22)',
    'Aktif / Logistik (4)',
    'Selesai (17)',
    'Dibatalkan (1)',
  ];

  late final List<TransactionContractItem> _items = [
    TransactionContractItem(
      id: 'tx-1',
      contractCode: '#WH-CTR-2026-0941',
      dateText: 'Hari ini, 09:15 WIB',
      materialTitle: 'Kardus Bekas OCC Bal',
      partnerName: 'PT Daurindo Jaya',
      tonnageKg: 5000,
      tonnageTon: 5.0,
      statusLabel: 'Armada Menuju Timbangan',
      statusBadgeBg: const Color(0xFFFFFBEB),
      statusBadgeBorder: const Color(0xFFFDE68A),
      statusTextColor: const Color(0xFFB45309),
      statusDotColor: const Color(0xFFD97706),
      logisticsText: 'Truk B 9241 UZ • GPS Aktif',
      actionButtonLabel: 'Lihat e-DO & QR →',
      destination: const TransactionSuccessScreen(),
    ),
    TransactionContractItem(
      id: 'tx-2',
      contractCode: '#WH-CTR-2026-0812',
      dateText: 'Kemarin, 14:20 WIB',
      materialTitle: 'Plastik PET Bening Cacah',
      partnerName: 'PT Daur Alam Lestari',
      tonnageKg: 8000,
      tonnageTon: 8.0,
      statusLabel: null,
      statusBadgeBg: null,
      statusBadgeBorder: null,
      statusTextColor: null,
      statusDotColor: null,
      logisticsText: null,
      actionButtonLabel: 'Rincian Kontrak →',
      destination: const ContractSigningScreen(
        contractNumber: 'MoA-2026/PET-882',
        aktaNumber: 'CTR/WH-2026/X/8820',
        effectiveDate: '05 Oktober 2026',
        commodityName: 'PET Flakes Bening (Hot Washed Grade A)',
        commodityGrade: 'Grade A\nIndustri',
        sellerName: 'PT Daur Alam Lestari',
        sellerNib: '9120003418902',
        totalQuantity: 8000,
        moistureSpec: 'Maks. 1.0%',
        unitPrice: 11500,
        totalValue: 92000000,
        totalValueSpelled: 'Sembilan Puluh Dua Juta Rupiah',
        sellerSignRef: 'E-SIGN-051026-DAL',
      ),
    ),
    TransactionContractItem(
      id: 'tx-3',
      contractCode: '#WH-CTR-2026-0790',
      dateText: '24 Feb 2026',
      materialTitle: 'Scrap Aluminium Kaleng UBC',
      partnerName: 'PT Sinar Logam',
      tonnageKg: 3000,
      tonnageTon: 3.0,
      statusLabel: 'Selesai & Dicairkan',
      statusBadgeBg: const Color(0xFFDCFCE7),
      statusBadgeBorder: const Color(0xFFBBF7D0),
      statusTextColor: const Color(0xFF166534),
      statusDotColor: const Color(0xFF16A34A),
      logisticsText: null,
      actionButtonLabel: 'Unduh BAST Digital →',
      destination: const BastDigitalScreen(
        bastNumber: 'BAST-2026/DAL/0790',
        contractCode: '#WH-CTR-2026-0790',
        dateText: '24 Feb 2026',
        commodityName: 'Scrap Aluminium Kaleng UBC',
        sellerName: 'PT Sinar Logam',
        tonnageKg: 3000,
        unitPrice: 19800,
      ),
    ),
  ];

  List<TransactionContractItem> get _filteredItems {
    final query = _searchController.text.trim().toLowerCase();
    return _items.where((item) {
      final matchesSearch = query.isEmpty ||
          item.materialTitle.toLowerCase().contains(query) ||
          item.partnerName.toLowerCase().contains(query) ||
          item.contractCode.toLowerCase().contains(query);

      if (!matchesSearch) return false;

      if (_selectedFilterIndex == 1) {
        // Aktif / Logistik
        return item.statusLabel?.contains('Armada') ?? false;
      } else if (_selectedFilterIndex == 2) {
        // Selesai
        return item.statusLabel?.contains('Selesai') ?? false;
      } else if (_selectedFilterIndex == 3) {
        // Dibatalkan
        return item.statusLabel?.contains('Batal') ?? false;
      }
      return true; // Semua
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Pill: + Kontrak Baru
                  _buildNewContractButton(context),
                  const SizedBox(height: 12),

                  // Metrics KPI Card: Total Tonase Sirkular
                  _buildTonaseSummaryCard(),
                  const SizedBox(height: 14),

                  // Search Bar
                  _buildSearchBar(),
                  const SizedBox(height: 12),

                  // Filter Chips
                  _buildFilterChips(),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),

          // Contracts List
          if (items.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_open_rounded,
                      size: 44,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Tidak ada transaksi kontrak ditemukan',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = items[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildTransactionCard(context, item),
                    );
                  },
                  childCount: items.length,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: WasteHubBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const NegotiationInboxScreen(),
              ),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const BusinessDashboardScreen(),
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
          // Logo Recycling Loop Dark Green Box
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF0A4D3C),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.recycling_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Daftar Transaksi & Kontrak',
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
        // Bell Icon
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

        // WH User Avatar Circle
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
  // NEW CONTRACT BUTTON (+ Kontrak Baru)
  // ---------------------------------------------------------
  Widget _buildNewContractButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const NewNegotiationScreen(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFF1E4D3E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.track_changes_outlined,
              size: 14,
              color: Colors.white,
            ),
            SizedBox(width: 6),
            Text(
              '+ Kontrak Baru',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // TONASE SUMMARY METRICS CARD
  // ---------------------------------------------------------
  Widget _buildTonaseSummaryCard() {
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
          // Header: Label + Scale / Hourglass Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total Tonase Sirkular',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
              Icon(
                Icons.hourglass_empty_rounded,
                size: 16,
                color: Color(0xFF166534),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Big Metric: 48,5 Ton
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: const [
              Text(
                '48,5',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(width: 4),
              Text(
                'Ton',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Trend Row
          Row(
            children: const [
              Icon(
                Icons.trending_up_rounded,
                size: 15,
                color: Color(0xFF16A34A),
              ),
              SizedBox(width: 4),
              Text(
                '+12.4% vs bln lalu',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF16A34A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // SEARCH BAR
  // ---------------------------------------------------------
  Widget _buildSearchBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            size: 19,
            color: Color(0xFF94A3B8),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(fontSize: 12.5),
              decoration: const InputDecoration(
                hintText: 'Cari ID kontrak, jenis material, atau mitra...',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() {});
              },
              child: const Icon(
                Icons.cancel_rounded,
                size: 16,
                color: Color(0xFF94A3B8),
              ),
            ),
          const SizedBox(width: 6),
          const Icon(
            Icons.tune_rounded,
            size: 18,
            color: Color(0xFF64748B),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // FILTER CHIPS (Horizontal Scrollable)
  // ---------------------------------------------------------
  Widget _buildFilterChips() {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedFilterIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilterIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0A4D3C) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0A4D3C)
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Center(
                child: Text(
                  _filters[index],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------
  // TRANSACTION CONTRACT CARD COMPONENT
  // ---------------------------------------------------------
  Widget _buildTransactionCard(
      BuildContext context, TransactionContractItem item) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Code + Date + Status Pill Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.contractCode,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'monospace',
                        color: Color(0xFF0A4D3C),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      '• ${item.dateText}',
                      style: const TextStyle(
                        fontSize: 9.5,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
              if (item.statusLabel != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: item.statusBadgeBg ?? const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: item.statusBadgeBorder ?? const Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.statusDotColor != null) ...[
                        Icon(Icons.circle,
                            size: 6, color: item.statusDotColor),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        item.statusLabel!,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: item.statusTextColor ?? const Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),

          // Title: Material Name
          Text(
            item.materialTitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),

          // Partner & Volume
          Text(
            'Mitra: ${item.partnerName}',
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
              children: [
                TextSpan(
                  text:
                      '${CurrencyFormatter.formatRupiah(item.tonnageKg)} kg',
                ),
                TextSpan(
                  text:
                      ' (${item.tonnageTon.toStringAsFixed(item.tonnageTon.truncateToDouble() == item.tonnageTon ? 0 : 1)} Ton)',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Bottom Row: Logistics Info & Action Button
          Row(
            children: [
              Expanded(
                child: item.logisticsText != null
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LogisticsTrackingScreen(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.local_shipping_outlined,
                              size: 14,
                              color: Color(0xFF166534),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                item.logisticsText!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0A4D3C),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(width: 8),

              // Action Button (Lihat e-DO & QR → / Rincian Kontrak → / Unduh BAST Digital →)
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => item.destination),
                  );
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Text(
                    item.actionButtonLabel,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0A4D3C),
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
}
