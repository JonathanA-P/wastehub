import 'dart:async';
import 'package:flutter/material.dart';
import '../../transaction/screens/contract_signing_screen.dart';
import 'counter_offer_screen.dart';

class ChatMessage {
  final String id;
  final String text;
  final bool isMe;
  final String time;
  final bool hasAttachment;
  final String? attachmentName;
  final String? attachmentSize;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isMe,
    required this.time,
    this.hasAttachment = false,
    this.attachmentName,
    this.attachmentSize,
  });
}

class NegotiationChatScreen extends StatefulWidget {
  final String partnerName;
  final String materialName;
  final String commodityGrade;
  final String deliveryTerm;
  final int initialPrice;
  final int totalQuantity;

  const NegotiationChatScreen({
    super.key,
    this.partnerName = 'PT Daur Alam Lestari',
    this.materialName = 'PET Flakes Hot-Washed',
    this.commodityGrade = '(Grade A)',
    this.deliveryTerm = 'Franco Gudang',
    this.initialPrice = 11500,
    this.totalQuantity = 8000,
  });

  @override
  State<NegotiationChatScreen> createState() => _NegotiationChatScreenState();
}

class _NegotiationChatScreenState extends State<NegotiationChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Live timer: 04:22:15
  int _remainingSeconds = 4 * 3600 + 22 * 60 + 15;
  Timer? _timer;

  late List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _messages = [
      ChatMessage(
        id: 'msg-1',
        text:
            'Selamat pagi rekan Industri. Kami konfirmasi ketersediaan stok **PET Flakes Bening Hot-Washed** sebanyak 8 Ton siap kirim dari fasilitas daur ulang Cikande.',
        isMe: false,
        time: '09:40 WIB',
      ),
      ChatMessage(
        id: 'msg-2',
        text:
            'Pagi PT Daur Alam. Kebutuhan kami mutlak kadar PVC < 50 ppm dan kelembapan maks 1.0%. Apakah sudah dilakukan sampling lab batch ini?',
        isMe: true,
        time: '09:42 WIB',
      ),
      ChatMessage(
        id: 'msg-3',
        text:
            'Sudah dilakukan uji lab internal dan Sucofindo. Hasilnya PVC 32 ppm, moisture 0.78%. Dokumen sertifikat COA kami lampirkan bersama draft LOI terikat ini.',
        isMe: false,
        time: '09:44 WIB',
        hasAttachment: true,
        attachmentName: 'COA_PET_Flakes_Lot882.pdf',
        attachmentSize: '1.8 MB • Terverifikasi Digital',
      ),
      // Message 4 will be rendered as the Embedded Offer Card in the list
      ChatMessage(
        id: 'msg-4',
        text:
            'Harga Rp 11.500/kg Franco Tangerang kami sepakati asalkan jadwal tiba tidak lewat dari pukul 11:00 WIB agar langsung masuk hopper produksi shift siang.',
        isMe: true,
        time: '09:47 WIB',
      ),
      ChatMessage(
        id: 'msg-5',
        text:
            "Disetujui. Driver kami jadwalkan keluar pool Cikande pukul 06:00 WIB. Silakan tekan tombol 'Sepakati Harga' untuk mengunci alokasi batch dan penerbitan kontrak PO elektronik.",
        isMe: false,
        time: '09:48 WIB',
      ),
    ];
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
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final txt = _textController.text.trim();
    if (txt.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
          text: txt,
          isMe: true,
          time: '09:50 WIB',
        ),
      );
      _textController.clear();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          // Sub-header: Komoditas & Delivery Term
          _buildSubHeader(),

          // Chat Messages Stream
          Expanded(
            child: ListView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              children: [
                _buildMessageBubble(_messages[0]),
                const SizedBox(height: 12),
                _buildMessageBubble(_messages[1]),
                const SizedBox(height: 12),
                _buildMessageBubble(_messages[2]),
                const SizedBox(height: 14),

                // Embedded Negotiation Offer Card
                _buildEmbeddedOfferCard(context),
                const SizedBox(height: 14),

                _buildMessageBubble(_messages[3]),
                const SizedBox(height: 12),
                _buildMessageBubble(_messages[4]),
                if (_messages.length > 5) ...[
                  for (int i = 5; i < _messages.length; i++) ...[
                    const SizedBox(height: 12),
                    _buildMessageBubble(_messages[i]),
                  ],
                ],
              ],
            ),
          ),

          // Bottom Action Bar & Input
          _buildBottomArea(context),
        ],
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
        icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A)),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          // Avatar DA with Online indicator
          Stack(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFDCFCE7),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'DA',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF166534),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: const Color(0xFF16A34A),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),

          // Partner Name & Verified Badge
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.partnerName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified,
                      size: 13,
                      color: Color(0xFF0A4D3C),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                Row(
                  children: const [
                    Text(
                      'Verified NIB',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF16A34A),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '• Online',
                      style: TextStyle(
                        fontSize: 9.5,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Timer Pill (04:22:15)
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.access_time_rounded,
                size: 11,
                color: Color(0xFFB45309),
              ),
              const SizedBox(width: 4),
              Text(
                _formatTimer(_remainingSeconds),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFB45309),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
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
  // SUB HEADER: Komoditas & Delivery Term
  // ---------------------------------------------------------
  Widget _buildSubHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.swap_horiz_rounded,
            size: 15,
            color: Color(0xFF64748B),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                ),
                children: [
                  const TextSpan(text: 'Komoditas: '),
                  TextSpan(
                    text: widget.materialName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  TextSpan(text: ' ${widget.commodityGrade}'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              widget.deliveryTerm,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Color(0xFF15803D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // RICH TEXT MARKDOWN PARSER (**bold**)
  // ---------------------------------------------------------
  Widget _buildRichText(String text,
      {required Color defaultColor, required bool isMe}) {
    final spans = <TextSpan>[];
    final parts = text.split('**');
    for (int i = 0; i < parts.length; i++) {
      if (parts[i].isEmpty) continue;
      final isBold = i % 2 == 1;
      spans.add(
        TextSpan(
          text: parts[i],
          style: TextStyle(
            fontSize: 11.5,
            color: defaultColor,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
            height: 1.45,
          ),
        ),
      );
    }
    return Text.rich(
      TextSpan(children: spans),
    );
  }

  // ---------------------------------------------------------
  // CHAT MESSAGE BUBBLE
  // ---------------------------------------------------------
  Widget _buildMessageBubble(ChatMessage msg) {
    if (msg.isMe) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.78,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: const BoxDecoration(
              color: Color(0xFF0A4D3C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: _buildRichText(
              msg.text,
              defaultColor: Colors.white,
              isMe: true,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                msg.time,
                style: const TextStyle(
                  fontSize: 9.5,
                  color: Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.done_all_rounded,
                size: 13,
                color: Color(0xFF0F766E),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.78,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
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
                _buildRichText(
                  msg.text,
                  defaultColor: const Color(0xFF1E293B),
                  isMe: false,
                ),
                if (msg.hasAttachment) ...[
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Mengunduh lampiran ${msg.attachmentName}...'),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEE2E2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.picture_as_pdf_rounded,
                              size: 16,
                              color: Color(0xFFDC2626),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  msg.attachmentName ?? 'Document.pdf',
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
                                  msg.attachmentSize ?? 'PDF',
                                  style: const TextStyle(
                                    fontSize: 9.5,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.download_rounded,
                            size: 16,
                            color: Color(0xFF64748B),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 3),
          Text(
            msg.time,
            style: const TextStyle(
              fontSize: 9.5,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      );
    }
  }

  // ---------------------------------------------------------
  // EMBEDDED OFFER CARD (Rincian Penawaran)
  // ---------------------------------------------------------
  Widget _buildEmbeddedOfferCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFCBD5E1)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dark Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF0A4D3C),
              borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.verified_user_outlined,
                        size: 13, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'RINCIAN PENAWARAN',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD97706),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.access_time_rounded,
                          size: 10, color: Colors.white),
                      SizedBox(width: 3),
                      Text(
                        'KADALUWARSA 02:45:00',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Tonnage
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.materialName} ${widget.commodityGrade}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Spesifikasi: PVC < 50 ppm • Moisture ≤ 1.0%',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '8.000 kg (8 Ton)',
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 2 Metric Columns
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'HARGA SATUAN',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Rp 11.500 /kg',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0A4D3C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'TOTAL NILAI KONTRAK',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Rp 92.000.000',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Delivery Sub-box
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.local_shipping_outlined,
                          size: 15,
                          color: Color(0xFF166534),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Franco Gudang Pembeli (Tangerang)',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              'Pengiriman armada Fuso: Senin, 08:30 WIB • Ongkir ditan...',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 9.5,
                                color: Color(0xFF64748B),
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
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // BOTTOM AREA: DUAL ACTION BUTTONS + INPUT BAR
  // ---------------------------------------------------------
  Widget _buildBottomArea(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dual Sticky Action Buttons: Ajukan Counter Offer & Sepakati Harga
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CounterOfferScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.assignment_outlined,
                            size: 16, color: Color(0xFFD97706)),
                        label: const Text(
                          'Ajukan Counter Offer',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFF8FAFC),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Text('Sepakati Harga & Terbitkan Kontrak'),
                              content: const Text(
                                'Anda menyetujui transaksi PET Flakes Hot-Washed senilai Rp 92.000.000 (Franco Gudang). Lanjutkan ke Surat Jalan Digital & SPK resmi?',
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const ContractSigningScreen(
                                          contractNumber: 'MoA-2026/PET-882',
                                          aktaNumber: 'CTR/WH-2026/X/8820',
                                          effectiveDate: '05 Oktober 2026',
                                          commodityName:
                                              'PET Flakes Bening (Hot Washed Grade A)',
                                          commodityGrade: 'Grade A\nIndustri',
                                          sellerName: 'PT Daur Alam Lestari',
                                          sellerNib: '9120003418902',
                                          totalQuantity: 8000,
                                          moistureSpec: 'Maks. 1.0%',
                                          unitPrice: 11500,
                                          totalValue: 92000000,
                                          totalValueSpelled:
                                              'Sembilan Puluh Dua Juta Rupiah',
                                          sellerSignRef: 'E-SIGN-051026-DAL',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Ya, Sepakati'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.handshake_outlined,
                            size: 15, color: Colors.white),
                        label: const Text(
                          'Sepakati Harga',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A4D3C),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Chat Input Bar
              Row(
                children: [
                  // Lab Flask Icon
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Lampirkan parameter spek lab COA'),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.science_outlined,
                        size: 18,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Paperclip Attachment Icon
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pilih file dokumen / foto timbangan'),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.attach_file_rounded,
                        size: 18,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Text Input with template icon
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: TextField(
                        controller: _textController,
                        style: const TextStyle(fontSize: 12.5),
                        decoration: InputDecoration(
                          hintText: 'Ketik pesan atau syarat t...',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.receipt_long_outlined,
                              size: 18,
                              color: Color(0xFF94A3B8),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Pilih template syarat transaksi & klausul'),
                                  duration: Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Send Button
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0A4D3C),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.send_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
