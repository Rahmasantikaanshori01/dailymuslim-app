# 🕌 DailyMuslim

**DailyMuslim** adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu umat Islam menjalankan aktivitas ibadah sehari-hari dengan lebih mudah melalui satu aplikasi. Aplikasi ini menyediakan berbagai fitur Islami, mulai dari Al-Qur'an, doa harian, jadwal salat, tasbih digital, hingga fitur AI Chat.

Aplikasi ini dikembangkan menggunakan bahasa pemrograman Dart dengan framework Flutter. Pengelolaan kode menerapkan arsitektur MVVM dan Repository Pattern agar struktur aplikasi lebih terorganisasi serta mudah dikembangkan.

---

## ✨ Fitur Aplikasi

### 📖 1. Al-Qur'an
- Menampilkan daftar surah dalam Al-Qur'an.
- Menampilkan detail surah dan ayat.
- Membaca ayat Al-Qur'an melalui antarmuka aplikasi.
- Mempermudah pengguna menemukan surah yang ingin dibaca.

### 🤲 2. Doa Harian
- Menyediakan kumpulan doa untuk aktivitas sehari-hari.
- Membantu pengguna menemukan doa sesuai kebutuhan.
- Menampilkan informasi doa melalui antarmuka yang mudah digunakan.

### 🕌 3. Jadwal Salat
- Menampilkan jadwal salat berdasarkan kota.
- Mengambil informasi jadwal salat dari MyQuran API.
- Membantu pengguna mengetahui waktu salat harian.

### 📿 4. Tasbih Digital
- Membantu pengguna menghitung zikir secara digital.
- Mempermudah pencatatan jumlah hitungan zikir.

### 🤖 5. AI Chat
- Mengintegrasikan Google Gemini API untuk mendukung fitur percakapan berbasis AI.
- Memungkinkan pengguna mengajukan pertanyaan melalui antarmuka chat.
- Membantu pengguna memperoleh informasi melalui interaksi dengan AI.

**Catatan:** Jawaban AI mengenai agama perlu diperiksa kembali melalui sumber Islam yang tepercaya. AI dapat memberikan informasi yang kurang tepat.

### 🎨 6. Pilihan Tema
Aplikasi menyediakan beberapa variasi tema untuk menyesuaikan tampilan, antara lain:
- Default
- Light
- Dark
- Hijau
- Ungu
- Kuning
- Pink

Ketersediaan dan penerapan setiap tema mengikuti implementasi kode aplikasi.

---

## 💻 Bahasa Pemrograman

| Bahasa / Teknologi | Kegunaan |
|---|---|
| Dart | Bahasa pemrograman utama untuk membangun logika aplikasi. |
| Flutter | Framework untuk membangun antarmuka dan aplikasi mobile. |

---

## 🛠️ Tools dan Teknologi yang Digunakan

| Tools / Teknologi | Kegunaan |
|---|---|
| Visual Studio Code | Editor untuk menulis dan mengelola kode aplikasi. |
| Flutter SDK | Menyediakan tools untuk membangun dan menjalankan aplikasi Flutter. |
| Dart SDK | Menyediakan lingkungan pengembangan bahasa Dart. |
| Git | Mengelola versi kode dan mencatat perubahan proyek. |
| GitHub | Menyimpan repositori kode sumber secara online. |
| Provider | Mengelola state dan menyediakan data antarbagian aplikasi. |
| Google Fonts | Menggunakan berbagai jenis font pada antarmuka aplikasi. |
| ScreenUtil | Membantu menyesuaikan ukuran elemen antarmuka dengan ukuran layar. |
| HTTP | Mengirim permintaan HTTP untuk berkomunikasi dengan API. |
| Image Picker | Memungkinkan aplikasi memilih gambar dari perangkat. |
| Table Calendar | Menyediakan komponen kalender dalam aplikasi. |
| Intl | Membantu pemformatan tanggal, waktu, dan lokalisasi. |
| URL Launcher | Membuka URL atau tautan dari aplikasi. |
| Zoom Tap Animation | Memberikan efek animasi ketika elemen antarmuka ditekan. |

Package Flutter dikelola melalui file `pubspec.yaml`.

---

## 🌐 API dan Layanan Eksternal

DailyMuslim menggunakan layanan API untuk mengambil data dan mendukung fitur tertentu.

### 1. MyQuran API

**Kegunaan:** Mengambil data jadwal salat berdasarkan kota, tahun, dan bulan.

Contoh endpoint:

```text
https://api.myquran.com/v2/sholat/jadwal/{id_kota}/{tahun}/{bulan}
```

Keterangan:
- `id_kota`: ID kota yang digunakan untuk mencari jadwal salat.
- `tahun`: Tahun jadwal salat.
- `bulan`: Bulan jadwal salat.

API ini membantu aplikasi memperoleh informasi jadwal salat tanpa harus menyimpan seluruh data jadwal secara manual di dalam aplikasi.

### 2. Google Gemini API

**Kegunaan:** Mendukung fitur AI Chat untuk memproses pertanyaan pengguna dan menghasilkan jawaban melalui model AI Gemini.

Dokumentasi resmi:

https://ai.google.dev/

API key harus dijaga kerahasiaannya. Jangan menyimpan API key rahasia secara langsung di kode yang akan dipublikasikan ke repositori GitHub. Untuk aplikasi produksi, pertimbangkan penggunaan backend sebagai perantara permintaan ke Gemini API.

---

## 📦 Package Flutter

Berikut package yang digunakan atau tercatat dalam konfigurasi proyek:

