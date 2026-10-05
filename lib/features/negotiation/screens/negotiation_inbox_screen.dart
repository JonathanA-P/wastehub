import 'package:flutter/material.dart';
import '../../../core/widgets/wastehub_bottom_nav.dart';
import '../../business/screens/business_dashboard_screen.dart';
import '../../notifications/screens/notification_center_screen.dart';
import '../../profile/screens/user_profile_screen.dart';
import '../../transaction/screens/transaction_list_screen.dart';
import '../../transaction/screens/transaction_success_screen.dart';
import 'counter_offer_screen.dart';
import 'negotiation_chat_screen.dart';
import 'new_negotiation_screen.dart';

class NegotiationInboxItem {
  final String id;
  final String code;
  final String partnerName;
  final String partnerInitials;
  final Color avatarBgColor;
  final Color avatarTextColor;
  final Color? statusDotColor;
  final String partnerType;
  final String time;
  final String? statusBadge;
  final Color? statusBadgeBg;
  final Color? statusBadgeTextColor;
  final String snippet;
  final String commodityTag;
  final String priceTag;
  final Color priceTagBg;
  final Color priceTagTextColor;
  final IconData? priceTagIcon;
  final int? unreadCount;
  final Color? unreadCountBg;
  final Widget destination;

  const NegotiationInboxItem({
    required this.id,
    required this.code,
    required this.partnerName,
    required this.partnerInitials,
    required this.avatarBgColor,
    required this.avatarTextColor,
    this.statusDotColor,
    required this.partnerType,
    required this.time,
    this.statusBadge,
    this.statusBadgeBg,
    this.statusBadgeTextColor,
    required this.snippet,
    required this.commodityTag,
    required this.priceTag,
    required this.priceTagBg,
    required this.priceTagTextColor,
    this.priceTagIcon,
    this.unreadCount,
    this.unreadCountBg,
    required this.destination,
  });
}

class NegotiationInboxScreen extends StatefulWidget {
  const NegotiationInboxScreen({super.key});

  @override
  State<NegotiationInboxScreen> createState() => _NegotiationInboxScreenState();
}

