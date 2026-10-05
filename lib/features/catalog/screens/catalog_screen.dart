import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/wastehub_bottom_nav.dart';
import '../../business/screens/business_dashboard_screen.dart';
import '../../monitoring/widgets/market_summary_card.dart';
import '../../negotiation/screens/counter_offer_screen.dart';
import '../../negotiation/screens/negotiation_inbox_screen.dart';
import '../../negotiation/screens/new_negotiation_screen.dart';
import '../../negotiation/widgets/nego_bottom_sheet.dart';
import '../../transaction/screens/transaction_list_screen.dart';
import '../models/commodity_item.dart';
import '../widgets/app_bar_header.dart';
import '../widgets/category_chips.dart';
import '../widgets/commodity_card.dart';
import '../widgets/commodity_detail_sheet.dart';
import '../widgets/search_bar_widget.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _currentNavIndex = 0;
  String _selectedCategory = 'Semua Komoditas';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'Semua Komoditas',
    'Plastik PET',
    'Kertas OCC',
    'Logam Non-Ferrous',
    'Polimer Polyethylene',
  ];

  List<CommodityItem> get _filteredCommodities {
    final query = _searchController.text.toLowerCase().trim();
    return mockCommodities.where((item) {
      final matchesSearch = query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query) ||
          item.specs.toLowerCase().contains(query) ||
          item.location.toLowerCase().contains(query);

      final matchesCategory = _selectedCategory == 'Semua Komoditas' ||
          (_selectedCategory == 'Plastik PET' &&
              item.category.contains('POLIMER TERMOPLASTIK')) ||
          (_selectedCategory == 'Kertas OCC' &&
              item.category.contains('KERTAS')) ||
          (_selectedCategory == 'Logam Non-Ferrous' &&
              item.category.contains('METAL')) ||
          (_selectedCategory == 'Polimer Polyethylene' &&
              item.category.contains('POLYETHYLENE'));

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _openNegoSheet(CommodityItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => NegoBottomSheet(item: item),
    );
  }

  void _openDetailSheet(CommodityItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CommodityDetailSheet(
        item: item,
        onNegoPressed: () {
          Navigator.pop(ctx);
          _openNegoSheet(item);
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredCommodities;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. TOP HEADER & SEARCH SLIVER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppBarHeader(),
                    const SizedBox(height: 20),

                    const Text(
                      'Katalog Komoditas Daur',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Market Summary Card (Capability 4: Ellroy)
                    const MarketSummaryCard(),
                    const SizedBox(height: 14),

                    // Search Bar
                    SearchBarWidget(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      onClear: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      onFilterTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Filter lanjutan: Parameter Kadar Air & Lokasi'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // 2. HORIZONTAL CATEGORY CHIPS
            SliverToBoxAdapter(
              child: CategoryChips(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onSelected: (cat) {
                  setState(() {
                    _selectedCategory = cat;
                  });
                },
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),

            // 3. COMMODITY CARDS LIST
            if (items.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.inventory_2_outlined,
                            size: 48, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          'Komoditas tidak ditemukan',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Coba kata kunci atau filter kategori lain',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: CommodityCard(
                          item: item,
                          onTap: () => _openDetailSheet(item),
                          onNegoPressed: () {
                            if (item.id == 'comm-1') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const NewNegotiationScreen(),
                                ),
                              );
                            } else if (item.id == 'comm-2') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CounterOfferScreen(),
                                ),
                              );
                            } else {
                              _openNegoSheet(item);
                            }
                          },
                        ),
                      );
                    },
                    childCount: items.length,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: WasteHubBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const TransactionListScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NegotiationInboxScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
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
}

typedef CommodityCatalogScreen = CatalogScreen;
