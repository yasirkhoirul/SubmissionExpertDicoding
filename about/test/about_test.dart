import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// Sesuaikan import ini dengan lokasi file AboutPage Anda
import 'package:about/about_page.dart'; 

void main() {
  testWidgets('AboutPage harus menampilkan deskripsi aplikasi yang benar', (WidgetTester tester) async {
    // 1. Arrange & Act: Render widget ke dalam lingkungan test
    // Kita membungkus dengan DefaultAssetBundle untuk menangani pemuatan gambar palsu
    await tester.pumpWidget(
      DefaultAssetBundle(
        bundle: FakeAssetBundle(),
        child: const MaterialApp(
          home: AboutPage(),
        ),
      ),
    );

    // 2. Definisi teks yang dicari (sesuai dengan code Anda)
    const String expectedText = 'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.';

    // 3. Assert: Cek apakah Text tersebut ada di layar
    expect(find.text(expectedText), findsOneWidget);
  });

  testWidgets('AboutPage harus memiliki gambar logo', (WidgetTester tester) async {
    await tester.pumpWidget(
      DefaultAssetBundle(
        bundle: FakeAssetBundle(),
        child: const MaterialApp(
          home: AboutPage(),
        ),
      ),
    );

    // Mengecek keberadaan widget Image
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('AboutPage harus memiliki tombol kembali', (WidgetTester tester) async {
    await tester.pumpWidget(
      DefaultAssetBundle(
        bundle: FakeAssetBundle(),
        child: const MaterialApp(
          home: AboutPage(),
        ),
      ),
    );

    // Mengecek keberadaan Icon Back
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    
    // Mengecek keberadaan IconButton
    expect(find.byType(IconButton), findsOneWidget);
  });
}

/// Kelas palsu untuk menangani pemuatan aset gambar dalam pengujian
class FakeAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    // Jika Flutter meminta manifes dalam format JSON (legacy), kembalikan JSON kosong
    if (key == 'AssetManifest.json') return '{}';
    return '';
  }

  @override
  Future<ByteData> load(String key) async {
    // PERBAIKAN: Tangani permintaan AssetManifest.bin
    // Flutter meminta ini untuk mengetahui aset apa saja yang ada.
    // Kita harus mengembalikan data kosong yang valid sesuai format StandardMessageCodec.
    if (key == 'AssetManifest.bin') {
      final ByteData? data = const StandardMessageCodec().encodeMessage(<String, dynamic>{});
      return data!;
    }

    // Untuk semua request lain (termasuk 'assets/circle-g.png'), kembalikan gambar transparan
    return ByteData.view(Uint8List.fromList(kTransparentImage).buffer);
  }
}
// Data binary untuk gambar PNG transparan 1x1 pixel
final List<int> kTransparentImage = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
  0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
  0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
  0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
  0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42,
  0x60, 0x82,
];