import 'package:flutter/material.dart';
import '../../../core/utils/currency_formatter.dart';

class BastDigitalScreen extends StatelessWidget {
  final String bastNumber;
  final String contractCode;
  final String dateText;
  final String sellerName;
  final String buyerName;
  final String commodityName;
  final int tonnageKg;
  final int unitPrice;
  final int grossWeightKg;
  final int tareWeightKg;

  const BastDigitalScreen({
    super.key,
    this.bastNumber = 'BAST-2026/DAL/0790',
    this.contractCode = '#WH-CTR-2026-0790',
    this.dateText = '24 Februari 2026 • 14:30 WIB',
    this.sellerName = 'PT Sinar Logam',
    this.buyerName = 'PT WasteHub Circular Indonesia',
    this.commodityName = 'Scrap Aluminium Kaleng UBC (Press Bal Padat)',
    this.tonnageKg = 3000,
    this.unitPrice = 19800,
    this.grossWeightKg = 8480,
    this.tareWeightKg = 5480,
  });

  int get _totalValue => tonnageKg * unitPrice;
  int get _platformFee => (_totalValue * 0.005).round();
  int get _netDisbursed => _totalValue - _platformFee;

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
            // Status Header Badge
            _buildOfficialHeaderCard(),
            const SizedBox(height: 14),

            // QC Sucofindo Inspection Badge
            _buildQcSucofindoCard(),
            const SizedBox(height: 14),

            // Weighbridge & Net Tonnage Reconciliation
            _buildTonnageReconciliationCard(),
            const SizedBox(height: 14),

            // Escrow Disbursement Breakdown
            _buildEscrowSettlementCard(),
            const SizedBox(height: 14),

            // Dual & Witness Digital Signatures
            _buildSignaturesCard(),
            const SizedBox(height: 20),

