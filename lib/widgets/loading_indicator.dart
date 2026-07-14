import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/assets.gen.dart';
import 'package:vrchat/gen/strings.g.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key, this.message = ''});
  final String message;

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var _showFirstImage = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    // アニメーション完了時に画像を切り替え
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showFirstImage = !_showFirstImage;
        });
        _controller.reset();
        _controller.forward();
      }
    });

    // アニメーションを開始
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final displayMessage = widget.message.isEmpty
        ? t.common.loading
        : widget.message;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // キャラクターのアニメーション部分
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 180,
                height: 180,

                child: Image.asset(
                  _showFirstImage
                      ? Assets.images.anomeaWalk.path
                      : Assets.images.anomeaWalk2.path,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // メッセージテキスト
          Text(
            displayMessage,
            style: GoogleFonts.notoSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