class _NegotiationInboxScreenState extends State<NegotiationInboxScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterIndex = 0;
  final int _currentNavIndex = 2; // Active tab: Inbox

  final List<String> _filters = [
    'Semua (5)',
    'Menunggu Respon (2)',
    'Tawaran Masuk (1)',
    'Tersepakati (1)',
  ];

  late final List<NegotiationInboxItem> _items = [
    NegotiationInboxItem(
      id: 'inbox-1',
      code: '#NEGO-9941',
      partnerName: 'PT Daur Alam Lestari',
      partnerInitials: 'DA',
      avatarBgColor: const Color(0xFFDCFCE7),
      avatarTextColor: const Color(0xFF166534),
      statusDotColor: const Color(0xFF16A34A),
      partnerType: 'Pabrik Daur Ulang',
      time: '10:42 WIB',
      statusBadge: 'Tawaran Baru',
      statusBadgeBg: const Color(0xFFFEF3C7),
      statusBadgeTextColor: const Color(0xFFB45309),
      snippet:
          '“Penawaran harga baru diajukan untuk Plastik PET Bening Hot Washed 12 Ton. Jadwal muat gudang siap hari...”',
      commodityTag: 'Plastik PET',
      priceTag: 'Tawaran: Rp 11.500/kg',
      priceTagBg: const Color(0xFFDCFCE7),
      priceTagTextColor: const Color(0xFF15803D),
      unreadCount: 1,
      unreadCountBg: const Color(0xFF0A4D3C),
      destination: const NegotiationChatScreen(),
    ),
    NegotiationInboxItem(
      id: 'inbox-2',
      code: '#NEGO-9938',
      partnerName: 'PT Daurindo Jaya',
      partnerInitials: 'DJ',
      avatarBgColor: const Color(0xFFFEF3C7),
      avatarTextColor: const Color(0xFFB45309),
      statusDotColor: const Color(0xFFF59E0B),
      partnerType: 'Manufaktur Kertas',
      time: '09:15 WIB',
      statusBadge: 'Counter Offer',
      statusBadgeBg: const Color(0xFFEFF6FF),
      statusBadgeTextColor: const Color(0xFF2563EB),
      snippet:
          '“Kami ajukan counter offer untuk Kardus OCC Super 8 Ton. Apakah harga Rp 1.980/kg disetujui dengan jemput...”',
      commodityTag: 'Kardus OCC',
      priceTag: 'Counter: Rp 1.980/kg',
      priceTagBg: const Color(0xFFFEF3C7),
      priceTagTextColor: const Color(0xFFB45309),
      unreadCount: 2,
      unreadCountBg: const Color(0xFFD97706),
      destination: const CounterOfferScreen(),
    ),
    NegotiationInboxItem(
      id: 'inbox-3',
      code: '#NEGO-9925',
      partnerName: 'PT Sinar Logam',
      partnerInitials: 'SL',
      avatarBgColor: const Color(0xFFF1F5F9),
      avatarTextColor: const Color(0xFF475569),
      statusDotColor: null,
      partnerType: 'Pabrik Peleburan Logam',
      time: 'Kemarin',
      statusBadge: null,
      statusBadgeBg: null,
      statusBadgeTextColor: null,
      snippet:
          '“Spesifikasi Scrap Aluminium profil grade A telah diverifikasi tim lab. Mohon konfirmasi ketersediaan...”',
      commodityTag: 'Scrap Aluminium',
      priceTag: 'Estimasi: Rp 24.500/kg',
      priceTagBg: const Color(0xFFF8FAFC),
      priceTagTextColor: const Color(0xFF475569),
      unreadCount: null,
      unreadCountBg: null,
      destination: const CounterOfferScreen(
        batchId: '#NEGO-9925',
        partnerName: 'PT Sinar Logam',
        materialName: 'Scrap Aluminium Profil Grade A',
        initialPrice: 24500,
        initialQuantity: 4000,
        marketRefPrice: 24800,
        location: 'Kawasan Industri Cikarang',
        grade: 'Grade A Siap Lebur',
      ),
    ),
    NegotiationInboxItem(
      id: 'inbox-4',
      code: '#NEGO-9912',
      partnerName: 'Bank Sampah Induk Makmur',
      partnerInitials: 'BM',
      avatarBgColor: const Color(0xFFCCFBF1),
      avatarTextColor: const Color(0xFF0F766E),
      statusDotColor: null,
      partnerType: 'Agregator Kota',
      time: '2 hari lalu',
      statusBadge: 'Tawaran Masuk',
      statusBadgeBg: const Color(0xFFDCFCE7),
      statusBadgeTextColor: const Color(0xFF166534),
      snippet:
          '“Kami memiliki pasokan botol PET kotor 4 Ton siap sortir. Menawarkan harga kemitraan mingguan Rp 5.200/kg.”',
      commodityTag: 'PET Press Kotor',
      priceTag: 'Tawaran: Rp 5.200/kg',
      priceTagBg: const Color(0xFFDCFCE7),
      priceTagTextColor: const Color(0xFF15803D),
      unreadCount: null,
      unreadCountBg: null,
      destination: const NewNegotiationScreen(
        materialName: 'Botol PET Press Kotor Siap Sortir',
        partnerName: 'Bank Sampah Induk Makmur',
        partnerLocation: 'Depo Agregator Surabaya',
        baselinePrice: 5200,
        initialTonnage: 4.0,
        initialPrice: 5200,
      ),
    ),
    NegotiationInboxItem(
      id: 'inbox-5',
      code: '#KONTRAK-8802',
      partnerName: 'CV Perkasa Abadi',
      partnerInitials: 'PA',
      avatarBgColor: const Color(0xFFF1F5F9),
      avatarTextColor: const Color(0xFF64748B),
      statusDotColor: null,
      partnerType: 'Pabrik Plastik',
      time: '28 Sep',
      statusBadge: 'Tersepakati',
      statusBadgeBg: const Color(0xFFDCFCE7),
      statusBadgeTextColor: const Color(0xFF15803D),
      snippet:
          '“Kontrak pasokan Flakes HDPE 10 Ton telah ditandatangani secara digital. Jadwal pengiriman batch 1...”',
      commodityTag: 'HDPE Flakes',
      priceTag: 'Rp 14.200/kg',
      priceTagIcon: Icons.check_circle_outline_rounded,
      priceTagBg: const Color(0xFFDCFCE7),
      priceTagTextColor: const Color(0xFF15803D),
      unreadCount: null,
      unreadCountBg: null,
      destination: const TransactionSuccessScreen(),
    ),
  ];

  List<NegotiationInboxItem> get _filteredItems {
    final query = _searchController.text.trim().toLowerCase();
    return _items.where((item) {
      final matchesSearch = query.isEmpty ||
          item.partnerName.toLowerCase().contains(query) ||
          item.code.toLowerCase().contains(query) ||
          item.commodityTag.toLowerCase().contains(query) ||
          item.snippet.toLowerCase().contains(query);

      if (!matchesSearch) return false;

      if (_selectedFilterIndex == 1) {
        // Menunggu Respon
        return item.statusBadge == 'Tawaran Baru' ||
            item.statusBadge == 'Counter Offer';
      } else if (_selectedFilterIndex == 2) {
        // Tawaran Masuk
        return item.statusBadge == 'Tawaran Masuk' ||
            item.statusBadge == 'Tawaran Baru';
      } else if (_selectedFilterIndex == 3) {
        // Tersepakati
        return item.statusBadge == 'Tersepakati';
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
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Search Bar & Filter Chips
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Column(
                    children: [
                      _buildSearchBar(),
                      const SizedBox(height: 12),
                      _buildFilterChips(),
                    ],
                  ),
                ),
              ),

              // Items List
              if (items.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tidak ada negosiasi ditemukan',
                          style: TextStyle(
                            fontSize: 14,
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
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 80),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildInboxCard(context, item),
                        );
                      },
                      childCount: items.length,
                    ),
                  ),
                ),
            ],
          ),

          // Floating Action Button: Buat Tawaran Baru
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Center(
              child: _buildFloatingNewOfferButton(context),
            ),
          ),
        ],
      ),
      bottomNavigationBar: WasteHubBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const TransactionListScreen(),
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
          // WasteHub Green Square Icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF0A4D3C),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.swap_horiz_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Kotak Masuk Negosiasi',
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
        // Notification Bell with Orange Dot
        Stack(
          children: [
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
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFFF59E0B),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
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
  // SEARCH BAR WIDGET
  // ---------------------------------------------------------
  Widget _buildSearchBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x04000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
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
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF0F172A),
              ),
              decoration: const InputDecoration(
                hintText: 'Cari nama mitra atau komoditas...',
                hintStyle: TextStyle(
                  fontSize: 12.5,
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
  // INBOX CARD COMPONENT
  // ---------------------------------------------------------
  Widget _buildInboxCard(BuildContext context, NegotiationInboxItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => item.destination),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
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
            // Top Row: Avatar + Info + Time & Status Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar with optional status dot
                Stack(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: item.avatarBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          item.partnerInitials,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: item.avatarTextColor,
                          ),
                        ),
                      ),
                    ),
                    if (item.statusDotColor != null)
                      Positioned(
                        top: -1,
                        right: -1,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: item.statusDotColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 10),

                // Name & Code/Type
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.partnerName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${item.code} • ${item.partnerType}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Time & Status Badge Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.time,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (item.statusBadge != null) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: item.statusBadgeBg ?? const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.statusBadge!,
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            color: item.statusBadgeTextColor ??
                                const Color(0xFF475569),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Message Snippet
            Text(
              item.snippet,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11.5,
                color: Color(0xFF334155),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),

            // Bottom Tags Row: Commodity Tag + Price Tag + Unread Badge / Chevron
            Row(
              children: [
                // Commodity Tag
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item.commodityTag,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475569),
                    ),
                  ),
                ),
                const SizedBox(width: 6),

                // Price / Offer Tag
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: item.priceTagBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.priceTagIcon != null) ...[
                        Icon(
                          item.priceTagIcon,
                          size: 11,
                          color: item.priceTagTextColor,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        item.priceTag,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: item.priceTagTextColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Unread Count Badge
                if (item.unreadCount != null) ...[
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: item.unreadCountBg ?? const Color(0xFF0A4D3C),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        item.unreadCount.toString(),
                        style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                ],

                // Arrow Chevron
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: Color(0xFF94A3B8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // FLOATING ACTION BUTTON: Buat Tawaran Baru
  // ---------------------------------------------------------
  Widget _buildFloatingNewOfferButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x330A4D3C),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: const Color(0xFF1E4D3E),
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NewNegotiationScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.add_circle_outline_rounded,
                  size: 18,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Buat Tawaran Baru',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
