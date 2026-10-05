# WasteHub ♻️

> **Platform Bursa Pertukaran Komoditas Daur Ulang & Manajemen Rantai Pasok Sirkular B2B (Business-to-Business)**

WasteHub adalah aplikasi mobile berbasis **Flutter** yang dirancang untuk mendigitalkan seluruh siklus perdagangan material daur ulang industri di Indonesia — mulai dari bursa harga spot komoditas, penerbitan LOI (*Letter of Intent*), ruang negosiasi harga dinamis, penandatanganan kontrak digital (*e-MoA*), pelacakan armada logistik dengan jembatan timbang terintegrasi, hingga penerbitan BAST elektronik dan pencairan dana rekening bersama (*Escrow*).

Aplikasi ini dibangun menggunakan arsitektur **Feature-First Modular** dengan standar desain **Utilitarian Minimalism** yang bersih, fungsional, dan bebas dari *visual clutter*.

---

## 🌟 Fitur Utama & Modul Sistem

### 1. Bursa Pasar Komoditas Daur Ulang (`features/catalog`)
- **Katalog Material Industri**: Agregasi komoditas daur ulang terstandarisasi (Plastik PET Hot-Washed, Kardus Bekas OCC Bal, Scrap Aluminium UBC, Polyethylene).
- **Indeks Permintaan Pasar**: Metrik langsung volume tonase aktif dan valuasi transaksi berjalan.
- **Pencarian & Filter Cepat**: Filter multi-kategori dan pencarian berbasis parameter spesifikasi teknis.

### 2. Mesin Negosiasi & LOI Resmi (`features/negotiation`)
- **Formulir LOI Otomatis**: Generator draf penawaran formal dengan kalkulasi volume dinamis dan validasi selisih acuan pasar.
- **Counter Offer Engine**: Fitur penyesuaian harga interaktif dengan *instant calculation chips* dan komparasi persentase penghematan.
- **Ruang Percakapan Negosiasi**: *Chat room* terenkripsi untuk kesepakatan komersial antara agregator, bank sampah, dan offtaker manufaktur.

### 3. Kontrak Digital & e-Sign (`features/transaction`)
- **Legalitas MoA Elektronik**: Draf klausul perjanjian komprehensif (volume, toleransi kadar air/impuritas, termin pembayaran, asuransi B2B).
- **Workflow e-Signature**: Verifikasi tanda tangan digital resmi tersertifikasi PrivyID / Peruri dengan otentikasi OTP.

### 4. Pelacakan Logistik & Sensor Timbangan (`features/monitoring`)
- **Live Route & GPS Tracker**: Visualisasi rute armada pengiriman bahan baku dari depo asal ke gerbang pabrik.
- **Jembatan Timbang Elektronik**: Rekonsiliasi digital pengukuran Bruto, Tarra, dan Netto yang tersertifikasi Metrologi Legal.
- **Kamera ANPR & Gerbang Otomatis**: Sensor verifikasi pelat nomor dan RFID untuk keamanan muatan.

### 5. BAST Digital & Pencairan Escrow (`features/transaction`)
- **Berita Acara Serah Terima (BAST)**: Dokumen serah terima sah berkekuatan hukum dengan kode verifikasi unik.
- **Hasil Uji Mutu Sucofindo**: Rekapitulasi inspeksi laboratorium independen untuk kadar kemurnian material.
- **Pelepasan Dana Escrow**: Pembagian pencairan otomatis rekening penampung setelah kedua belah pihak menandatangani BAST.

### 6. Dasbor Bisnis & Profil Legalitas (`features/business` & `features/profile`)
- **Saldo Escrow Operasional**: Monitoring saldo rekening penampung terproteksi perbankan (Virtual Account terintegrasi).
- **Utilisasi Fasilitas Gudang**: Pelacakan kapasitas tampung depo dan jadwal kedatangan armada incoming.
- **Kredensial Legalitas OSS RBA**: Manajemen NIB resmi, izin KLHK RI, dan sertifikasi ISO 14001:2015.
- **Pusat Notifikasi Real-time**: Pemberitahuan status pengiriman armada, pembaruan tawaran, dan pencairan dana.

---

## 🏛️ Arsitektur Proyek

Struktur folder mengadopsi pola **Feature-Driven Architecture** untuk skalabilitas dan kemudahan pengujian:

