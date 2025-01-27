import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavalhaDialog extends StatefulWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final Future<void> Function()? onConfirm;
  final VoidCallback? onCancel;
  final Color textConfirmColor;
  final Color textCancelColor;

  const NavalhaDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.cancelText,
    required this.confirmText,
    this.onConfirm,
    this.onCancel,
    this.textConfirmColor = Colors.redAccent,
    this.textCancelColor = Colors.grey,
  }) : super(key: key);

  @override
  State<NavalhaDialog> createState() => _NavalhaDialogState();
}

class _NavalhaDialogState extends State<NavalhaDialog> {
  bool _loading = false;

  void _handleConfirm() async {
    setState(() => _loading = true);
    if (widget.onConfirm != null) {
      await widget.onConfirm!();
    }
    setState(() => _loading = false);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(widget.title),
      ),
      content: Text(widget.content),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            if (widget.onCancel != null) widget.onCancel!();
          },
          textStyle: TextStyle(color: widget.textCancelColor),
          child: Text(widget.cancelText),
        ),
        CupertinoDialogAction(
          onPressed: _loading ? null : _handleConfirm,
          textStyle: TextStyle(color: widget.textConfirmColor),
          child: _loading
              ? const CupertinoActivityIndicator()
              : Text(widget.confirmText),
        ),
      ],
    );
  }
}
