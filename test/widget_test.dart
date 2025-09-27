import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mybio_app/main.dart';  // Pastikan ini sesuai dengan nama file utama Anda

void main() {
  testWidgets('SplashScreen test', (WidgetTester tester) async {
    // Build aplikasi dan trigger frame pertama.
    await tester.pumpWidget(const BiodataWireframeApp());

    // Verifikasi bahwa splash screen terlihat dengan logo dan teks placeholder.
    expect(find.byType(CircularProgressIndicator), findsNothing);  // Menguji apakah splash screen tidak menampilkan indikator loading
    expect(find.text('Wireframe Biodata'), findsOneWidget); // Pastikan judul aplikasi ada di SplashScreen

    // Tunggu 2 detik untuk melihat apakah navigasi berjalan.
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Setelah waktu 2 detik, periksa apakah pindah ke halaman berikutnya
    expect(find.byType(AppLogoScene), findsOneWidget); // Pastikan OnboardingScreen1 muncul setelah SplashScreen
  });

  testWidgets('OnboardingScreen1 navigation test', (WidgetTester tester) async {
    // Build aplikasi dan trigger frame pertama.
    await tester.pumpWidget(const BiodataWireframeApp());

    // Menunggu halaman AppLogoScene.
    await tester.pumpAndSettle();

    // Verifikasi apakah layar berikutnya adalah AppLogoScene.
    expect(find.byType(AppLogoScene), findsOneWidget);

    // Tap tombol next untuk pindah ke halaman berikutnya.
    await tester.tap(find.text('MULAI')); // Tombol MULAI
    await tester.pumpAndSettle();

    // Verifikasi bahwa layar pindah ke LocationAccessScreen.
    Type LocationAccessScreen;
    expect(find.byType(LocationAccessScreen), findsOneWidget);
  });
}