```
lib/
├── main.dart                                # Titik masuk aplikasi (WasteHubApp)
├── core/                                    # Komponen inti global
│   ├── constants/
│   │   └── app_colors.dart                  # Sistem palet warna utilitarian minimalis
│   ├── theme/
│   │   └── app_theme.dart                   # Konfigurasi Material 3 & Typography
│   ├── utils/
│   │   └── currency_formatter.dart          # Formatter mata uang Rupiah
│   └── widgets/
│       └── wastehub_bottom_nav.dart         # Navigasi tab bawah persisten
└── features/                                # Modul fungsional per domain
    ├── catalog/                             # Modul Pasar Komoditas
    │   ├── models/commodity_item.dart
    │   ├── screens/catalog_screen.dart
    │   └── widgets/
    ├── negotiation/                         # Modul Negosiasi & LOI
    │   ├── screens/new_negotiation_screen.dart
    │   ├── screens/counter_offer_screen.dart
    │   ├── screens/negotiation_chat_screen.dart
    │   ├── screens/negotiation_inbox_screen.dart
    │   └── widgets/nego_bottom_sheet.dart
    ├── transaction/                         # Modul Kontrak & BAST
    │   ├── screens/transaction_list_screen.dart
    │   ├── screens/contract_signing_screen.dart
    │   ├── screens/bast_digital_screen.dart
    │   └── screens/transaction_success_screen.dart
    ├── monitoring/                          # Modul Tracking & Jembatan Timbang
    │   ├── screens/logistics_tracking_screen.dart
    │   └── widgets/market_summary_card.dart
    ├── business/                            # Modul Dasbor Fasilitas Bisnis
    │   └── screens/business_dashboard_screen.dart
    ├── notifications/                       # Modul Notifikasi
    │   └── screens/notification_center_screen.dart
    └── profile/                             # Modul Legalitas & Profil Perusahaan
        └── screens/user_profile_screen.dart
```

---

## 🚀 Memulai (Getting Started)

### Prasyarat
- **Flutter SDK**: `>= 3.13.0`
- **Dart SDK**: `>= 3.1.0`
- Android Studio / VS Code / IntelliJ dengan plugin Flutter

### Instalasi & Menjalankan Aplikasi
1. **Clone repositori**:
   ```bash
   git clone https://github.com/JonathanA-P/wastehub.git
   cd wastehub
   ```

2. **Unduh dependensi**:
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**:
   ```bash
   flutter run
   ```

---

## 🧪 Pengujian & Verifikasi Kualitas

Seluruh fungsionalitas dan alur interaksi antarmuka telah diverifikasi dengan suite pengujian otomatis:

```bash
# Menjalankan static analysis (0 warning / error)
flutter analyze

# Menjalankan seluruh test suite (13/13 passed)
flutter test
```

### Rincian Test Suites:
| Test File | Cakupan Pengujian | Status |
|---|---|:---:|
| `widget_test.dart` | Smoke test katalog & navigasi bawah | ✅ Pass |
| `transaction_list_test.dart` | KPI tonase, filter chip, kartu transaksi & pencarian | ✅ Pass |
| `negotiation_inbox_test.dart` | Inbox negosiasi, badge status, & filter respons | ✅ Pass |
| `new_negotiation_test.dart` | Formulir LOI, kalkulasi volume dinamis & dialog konfirmasi | ✅ Pass |
| `counter_offer_test.dart` | Kalkulasi counter offer, quick chip 2.000, & submit modal | ✅ Pass |
| `negotiation_chat_test.dart` | Gelembung pesan chat, tawaran tertanam & aksi terima | ✅ Pass |
| `contract_signing_test.dart` | Klausul MoA, verifikasi checkbox, & alur e-Sign OTP | ✅ Pass |
| `transaction_success_test.dart` | Tampilan e-DO, QR code manifest, & trigger unduh | ✅ Pass |
| `logistics_tracking_test.dart` | Rute GPS, status armada, & jembatan timbang digital | ✅ Pass |
| `bast_digital_test.dart` | Dokumen resmi BAST, QC Sucofindo, & escrow settlement | ✅ Pass |
| `business_dashboard_test.dart` | Profil perusahaan, saldo escrow, & kapasitas gudang | ✅ Pass |
| `notification_center_test.dart` | Filter kategori notifikasi & aksi tandai dibaca | ✅ Pass |
| `user_profile_test.dart` | Kredensial NIB, sertifikasi ISO/KLHK, & tanda tangan digital | ✅ Pass |

---

## 📄 Lisensi
Hak Cipta © 2026 WasteHub Indonesia. Dikembangkan untuk efisiensi rantai pasok ekonomi sirkular industri.
