import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../transaction/screens/contract_signing_screen.dart';

class CounterOfferScreen extends StatefulWidget {
  final String batchId;
  final String partnerName;
  final String materialName;
  final int initialPrice;
  final int initialQuantity;
  final int marketRefPrice;
  final String location;
  final String grade;

  const CounterOfferScreen({
    super.key,
    this.batchId = '#OF-441',
    this.partnerName = 'PT Daurindo Jaya',
    this.materialName = 'Kardus Bekas OCC Bal Kering',
    this.initialPrice = 2050,
    this.initialQuantity = 5000,
    this.marketRefPrice = 1960,
    this.location = 'Gudang 3, Cikarang Barat',
    this.grade = 'OCC Grade A',
  });

  @override
  State<CounterOfferScreen> createState() => _CounterOfferScreenState();
}

class _CounterOfferScreenState extends State<CounterOfferScreen> {
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _notesController;

  int _currentPrice = 1980;
  int _currentQuantity = 5000;
  String _selectedMoisture = '≤ 9%';

  // Countdown timer for expiration pill
  int _remainingSeconds = 3 * 3600 + 42 * 60 + 10; // 03:42:10
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentPrice = 1980;
    _currentQuantity = widget.initialQuantity;

    _priceController = TextEditingController(text: _currentPrice.toString());
    _quantityController =
        TextEditingController(text: _currentQuantity.toString());
    _notesController = TextEditingController(
      text:
          'Penyesuaian mempertimbangkan indeks pasar Cikarang Rp 1.950–1.980/kg, komitmen armada mandiri tiba jam 08:30 WIB, serta syarat kadar air maksimum 9%.',
    );

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTimer(int totalSecs) {
    final h = (totalSecs ~/ 3600).toString().padLeft(2, '0');
    final m = ((totalSecs % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (totalSecs % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _priceController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // Calculations
  int get _totalCounterOffer => _currentPrice * _currentQuantity;
  int get _totalInitial => widget.initialPrice * _currentQuantity;
  int get _savingAmount => _totalInitial - _totalCounterOffer;
  double get _savingPercent =>
      widget.initialPrice > 0 ? (_savingAmount / _totalInitial) * 100 : 0.0;
  int get _priceDiff => _currentPrice - widget.initialPrice;

  String get _acceptanceProbability {
    final diffFromMarket = _currentPrice - widget.marketRefPrice;
    if (diffFromMarket >= 0) {
      return 'Sangat Realistis (~88%)';
    } else if (diffFromMarket >= -50) {
      return 'Sangat Realistis (~84%)';
    } else if (diffFromMarket >= -100) {
      return 'Moderat (~65%)';
    } else {
      return 'Rendah (<50%)';
    }
  }

  void _setPrice(int newPrice) {
    setState(() {
      _currentPrice = newPrice;
      _priceController.text = newPrice.toString();
    });
  }

  void _setQuantity(int newQty) {
    setState(() {
      _currentQuantity = newQty;
      _quantityController.text = newQty.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CARD 1: TAWARAN ASAL MITRA
            _buildPartnerOfferCard(),
            const SizedBox(height: 16),

            // CARD 2: FORMULIR PENYESUAIAN (TAWARAN BALIK ANDA)
            _buildCounterOfferFormCard(),
          ],
        ),
      ),
      bottomSheet: _buildBottomActionBar(context),
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
            'Ruang Negosiasi',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: -0.2,
            ),
          ),
          Text(
            'Batch ${widget.batchId} • OCC Bal',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
      actions: [
        // Expiration Pill Badge
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFFD97706),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kedaluwarsa',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFB45309),
                      height: 1.0,
                    ),
                  ),
                  Text(
                    _formatTimer(_remainingSeconds),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFB45309),
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Color(0xFF475569)),
          onPressed: () {},
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
  // CARD 1: TAWARAN ASAL MITRA
  // ---------------------------------------------------------
  Widget _buildPartnerOfferCard() {
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
            blurRadius: 8,
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
              const Text(
                'TAWARAN ASAL MITRA',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.6,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  widget.grade,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF334155),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Partner Name
          Text(
            widget.partnerName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),

          // Product Row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 58,
                  height: 58,
                  color: const Color(0xFFF1F5F9),
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
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.materialName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Volume Acuan: ${CurrencyFormatter.formatRupiah(widget.initialQuantity)} kg (${(widget.initialQuantity / 1000).toStringAsFixed(0)} Ton)',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    Text(
                      'Lokasi: ${widget.location}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),

          // Initial Price Metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Harga Mitra Awal',
                    style: TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'Rp ${CurrencyFormatter.formatRupiah(widget.initialPrice)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const Text(
                        '/kg',
                        style: TextStyle(
                            fontSize: 10, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Toleransi Air/Kontaminasi',
                    style: TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                  ),
                  const Text(
                    'Maks. 12%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Total Bruto Awal',
                    style: TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                  ),
                  Text(
                    'Rp ${CurrencyFormatter.formatRupiah(widget.initialPrice * widget.initialQuantity)}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // CARD 2: FORMULIR PENYESUAIAN (TAWARAN BALIK ANDA)
  // ---------------------------------------------------------
  Widget _buildCounterOfferFormCard() {
    final diffAmount = _priceDiff.abs();
    final diffPercent =
        ((widget.initialPrice - _currentPrice) / widget.initialPrice) * 100;

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
            blurRadius: 8,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'FORMULIR PENYESUAIAN',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F766E),
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Tawaran Balik Anda',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.tune_rounded,
                        size: 12, color: Color(0xFFB45309)),
                    SizedBox(width: 4),
                    Text(
                      'Mode Tawar',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFB45309),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Section 1: Harga Tawar Baru per Kg
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Harga Tawar Baru per Kg',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _priceDiff <= 0
                      ? const Color(0xFFFEF3C7)
                      : const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _priceDiff <= 0
                      ? '↘ -Rp $diffAmount/kg (-${diffPercent.toStringAsFixed(1)}%)'
                      : '↗ +Rp $diffAmount/kg (+${(-diffPercent).toStringAsFixed(1)}%)',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _priceDiff <= 0
                        ? const Color(0xFFB45309)
                        : const Color(0xFF059669),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Price Input Field
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Row(
              children: [
                const Text(
                  'Rp',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (val) {
                      final parsed = int.tryParse(val);
                      if (parsed != null) {
                        setState(() {
                          _currentPrice = parsed;
                        });
                      }
                    },
                  ),
                ),
                const Text(
                  '/kg',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Quick Price Chips (-50, -20, 1.980, 2.000)
          Row(
            children: [
              _buildPriceChip('-50', () => _setPrice(_currentPrice - 50), false),
              const SizedBox(width: 6),
              _buildPriceChip('-20', () => _setPrice(_currentPrice - 20), false),
              const SizedBox(width: 6),
              _buildPriceChip(
                  '1.980', () => _setPrice(1980), _currentPrice == 1980),
              const SizedBox(width: 6),
              _buildPriceChip(
                  '2.000', () => _setPrice(2000), _currentPrice == 2000),
            ],
          ),
          const SizedBox(height: 12),

          // Market Reference Slider Visual
          _buildMarketReferenceSlider(),
          const SizedBox(height: 18),

          // Section 2: Kuantitas Penyesuaian Batch (kg)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: Text(
                  'Kuantitas Penyesuaian Batch (kg)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Kapasitas Maks Armada: 6.000 kg',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (val) {
                            final parsed = int.tryParse(val);
                            if (parsed != null) {
                              setState(() {
                                _currentQuantity = parsed;
                              });
                            }
                          },
                        ),
                      ),
                      const Text(
                        'kg',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildTonnageChip('4.5T', () => _setQuantity(4500), _currentQuantity == 4500),
              const SizedBox(width: 6),
              _buildTonnageChip('5T', () => _setQuantity(5000), _currentQuantity == 5000),
              const SizedBox(width: 6),
              _buildTonnageChip('6T', () => _setQuantity(6000), _currentQuantity == 6000),
            ],
          ),
          const SizedBox(height: 18),

