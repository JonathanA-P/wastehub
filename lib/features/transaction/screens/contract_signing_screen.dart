import 'package:flutter/material.dart';
import '../../../core/utils/currency_formatter.dart';
import 'transaction_success_screen.dart';

class ContractSigningScreen extends StatefulWidget {
  final String contractNumber;
  final String aktaNumber;
  final String effectiveDate;
  final String commodityName;
  final String commodityGrade;
  final String sellerName;
  final String sellerNib;
  final String buyerName;
  final String buyerId;
  final int totalQuantity;
  final String moistureSpec;
  final int unitPrice;
  final int totalValue;
  final String totalValueSpelled;
  final String sellerSignRef;
  final String imageUrl;

  const ContractSigningScreen({
    super.key,
    this.contractNumber = 'MoA-2026/OCC-941',
    this.aktaNumber = 'CTR/WH-2026/IX/8941',
    this.effectiveDate = '30 September 2026',
    this.commodityName = 'Kardus Bekas (OCC) Sortir Bal Super',
    this.commodityGrade = 'Grade A\nIndustri',
    this.sellerName = 'PT Daurindo Jaya',
    this.sellerNib = '9120004928182',
    this.buyerName = 'Pembeli Terverifikasi',
    this.buyerId = 'IND-BYR-7729',
    this.totalQuantity = 5000,
    this.moistureSpec = 'Maks. 9%',
    this.unitPrice = 2050,
    this.totalValue = 10250000,
    this.totalValueSpelled =
        'Sepuluh Juta Dua Ratus Lima Puluh Ribu Rupiah',
    this.sellerSignRef = 'E-SIGN-300926-DJ',
    this.imageUrl =
        'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=600&auto=format&fit=crop&q=80',
  });

  @override
  State<ContractSigningScreen> createState() => _ContractSigningScreenState();
}

class _ContractSigningScreenState extends State<ContractSigningScreen> {
  bool _isBuyerSigned = false;
  bool _isProcessing = false;

