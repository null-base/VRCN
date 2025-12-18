import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vrchat/gen/strings.g.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 28),
          onPressed: () => context.pop(),
          tooltip: t.qrScanner.title,
        ),
        title: Text(
          t.qrScanner.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              final barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final code = barcodes.first.rawValue;
                if (code != null &&
                    code.startsWith('https://vrchat.com/home/user/')) {
                  final userId = code.split('/').last;
                  if (userId.isNotEmpty) {
                    context.pop();
                    context.push('/user/$userId');
                  }
                } else {
                  // 無効なQRコード
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(t.qrScanner.notFound),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              }
            },
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: .35)),
          ),
          // 中央のスキャン枠
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 24,
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.10),
                    Colors.tealAccent.withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(left: 0, top: 0, child: _cornerLine()),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Transform.rotate(
                      angle: 1.5708,
                      child: _cornerLine(),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Transform.rotate(
                      angle: 3.1416,
                      child: _cornerLine(),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Transform.rotate(
                      angle: -1.5708,
                      child: _cornerLine(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 48,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white70,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  t.qrScanner.guide,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cornerLine() {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white, width: 4),
          left: BorderSide(color: Colors.white, width: 4),
        ),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(18)),
      ),
    );
  }
}
