import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CommodityItem {
  final String id;
  final String category;
  final Color categoryColor;
  final String title;
  final String badge;
  final String specs;
  final int spotPrice;
  final double minOrder;
  final String location;
  final String trend;
  final Color trendColor;
  final Color trendBgColor;
  final String imageUrl;
  final String sellerName;
  final String sellerType; // Bank Sampah, TPS3R, TPST
  final double availableStock;

  const CommodityItem({
    required this.id,
    required this.category,
    required this.categoryColor,
    required this.title,
    required this.badge,
    required this.specs,
    required this.spotPrice,
    required this.minOrder,
    required this.location,
    required this.trend,
    required this.trendColor,
    required this.trendBgColor,
    required this.imageUrl,
    required this.sellerName,
    required this.sellerType,
    required this.availableStock,
  });
}

final List<CommodityItem> mockCommodities = [
  const CommodityItem(
    id: 'comm-1',
    category: 'POLIMER TERMOPLASTIK',
    categoryColor: Color(0xFF047857),
    title: 'Flakes PET Bening (Hot Washed)',
    badge: 'Grade A',
    specs: 'Kadar Air < 1% • PVC Kontaminasi < 50 ppm',
    spotPrice: 13450,
    minOrder: 5.0,
    location: 'Gudang Karawang, Jawa Barat',
    trend: '↑ +2.8%',
    trendColor: AppColors.trendUpText,
    trendBgColor: AppColors.trendUpBg,
    imageUrl:
        'https://images.unsplash.com/photo-1611284446314-60a58ac0deb9?w=300&auto=format&fit=crop&q=80',
    sellerName: 'TPS3R Berkah Lestari',
    sellerType: 'TPS3R',
    availableStock: 18.5,
  ),
  const CommodityItem(
    id: 'comm-2',
    category: 'KERTAS INDUSTRI (OCC)',
    categoryColor: Color(0xFFB45309),
    title: 'Kardus Gelombang OCC 95/5',
    badge: 'Bal Press',
    specs: 'Moisture < 12% • Reject Bahan Lain < 2%',
    spotPrice: 2150,
    minOrder: 10.0,
    location: 'Depo Cikarang & Surabaya',
    trend: 'Stabil 0.0%',
    trendColor: AppColors.trendStableText,
    trendBgColor: AppColors.trendStableBg,
    imageUrl:
        'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=300&auto=format&fit=crop&q=80',
    sellerName: 'Bank Sampah Induk Gemah Ripah',
    sellerType: 'Bank Sampah Induk',
    availableStock: 42.0,
  ),
  const CommodityItem(
    id: 'comm-3',
    category: 'METAL & LOGAM NON-FERROUS',
    categoryColor: Color(0xFF475569),
    title: 'Scrap Aluminium Kaleng (UBC)',
    badge: 'UBC Bal',
    specs: 'Kemurnian > 96% • Press Bal Padat Siap Lebur',
    spotPrice: 19800,
    minOrder: 3.0,
    location: 'Hub Logistik Gresik, Jatim',
    trend: '↓ -1.2%',
    trendColor: AppColors.trendDownText,
    trendBgColor: AppColors.trendDownBg,
    imageUrl:
        'https://images.unsplash.com/photo-1574974671999-24b7dfba0d53?w=300&auto=format&fit=crop&q=80',
    sellerName: 'TPST Bantar Gebang Mitra Bersama',
    sellerType: 'TPST',
    availableStock: 12.0,
  ),
  const CommodityItem(
    id: 'comm-4',
    category: 'POLIMER POLYETHYLENE',
    categoryColor: Color(0xFF047857),
    title: 'HDPE Pellet Natural (Blow Grade)',
    badge: 'Pellet',
    specs: 'MFI 0.35 g/10min • Filter 100 Mesh Double',
    spotPrice: 16200,
    minOrder: 5.0,
    location: 'Kawasan Industri Tangerang',
    trend: '↑ +4.1%',
    trendColor: AppColors.trendUpText,
    trendBgColor: AppColors.trendUpBg,
    imageUrl:
        'https://images.unsplash.com/photo-1597484661643-2f5fef640dd1?w=300&auto=format&fit=crop&q=80',
    sellerName: 'TPS3R Rawasari Mandiri',
    sellerType: 'TPS3R',
    availableStock: 25.0,
  ),
];
