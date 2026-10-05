import 'package:flutter/material.dart';
import '../../monitoring/screens/logistics_tracking_screen.dart';
import '../../negotiation/screens/counter_offer_screen.dart';
import '../../transaction/screens/bast_digital_screen.dart';
import '../../transaction/screens/contract_signing_screen.dart';

class NotificationItem {
  final String id;
  final String category; // 'Pengiriman', 'Negosiasi', 'Kontrak & Escrow'
  final String title;
  final String subtitle;
  final String time;
  final bool isUnread;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final Widget destination;

  NotificationItem({
    required this.id,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isUnread,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.destination,
  });
}

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() =>
      _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  int _selectedFilterIndex = 0; // 0: Semua, 1: Pengiriman, 2: Negosiasi, 3: Kontrak & Escrow

  late List<NotificationItem> _notifications = [
    NotificationItem(
      id: 'notif-1',
      category: 'Pengiriman',
      title: 'Truk B 9241 UZ Mendekati Gerbang Bitung',
      subtitle:
          'Sisa jarak 15 km (Estimasi tiba 10:45 WIB). Siapkan staf timbangan dan penguji mutu.',
      time: '10 menit lalu',
      isUnread: true,
      icon: Icons.local_shipping_rounded,
      iconColor: const Color(0xFFD97706),
      iconBg: const Color(0xFFFEF3C7),
      destination: const LogisticsTrackingScreen(),
    ),
    NotificationItem(
      id: 'notif-2',
      category: 'Negosiasi',
      title: 'Counter Offer Diterima (#OF-441)',
      subtitle:
          'PT Daur Alam Lestari menawarkan penyesuaian harga Rp 11.500/kg untuk PET Flakes Hot-Washed.',
      time: '25 menit lalu',
      isUnread: true,
      icon: Icons.forum_rounded,
      iconColor: const Color(0xFF0A4D3C),
      iconBg: const Color(0xFFECFDF5),
      destination: const CounterOfferScreen(),
    ),
    NotificationItem(
      id: 'notif-3',
      category: 'Kontrak & Escrow',
      title: 'Dana Escrow Rp 59.103.000 Berhasil Dicairkan',
      subtitle:
          'Pencairan dana untuk BAST #BAST-2026/DAL/0790 telah masuk ke rekening Mandiri PT Sinar Logam.',
      time: '2 jam lalu',
      isUnread: false,
      icon: Icons.account_balance_wallet_rounded,
      iconColor: const Color(0xFF16A34A),
      iconBg: const Color(0xFFDCFCE7),
      destination: const BastDigitalScreen(),
    ),
    NotificationItem(
      id: 'notif-4',
      category: 'Kontrak & Escrow',
      title: 'Draft Kontrak Digital Siap Ditandatangani',
      subtitle:
          'Kontrak #WH-CTR-2026-0812 (PET Bening Cacah 8 Ton) menunggu e-Sign PrivyID Anda.',
      time: 'Kemarin',
      isUnread: false,
      icon: Icons.draw_rounded,
      iconColor: const Color(0xFF0284C7),
      iconBg: const Color(0xFFE0F2FE),
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
    NotificationItem(
      id: 'notif-5',
      category: 'Pengiriman',
      title: 'Tiket Jembatan Timbang Terverifikasi',
      subtitle:
          'Tiket timbang digital #WB-20261005-0982 telah diverifikasi oleh Metrologi Legal Depo Cikande.',
      time: '1 hari lalu',
      isUnread: false,
      icon: Icons.scale_rounded,
      iconColor: const Color(0xFF475569),
      iconBg: const Color(0xFFF1F5F9),
      destination: const LogisticsTrackingScreen(),
    ),
  ];

  final List<String> _filters = [
    'Semua',
    'Pengiriman',
    'Negosiasi',
    'Kontrak & Escrow',
  ];

  List<NotificationItem> get _filteredNotifications {
    if (_selectedFilterIndex == 0) return _notifications;
    final selectedCategory = _filters[_selectedFilterIndex];
    return _notifications
        .where((n) => n.category == selectedCategory)
        .toList();
  }

  void _markAllAsRead() {
    setState(() {
      _notifications = _notifications.map((n) {
        return NotificationItem(
          id: n.id,
          category: n.category,
          title: n.title,
          subtitle: n.subtitle,
          time: n.time,
          isUnread: false,
          icon: n.icon,
          iconColor: n.iconColor,
          iconBg: n.iconBg,
          destination: n.destination,
        );
      }).toList();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF0A4D3C),
        content: Text('Semua notifikasi telah ditandai sebagai dibaca.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredNotifications;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          // Filter Chips Row
          _buildFilterChips(),

          // Notification List
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off_outlined,
                            size: 48, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          'Tidak ada notifikasi dalam kategori ini',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _buildNotificationCard(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final unreadCount = _notifications.where((n) => n.isUnread).length;

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
      title: Row(
        children: [
          const Text(
            'Pusat Notifikasi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),
          if (unreadCount > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$unreadCount Baru',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _markAllAsRead,
          child: const Text(
            'Tandai Dibaca',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0A4D3C),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: const Color(0xFFE2E8F0), height: 1),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(_filters.length, (index) {
            final isSelected = _selectedFilterIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () => setState(() => _selectedFilterIndex = index),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF0A4D3C)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF0A4D3C)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Text(
                    _filters[index],
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF475569),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => item.destination),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: item.isUnread ? Colors.white : const Color(0xFFFBFBFA),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: item.isUnread
                ? const Color(0xFF86EFAC)
                : const Color(0xFFE2E8F0),
            width: item.isUnread ? 1.2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Badge
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: item.iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(item.icon, size: 20, color: item.iconColor),
              ),
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.category.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF475569),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      Text(
                        item.time,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: item.isUnread
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: item.isUnread
                              ? const Color(0xFF0A4D3C)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight:
                          item.isUnread ? FontWeight.w800 : FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 3),

                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),

            if (item.isUnread) ...[
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF10B981),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