            // Action Buttons
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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Berita Acara Serah Terima (BAST)',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),
          Text(
            bastNumber,
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
                content: Text('Tautan BAST $bastNumber disalin ke clipboard!'),
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
  // OFFICIAL HEADER CARD
  // ---------------------------------------------------------
  Widget _buildOfficialHeaderCard() {
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFBBF7D0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.check_circle_rounded,
                        size: 13, color: Color(0xFF16A34A)),
                    SizedBox(width: 5),
                    Text(
                      'Selesai & Dicairkan',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF166534),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                dateText,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Text(
            commodityName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),

          Text(
            'Kontrak: $contractCode • Fasilitas Bitung',
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Penjual',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        sellerName,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 1, height: 28, color: const Color(0xFFCBD5E1)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pembeli',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        buyerName,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0A4D3C),
                        ),
                      ),
                    ],
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
  // QC SUCOFINDO INSPECTION
  // ---------------------------------------------------------
  Widget _buildQcSucofindoCard() {
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
                  Icon(Icons.verified_outlined,
                      size: 18, color: Color(0xFF0A4D3C)),
                  SizedBox(width: 6),
                  Text(
                    'Hasil Uji Mutu Laboratorium Sucofindo',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'GRADE A (PASS)',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF047857),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          _buildQcItemRow('Kemurnian Aluminium Alloy', '96.4%', 'Min. 96.0%', true),
          const Divider(height: 14, color: Color(0xFFE2E8F0)),
          _buildQcItemRow('Impuritas & Kontaminan Besi', '0.8%', 'Maks. 2.0%', true),
          const Divider(height: 14, color: Color(0xFFE2E8F0)),
          _buildQcItemRow('Kadar Air (Moisture)', '0.3%', 'Maks. 1.0%', true),
          const Divider(height: 14, color: Color(0xFFE2E8F0)),
          _buildQcItemRow('Sertifikat COA Sucofindo', 'COA-SUCO-2026-9921',
              'Terakreditasi KAN', true),
        ],
      ),
    );
  }

  Widget _buildQcItemRow(
      String parameter, String actual, String standard, bool isPass) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                parameter,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                'Standar Kontrak: $standard',
                style: const TextStyle(
                  fontSize: 9.5,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              actual,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0A4D3C),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.check_circle_rounded,
                size: 14, color: Color(0xFF16A34A)),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------
  // TONNAGE RECONCILIATION
  // ---------------------------------------------------------
  Widget _buildTonnageReconciliationCard() {
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
            'Rekonsiliasi Timbangan Netto & SPK',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              _buildTonnageMetric('SPK KONTRAK', '$tonnageKg kg', const Color(0xFF64748B)),
              const SizedBox(width: 8),
              _buildTonnageMetric('TIMBANG MASUK', '${grossWeightKg - tareWeightKg} kg', const Color(0xFF64748B)),
              const SizedBox(width: 8),
              _buildTonnageMetric('NETTO DIAKUI', '$tonnageKg kg', const Color(0xFF0A4D3C), isHighlight: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTonnageMetric(String label, String value, Color color,
      {bool isHighlight = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: isHighlight ? const Color(0xFFECFDF5) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
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
            const SizedBox(height: 3),
            Text(
              value,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // ESCROW SETTLEMENT BREAKDOWN
  // ---------------------------------------------------------
  Widget _buildEscrowSettlementCard() {
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
                'Pencairan Dana Rekening Bersama (Escrow)',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'SETTLED',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF166534),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          _buildSettlementRow('Total Nilai Transaksi ($tonnageKg kg × Rp ${CurrencyFormatter.formatRupiah(unitPrice)})',
              'Rp ${CurrencyFormatter.formatRupiah(_totalValue)}'),
          const SizedBox(height: 6),
          _buildSettlementRow('Biaya Platform WasteHub (0.5%)',
              '- Rp ${CurrencyFormatter.formatRupiah(_platformFee)}',
              isDeduction: true),
          const Divider(height: 16, color: Color(0xFFE2E8F0)),
          _buildSettlementRow(
            'Dana Bersih Dicairkan ke Penjual',
            'Rp ${CurrencyFormatter.formatRupiah(_netDisbursed)}',
            isBold: true,
            highlightColor: const Color(0xFF0A4D3C),
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.account_balance_rounded,
                    size: 14, color: Color(0xFF475569)),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Bank Mandiri Giro PT Sinar Logam (Rek. 131-00-982141-8) • Ref: TXN-ESCR-0790-9941',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475569),
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

  Widget _buildSettlementRow(String label, String value,
      {bool isBold = false, bool isDeduction = false, Color? highlightColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
              color: isBold ? const Color(0xFF0F172A) : const Color(0xFF64748B),
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 13 : 11.5,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
            color: highlightColor ??
                (isDeduction
                    ? const Color(0xFFDC2626)
                    : const Color(0xFF0F172A)),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------
  // DIGITAL SIGNATURES CARD
  // ---------------------------------------------------------
  Widget _buildSignaturesCard() {
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
            'Pengesahan Digital (e-Signature PrivyID & Peruri)',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildSignatureBox(
                  'PIHAK PENJUAL',
                  'Bambang Hermawan',
                  'Direktur Operasional',
                  'E-SIGN-240226-SLG',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSignatureBox(
                  'PIHAK PEMBELI',
                  'Siti Rahmawati',
                  'VP Procurement & QC',
                  'E-SIGN-240226-WHB',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureBox(
      String party, String name, String title, String ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            party,
            style: const TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: const [
              Icon(Icons.fingerprint_rounded,
                  size: 16, color: Color(0xFF0A4D3C)),
              SizedBox(width: 4),
              Text(
                'TERVERIFIKASI',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0A4D3C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 9.5,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ref,
            style: const TextStyle(
              fontSize: 8,
              fontFamily: 'monospace',
              color: Color(0xFF94A3B8),
            ),
          ),
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
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF0A4D3C),
                  content: Text(
                    'Mengunduh dokumen resmi BAST & Sertifikat QC ($bastNumber.pdf)...',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
            label: const Text(
              'Unduh Dokumen Resmi BAST (PDF)',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A4D3C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Kembali ke Daftar Kontrak',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