| Package | Kegunaan |
|---|---|
| `provider` | Pengelolaan state aplikasi. |
| `flutter_screenutil` | Penyesuaian ukuran elemen UI. |
| `google_fonts` | Penggunaan font dari Google Fonts. |
| `http` | Komunikasi HTTP dengan API. |
| `image_picker` | Pemilihan gambar dari perangkat. |
| `intl` | Pemformatan tanggal dan waktu. |
| `table_calendar` | Komponen kalender. |
| `url_launcher` | Membuka tautan eksternal. |
| `zoom_tap_animation` | Animasi interaksi saat elemen ditekan. |

Package tambahan dan versi yang digunakan dapat dilihat pada file `pubspec.yaml`.

---

## 🏗️ Arsitektur Aplikasi

DailyMuslim menggunakan pendekatan **MVVM (Model-View-ViewModel)** yang didukung oleh **Repository Pattern**.

### 1. Model
Bagian yang merepresentasikan struktur data yang digunakan aplikasi.

### 2. View
Bagian yang menampilkan antarmuka kepada pengguna, seperti halaman Al-Qur'an, doa, jadwal salat, dan chat.

### 3. ViewModel
Bagian yang mengelola state dan logika yang dibutuhkan oleh View. ViewModel membantu menghubungkan tampilan dengan sumber data.

### 4. Repository
Bagian yang mengatur akses dan pengambilan data agar ViewModel tidak perlu menangani seluruh proses komunikasi dengan sumber data secara langsung.

### 5. Services
Bagian yang menangani komunikasi dengan layanan eksternal, seperti Google Gemini API.

### Alur Kerja Aplikasi

Secara umum, alur pengambilan data dapat digambarkan sebagai berikut:

```text
User
  |
  v
View (UI)
  |
  v
ViewModel
  |
  v
Repository / Service
  |
  v
API atau Sumber Data
  |
  v
Repository / Service
  |
  v
ViewModel
  |
  v
View (UI)
```

Pemisahan tanggung jawab ini membantu membuat kode lebih terstruktur, memudahkan pemeliharaan, dan mendukung pengembangan fitur baru.

---

## 📁 Struktur Proyek

Gambaran umum struktur direktori aplikasi Flutter:

```text
dailymuslim/
├── android/
├── ios/
├── assets/
│   └── fonts/
├── lib/
│   ├── main.dart
│   ├── model/
│   ├── repository/
│   ├── service/
│   ├── view/
│   │   ├── page/
│   │   ├── widget/
│   │   └── theme/
│   └── viewmodel/
├── test/
├── pubspec.yaml
└── README.md
```

**Catatan:** Struktur di atas merupakan gambaran umum. Nama folder dan file dapat berbeda mengikuti struktur aktual proyek.

---

## 🚀 Cara Menjalankan Aplikasi

### 1. Persyaratan

Pastikan perangkat pengembangan telah memiliki:
- Flutter SDK.
- Dart SDK yang sesuai dengan versi Flutter.
- Visual Studio Code atau editor lainnya.
- Emulator Android atau perangkat Android fisik.
- Koneksi internet untuk mengakses API yang digunakan aplikasi.

### 2. Clone Repository

Jika proyek sudah tersedia di GitHub, jalankan:

```bash
git clone <URL_REPOSITORY>
```

Masuk ke direktori proyek:

```bash
cd dailymuslim
```

Ganti `<URL_REPOSITORY>` dengan URL repositori GitHub milik proyek.

### 3. Instalasi Dependencies

Jalankan perintah berikut di terminal pada direktori utama proyek:

```bash
flutter pub get
```

Perintah ini digunakan untuk mengunduh package yang dibutuhkan berdasarkan konfigurasi `pubspec.yaml`.

### 4. Periksa Instalasi Flutter

```bash
flutter doctor
```

Perintah ini membantu memeriksa apakah lingkungan pengembangan Flutter sudah dikonfigurasi dengan benar.

### 5. Periksa Perangkat

```bash
flutter devices
```

Pastikan emulator atau perangkat Android terdeteksi.

### 6. Jalankan Aplikasi

```bash
flutter run
```

Flutter akan membangun dan menjalankan aplikasi pada perangkat yang dipilih.

---

## 🧪 Pemeriksaan Proyek

Untuk memeriksa kemungkinan masalah pada kode:

```bash
flutter analyze
```

Untuk menjalankan pengujian yang tersedia:

```bash
flutter test
```

Hasil pengujian bergantung pada test yang sudah dibuat di dalam proyek.

---

## 🔐 Keamanan API

Beberapa fitur menggunakan layanan eksternal yang memerlukan akses API.

Hal-hal yang perlu diperhatikan:
- Jangan mengunggah API key rahasia ke repositori publik.
- Jangan memasukkan API key ke dalam README.
- Gunakan konfigurasi lokal untuk kebutuhan pengembangan.
- Untuk aplikasi produksi, pertimbangkan penggunaan backend untuk melindungi kredensial API.
- Jika API key pernah terunggah ke repositori publik, segera cabut atau rotasi key tersebut melalui layanan penyedianya.

---

## 🎯 Tujuan Pengembangan

DailyMuslim dikembangkan untuk menyediakan akses yang lebih praktis terhadap berbagai kebutuhan ibadah dan informasi Islami melalui perangkat mobile.

Melalui penggunaan Flutter, aplikasi dapat dikembangkan dengan satu basis kode untuk mendukung berbagai platform. Sementara itu, penerapan MVVM dan Repository Pattern membantu menjaga struktur kode agar lebih terorganisasi dan mudah dikembangkan.

---

## 👩‍💻 Pengembang

**DailyMuslim — Aplikasi Islami Berbasis Flutter**

Dikembangkan sebagai proyek aplikasi mobile dengan menggunakan Dart, Flutter, integrasi API, dan arsitektur MVVM.

---

## 📄 Lisensi

Lisensi proyek dapat ditambahkan sesuai ketentuan yang ditetapkan oleh pengembang.