          // Section 3: Toleransi Kontaminasi & Kadar Air Max
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: Text(
                  'Toleransi Kontaminasi & Kadar Air Max',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                '≤ 9.0% (Standar Ketat)',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F766E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: _buildQualityOption(
                  '≤ 8%',
                  'Super Dry',
                  _selectedMoisture == '≤ 8%',
                  () => setState(() => _selectedMoisture = '≤ 8%'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildQualityOption(
                  '≤ 9%',
                  'Standar Ideal',
                  _selectedMoisture == '≤ 9%',
                  () => setState(() => _selectedMoisture = '≤ 9%'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildQualityOption(
                  '≤ 10%',
                  'Toleransi SNI',
                  _selectedMoisture == '≤ 10%',
                  () => setState(() => _selectedMoisture = '≤ 10%'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Section 4: Dark Calculation Summary Box
          _buildDarkCalculationSummary(),
          const SizedBox(height: 18),

          // Section 5: Alasan Penyesuaian Harga
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: Text(
                  'Alasan Penyesuaian Harga',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Transparan & dapat dinegosiasi',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: TextField(
              controller: _notesController,
              maxLines: 3,
              maxLength: 300,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF1E293B),
                height: 1.4,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                counterText: '',
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Sertakan justifikasi logistik/kualitas agar mitra setuju',
                  style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${_notesController.text.length}/300',
                style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // PRICE REFERENCE SLIDER VISUAL
  // ---------------------------------------------------------
  Widget _buildMarketReferenceSlider() {
    const minP = 1850;
    const maxP = 2050;
    final userFraction =
        ((_currentPrice - minP) / (maxP - minP)).clamp(0.0, 1.0);
    final marketFraction =
        ((widget.marketRefPrice - minP) / (maxP - minP)).clamp(0.0, 1.0);

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final userWidth = w * userFraction;
            final marketX = (w * marketFraction).clamp(0.0, w - 8.0);

            return SizedBox(
              height: 14,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  // Gray track
                  Container(
                    height: 5,
                    width: w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  // Active fill track up to user price
                  Container(
                    height: 5,
                    width: userWidth,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A4D3C),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  // Market Reference indicator dot
                  Positioned(
                    left: marketX,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F766E),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                        boxShadow: const [
                          BoxShadow(color: Color(0x20000000), blurRadius: 2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Min: Rp 1.850',
              style: TextStyle(fontSize: 10, color: Color(0xFF64748B)),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0F766E),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        'Acuan Pasar: Rp ${CurrencyFormatter.formatRupiah(widget.marketRefPrice)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F766E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Awal: Rp ${CurrencyFormatter.formatRupiah(widget.initialPrice)}',
              style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------
  // DARK SUMMARY CARD
  // ---------------------------------------------------------
  Widget _buildDarkCalculationSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: const [
                    Icon(Icons.calculate_outlined,
                        size: 16, color: Color(0xFFF59E0B)),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Total Penawaran Balik',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Rp ${CurrencyFormatter.formatRupiah(_totalCounterOffer)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Potensi Hemat / Selisih:',
                  style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF064E3B),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _savingAmount >= 0
                      ? 'Hemat Rp ${CurrencyFormatter.formatRupiah(_savingAmount)} (${_savingPercent.toStringAsFixed(1)}%)'
                      : 'Lebih Rp ${CurrencyFormatter.formatRupiah(-_savingAmount)} (${(-_savingPercent).toStringAsFixed(1)}%)',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF34D399),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFF334155)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Peluang Konfirmasi Mitra:',
                  style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                ),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle_outline,
                      size: 14, color: Color(0xFF34D399)),
                  const SizedBox(width: 4),
                  Text(
                    _acceptanceProbability,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF34D399),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // HELPER WIDGETS
  // ---------------------------------------------------------
  Widget _buildPriceChip(String text, VoidCallback onTap, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 34,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0A4D3C) : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF0A4D3C) : const Color(0xFFCBD5E1),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : const Color(0xFF334155),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTonnageChip(String text, VoidCallback onTap, bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDCFCE7) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF166534) : const Color(0xFFCBD5E1),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: isSelected ? const Color(0xFF166534) : const Color(0xFF334155),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQualityOption(
      String title, String subtitle, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFECFDF5) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF0A4D3C) : const Color(0xFFCBD5E1),
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: isSelected ? const Color(0xFF0A4D3C) : const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFF0F766E) : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // BOTTOM STICKY ACTION BAR
  // ---------------------------------------------------------
  Widget _buildBottomActionBar(BuildContext context) {
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
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text('Konfirmasi Counter Offer'),
                      content: Text(
                        'Ajukan penawaran harga baru Rp ${_priceController.text}/kg untuk ${_quantityController.text} kg (Total: Rp ${CurrencyFormatter.formatRupiah(_totalCounterOffer)}) ke ${widget.partnerName}?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Batal'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A4D3C),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ContractSigningScreen(
                                  contractNumber: 'MoA-2026/OCC-941',
                                  aktaNumber: 'CTR/WH-2026/IX/8941',
                                  effectiveDate: '30 September 2026',
                                  commodityName:
                                      'Kardus Bekas (OCC) Sortir Bal Super',
                                  commodityGrade: 'Grade A\nIndustri',
                                  sellerName: widget.partnerName,
                                  totalQuantity: _currentQuantity,
                                  unitPrice: _currentPrice,
                                  totalValue: _currentPrice * _currentQuantity,
                                ),
                              ),
                            );
                          },
                          child: const Text('Kirim Penawaran'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A4D3C),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.send_rounded, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Ajukan Counter Offer',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'Batal & Kembali ke Percakapan',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
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