  void _handleSignContract() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _buildSignatureBottomSheet(ctx),
    );
  }

  Widget _buildSignatureBottomSheet(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 18),

          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.draw_rounded,
                  color: Color(0xFF166534),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Otorisasi Tanda Tangan Digital',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      'Sertifikasi Elektronik BSrE / Kominfo Terikat',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                _buildModalDetailRow('Nomor Kontrak', widget.contractNumber),
                const SizedBox(height: 6),
                _buildModalDetailRow('Komoditas', widget.commodityName),
                const SizedBox(height: 6),
                _buildModalDetailRow(
                  'Total Nilai',
                  'Rp ${CurrencyFormatter.formatRupiah(widget.totalValue)}',
                  isBold: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Dengan melanjutkan, Anda secara hukum menyetujui seluruh klausul transaksi ini dan mengesahkan penerbitan Surat Perintah Kerja (SPK) serta rekening penampung (Escrow).',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF64748B),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                setState(() {
                  _isProcessing = true;
                });

                Future.delayed(const Duration(milliseconds: 700), () {
                  if (mounted) {
                    setState(() {
                      _isBuyerSigned = true;
                      _isProcessing = false;
                    });

                    // Navigate to TransactionSuccessScreen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TransactionSuccessScreen(),
                      ),
                    );
                  }
                });
              },
              icon: const Icon(Icons.fingerprint_rounded, size: 20),
              label: const Text(
                'Konfirmasi & Bubuhkan e-Sign',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A4D3C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModalDetailRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
        child: _buildContractCard(context),
      ),
      bottomNavigationBar: _buildBottomStickyBar(context),
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
        children: [
          const Text(
            'Pengesahan Kontrak Digital',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            widget.contractNumber,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
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
  // MAIN CONTRACT CARD COMPONENT
  // ---------------------------------------------------------
  Widget _buildContractCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: MoA Title
          const Text(
            'Memorandum of Agreement Jual–Beli Komoditas',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),

          // Metadata Row: Akta Digital & Tanggal Efektif
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nomor Akta Digital:',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.aktaNumber,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Tanggal Efektif:',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.effectiveDate,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          const Divider(color: Color(0xFFE2E8F0), height: 1),
          const SizedBox(height: 14),

          // Objek Komoditas Image Hero Banner
          _buildCommodityBanner(),
          const SizedBox(height: 16),

          // Para Pihak Penandatangan
          _buildSignatoryParties(),
          const SizedBox(height: 16),

          const Divider(color: Color(0xFFE2E8F0), height: 1),
          const SizedBox(height: 16),

          // Klausul & Rincian Pasal Transaksi
          _buildContractClauses(),
          const SizedBox(height: 14),

          // Total Nilai Kontrak Box
          _buildTotalValueBox(),
          const SizedBox(height: 16),

          const Divider(color: Color(0xFFE2E8F0), height: 1),
          const SizedBox(height: 16),

          // Area Tanda Tangan Digital (E-Sign)
          _buildDigitalSignaturesArea(),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // COMMODITY BANNER WIDGET
  // ---------------------------------------------------------
  Widget _buildCommodityBanner() {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF334155),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF334155),
                child: const Center(
                  child: Icon(
                    Icons.inventory_2_rounded,
                    color: Colors.white54,
                    size: 32,
                  ),
                ),
              ),
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.85),
                    Colors.black.withValues(alpha: 0.4),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
            // Content Over Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Objek Komoditas:',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.commodityName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF164E3E),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: const Color(0xFF22C55E).withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      widget.commodityGrade,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // PARA PIHAK PENANDATANGAN
  // ---------------------------------------------------------
  Widget _buildSignatoryParties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PARA PIHAK PENANDATANGAN',
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF64748B),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Pihak I (Penjual)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'PIHAK I (PENJUAL)',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0A4D3C),
                          ),
                        ),
                        Icon(
                          Icons.apartment_rounded,
                          size: 13,
                          color: Color(0xFF0A4D3C),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.sellerName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'NIB: ${widget.sellerNib}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Pihak II (Pembeli)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'PIHAK II (PEMBELI)',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0A4D3C),
                          ),
                        ),
                        Icon(
                          Icons.verified_user_outlined,
                          size: 13,
                          color: Color(0xFF0A4D3C),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.buyerName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'ID: ${widget.buyerId}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------
  // KLAUSUL & RINCIAN PASAL TRANSAKSI
  // ---------------------------------------------------------
  Widget _buildContractClauses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'KLAUSUL & RINCIAN PASAL TRANSAKSI',
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF64748B),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),

        // Pasal 1: Kuantitas Bersih
        _buildClauseItem(
          title: 'Pasal Kuantitas Bersih',
          description: 'Sesuai penimbangan jembatan timbang terkalibrasi',
          metricText:
              '${CurrencyFormatter.formatRupiah(widget.totalQuantity)} kg',
        ),
        const SizedBox(height: 10),

        // Pasal 2: Toleransi Kadar Air
        _buildClauseItem(
          title: 'Toleransi Kadar Air',
          description: 'Uji kelembaban digital porta-tester',
          metricText: widget.moistureSpec,
        ),
        const SizedBox(height: 10),

        // Pasal 3: Harga Satuan Terikat
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: Color(0xFF16A34A),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Harga Satuan Terikat',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
                children: [
                  TextSpan(
                    text:
                        'Rp  ${CurrencyFormatter.formatRupiah(widget.unitPrice)} ',
                  ),
                  const TextSpan(
                    text: '/kg',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildClauseItem({
    required String title,
    required String description,
    required String metricText,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: Color(0xFF16A34A),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
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
              const SizedBox(height: 1),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          metricText,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------
  // TOTAL NILAI KONTRAK BOX
  // ---------------------------------------------------------
  Widget _buildTotalValueBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Nilai Kontrak',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.totalValueSpelled,
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF64748B),
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Rp',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0A4D3C),
                ),
              ),
              Text(
                CurrencyFormatter.formatRupiah(widget.totalValue),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0A4D3C),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // AREA TANDA TANGAN DIGITAL (E-SIGN)
  // ---------------------------------------------------------
  Widget _buildDigitalSignaturesArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'AREA TANDA TANGAN DIGITAL (E-SIGN)',
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF64748B),
                letterSpacing: 0.5,
              ),
            ),
            Row(
              children: [
                Icon(Icons.circle, size: 6, color: Color(0xFF16A34A)),
                SizedBox(width: 4),
                Text(
                  'SIAP DITEKEN',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF16A34A),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            // Pihak Pertama (PT Daurindo Jaya) - Solid Signed Box
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PIHAK PERTAMA',
                      style: TextStyle(
                        fontSize: 8.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.sellerName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.draw_rounded,
                            size: 11,
                            color: Color(0xFF166534),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'TERTANDATANGANI',
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF166534),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      'Ref: ${widget.sellerSignRef}',
                      style: const TextStyle(
                        fontSize: 8.5,
                        fontFamily: 'monospace',
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Pihak Kedua (Pembeli) - Dashed Awaiting E-sign Box
            Expanded(
              child: CustomPaint(
                painter: _DashedRectPainter(
                  color: _isBuyerSigned
                      ? const Color(0xFF16A34A)
                      : const Color(0xFF64748B),
                  strokeWidth: 1.2,
                  gap: 4,
                  radius: 12,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PIHAK KEDUA',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.buyerName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),

                      if (_isBuyerSigned) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.draw_rounded,
                                size: 11,
                                color: Color(0xFF166534),
                              ),
                              SizedBox(width: 4),
                              Text(
                                'TERTANDATANGANI',
                                style: TextStyle(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF166534),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Ref: E-SIGN-051026-BYR',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontFamily: 'monospace',
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ] else ...[
                        Center(
                          child: Column(
                            children: const [
                              Icon(
                                Icons.fingerprint_rounded,
                                size: 22,
                                color: Color(0xFF0A4D3C),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Menunggu e-Sign Anda',
                                style: TextStyle(
                                  fontSize: 9.5,
                                  color: Color(0xFF334155),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------
  // BOTTOM STICKY ACTION BAR
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
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _isProcessing ? null : _handleSignContract,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E4D3E),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isProcessing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Tandatangani Kontrak',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 16),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// CUSTOM DASHED BORDER PAINTER
// ---------------------------------------------------------
class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double radius;

  _DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
    this.radius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final length = draw ? gap : gap;
        if (draw) {
          final extractPath = metric.extractPath(
            distance,
            (distance + length).clamp(0.0, metric.length),
          );
          canvas.drawPath(extractPath, paint);
        }
        distance += length;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedRectPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap;
  }
}
