# 🎬 Ditonton - Flutter Expert Project

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)

Aplikasi Ditonton adalah aplikasi streaming film dan serial TV yang dibangun menggunakan Flutter dengan arsitektur modular dan clean architecture. Proyek ini merupakan submission untuk kelas Flutter Expert Dicoding Indonesia.

## 📋 Daftar Isi

- [Fitur](#-fitur)
- [Arsitektur](#-arsitektur)
- [Teknologi](#-teknologi)
- [Struktur Project](#-struktur-project)
- [Instalasi](#-instalasi)
- [Menjalankan Aplikasi](#-menjalankan-aplikasi)
- [Testing](#-testing)
- [Firebase Integration](#-firebase-integration)
- [CI/CD](#-cicd)

## ✨ Fitur

### Movies
- 🎥 Daftar film populer dan top rated
- 🔍 Pencarian film
- 📄 Detail film dengan informasi lengkap
- ⭐ Rating dan review
- 💾 Watchlist film
- 🎬 Rekomendasi film serupa

### TV Series
- 📺 Daftar serial TV populer dan top rated
- 🔎 Pencarian serial TV
- 📝 Detail serial TV dengan episode
- ⭐ Rating serial TV
- 💾 Watchlist serial TV
- 📺 Rekomendasi serial TV serupa

### Fitur Lainnya
- 🌐 Cache gambar otomatis
- 💾 Database lokal untuk watchlist
- 🔥 Firebase Analytics & Crashlytics
- 🎨 UI/UX yang responsif dan menarik
- ⚡ State management dengan BLoC/Cubit

## 🏗️ Arsitektur

Aplikasi ini menggunakan **Clean Architecture** dengan **Modular Architecture Pattern**:

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│    (UI, BLoC/Cubit, Pages)         │
└─────────────┬───────────────────────┘
              │
┌─────────────▼───────────────────────┐
│          Domain Layer               │
│   (Entities, UseCases, Repository)  │
└─────────────┬───────────────────────┘
              │
┌─────────────▼───────────────────────┐
│           Data Layer                │
│  (Models, Data Sources, Repository  │
│         Implementation)             │
└─────────────────────────────────────┘
```

### Modul-modul:

- **Core**: Modul inti yang berisi komponen umum (styles, utils, TV series)
- **Movie**: Modul khusus untuk fitur film
- **About**: Modul halaman about

## 🛠️ Teknologi

### Framework & Language
- Flutter SDK: >= 2.12.0
- Dart: >= 3.10.0

### State Management
- `flutter_bloc` & `bloc` - State management dengan BLoC pattern
- `provider` - Dependency injection

### Networking & Data
- `http` - REST API client
- `sqflite` - Local database
- `cached_network_image` - Image caching
- `dartz` - Functional programming

### Firebase
- `firebase_core` - Firebase initialization
- `firebase_analytics` - Analytics tracking
- `firebase_crashlytics` - Crash reporting

### UI/UX
- `google_fonts` - Custom fonts
- `flutter_rating_bar` - Rating display
- `smooth_page_indicator` - Page indicators

### Testing & Development
- `mockito` - Mocking untuk testing
- `bloc_test` - BLoC testing
- `build_runner` - Code generation
- `json_serializable` - JSON serialization

### Others
- `get_it` - Service locator
- `equatable` - Value equality
- `logger` - Logging utility
- `path_provider` - File system paths

## 📁 Struktur Project

```
ditonton/
├── lib/
│   ├── main.dart                 # Entry point aplikasi
│   ├── injection.dart            # Dependency injection setup
│   └── firebase_options.dart     # Firebase configuration
├── core/                         # Core module
│   ├── lib/
│   │   ├── data/                # Data layer (repositories, datasources)
│   │   ├── domain/              # Domain layer (entities, usecases)
│   │   ├── presentation/        # Presentation layer (pages, bloc/cubit)
│   │   ├── style/               # App styling (colors, textstyle)
│   │   └── utils/               # Utilities
│   └── test/                    # Unit & widget tests
├── movie/                       # Movie module
│   ├── lib/
│   │   ├── data/               # Movie data layer
│   │   ├── domain/             # Movie domain layer
│   │   └── presentation/       # Movie UI & BLoC
│   └── test/                   # Movie tests
├── about/                      # About module
│   ├── lib/
│   │   └── about_page.dart
│   └── test/
├── android/                    # Android native code
├── ios/                        # iOS native code
├── test/                       # Integration tests
└── coverage/                   # Test coverage reports
```

## 🚀 Instalasi

### Prerequisites

- Flutter SDK (>= 2.12.0)
- Dart SDK (>= 3.10.0)
- Android Studio / Xcode (untuk development Android/iOS)
- Git

### Langkah-langkah:

1. **Clone repository**
   ```bash
   git clone https://github.com/yourusername/ditonton.git
   cd ditonton
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Install dependencies untuk setiap module**
   ```bash
   cd core && flutter pub get
   cd ../movie && flutter pub get
   cd ../about && flutter pub get
   cd ..
   ```

4. **Setup Firebase** (Optional)
   - Buat project di [Firebase Console](https://console.firebase.google.com/)
   - Download `google-services.json` untuk Android
   - Download `GoogleService-Info.plist` untuk iOS
   - Jalankan `flutterfire configure` untuk setup otomatis

5. **Generate code** (jika diperlukan)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

## 🎮 Menjalankan Aplikasi

### Development Mode

```bash
flutter run
```

### Build untuk Production

**Android (APK)**
```bash
flutter build apk --release
```

**Android (App Bundle)**
```bash
flutter build appbundle --release
```

**iOS**
```bash
flutter build ios --release
```

## 🧪 Testing

### Menjalankan Unit Tests

```bash
flutter test
```

### Menjalankan Tests dengan Coverage

**Untuk seluruh project:**
```bash
flutter test --coverage
```

**Untuk module tertentu:**
```bash
cd core && flutter test --coverage
cd ../movie && flutter test --coverage
```

### Generate Coverage Report

Gunakan script `test.sh` yang disediakan untuk generate laporan coverage lengkap:

#### Setup LCOV (satu kali saja)

**Linux:**
```bash
sudo apt-get update -qq -y
sudo apt-get install lcov -y
```

**Mac:**
```bash
brew install lcov
```

**Windows:**
1. Install [Chocolatey](https://chocolatey.org/install)
2. Install lcov:
   ```powershell
   choco install lcov
   ```
3. Tambahkan environment variables:
   | Variable | Value |
   |----------|-------|
   | GENTHTML | C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml |
   | LCOV_HOME | C:\ProgramData\chocolatey\lib\lcov\tools |

#### Menjalankan Test Script

```bash
# Initialize git jika belum
git init

# Jalankan test script
./test.sh
```

Script akan menggenerate:
- `lcov.info` - File coverage data
- `coverage/` - Folder berisi HTML report

### View Coverage Report

Buka file `coverage/index.html` di browser untuk melihat laporan coverage detail.

## 🔥 Firebase Integration

Aplikasi ini mengintegrasikan Firebase untuk:

### Analytics
- Tracking user behavior
- Event tracking
- Screen tracking

### Crashlytics
- Automatic crash reporting
- Fatal error logging
- Custom error logging

### Setup Firebase

1. Pastikan file konfigurasi Firebase sudah ada:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

2. Firebase sudah diinisialisasi di `main.dart`:
   ```dart
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   ```

3. Crashlytics sudah dikonfigurasi untuk menangkap fatal errors secara otomatis.

## 🔄 CI/CD

Project ini menggunakan **Codemagic** untuk CI/CD. Konfigurasi ada di `codemagic.yaml`.

### Workflow includes:
- ✅ Automated testing
- 📦 Build untuk Android & iOS
- 📊 Coverage report generation
- 🚀 Deployment automation

## 📝 Code Style

Project ini mengikuti:
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Flutter best practices
- Clean Architecture principles

Gunakan `flutter analyze` untuk check code issues:
```bash
flutter analyze
```

## 🤝 Contributing

1. Fork repository
2. Buat branch fitur (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

## 📄 License

Project ini dibuat untuk keperluan submission Flutter Expert Dicoding Indonesia.

## 👨‍💻 Author

Dikembangkan sebagai submission Flutter Expert - Dicoding Indonesia

## 🙏 Acknowledgments

- [Dicoding Indonesia](https://www.dicoding.com/) - Flutter Expert Class
- [The Movie Database (TMDB)](https://www.themoviedb.org/) - API Provider
- Flutter Community

---

**Happy Coding! 🚀**
4. Tunggu proses testing selesai hingga muncul web terkait laporan coverage.

