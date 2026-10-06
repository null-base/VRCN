import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TwoFactorCodeInput extends StatefulWidget {
  const TwoFactorCodeInput({
    super.key,
    required this.controller,
    required this.onCompleted,
    this.enabled = true,
    this.semanticLabel = 'One-time code',
  });

  final TextEditingController controller;
  final ValueChanged<String> onCompleted;
  final bool enabled;
  final String semanticLabel;

  @override
  State<TwoFactorCodeInput> createState() => _TwoFactorCodeInputState();
}

class _TwoFactorCodeInputState extends State<TwoFactorCodeInput> {
  String? _completedCode;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(covariant TwoFactorCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleControllerChanged);
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _handleControllerChanged() {
    if (mounted) setState(() {});
  }

  void _handleChanged(String value) {
    final normalized = _normalize(value);
    if (normalized != value) {
      widget.controller.value = TextEditingValue(
        text: normalized,
        selection: TextSelection.collapsed(offset: normalized.length),
      );
      return;
    }

    setState(() {});
    if (normalized.length == 6) {
      if (_completedCode == normalized) return;
      _completedCode = normalized;
      widget.onCompleted(normalized);
    } else {
      _completedCode = null;
    }
  }

  String _normalize(String value) {
    final digits = value.replaceAll(RegExp('[^0-9]'), '');
    return digits.length > 6 ? digits.substring(0, 6) : digits;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final code = _normalize(widget.controller.text);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDarkMode ? 75 : 13),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: SizedBox(
          height: 50,
          child: Stack(
            children: [
              Row(
                children: List.generate(
                  6,
                  (index) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index == 5 ? 0 : 6),
                      child: _DigitBox(
                        value: index < code.length ? code[index] : '',
                        isDarkMode: isDarkMode,
                        colorScheme: theme.colorScheme,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Semantics(
                  label: widget.semanticLabel,
                  textField: true,
                  child: TextField(
                    controller: widget.controller,
                    enabled: widget.enabled,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    maxLength: 6,
                    showCursor: false,
                    style: const TextStyle(
                      color: Colors.transparent,
                      fontSize: 1,
                    ),
                    cursorColor: Colors.transparent,
                    decoration: const InputDecoration(
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      counterText: '',
                    ),
                    onChanged: _handleChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DigitBox extends StatelessWidget {
  const _DigitBox({
    required this.value,
    required this.isDarkMode,
    required this.colorScheme,
  });

  final String value;
  final bool isDarkMode;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final hasValue = value.isNotEmpty;
    final color = colorScheme.primary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: hasValue
            ? color.withAlpha(isDarkMode ? 75 : 25)
            : (isDarkMode ? Colors.grey[700] : Colors.grey[100]),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: hasValue
              ? color
              : (isDarkMode ? Colors.grey[600]! : Colors.grey.withAlpha(75)),
          width: hasValue ? 2 : 1,
        ),
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : color,
          ),
        ),
      ),
    );
  }
}
