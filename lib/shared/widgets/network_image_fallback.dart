import 'package:flutter/material.dart';

class NetworkImageFallback extends StatelessWidget {
  const NetworkImageFallback({
    super.key,
    required this.url,
    required this.placeholderAsset,
    required this.errorAsset,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.urlPrefix,
  });

  final String? url;
  final String placeholderAsset;
  final String errorAsset;
  final BoxFit fit;
  final double? width;
  final double? height;
  final String? urlPrefix;

  String _resolveUrl() {
    final raw = url?.trim() ?? '';
    if (raw.isEmpty) return '';
    if (raw.startsWith('http://') || raw.startsWith('https://')) {
      return raw;
    }
    if (urlPrefix != null && urlPrefix!.isNotEmpty) {
      return '$urlPrefix$raw';
    }
    return raw;
  }

  @override
  Widget build(BuildContext context) {
    final resolved = _resolveUrl();
    if (resolved.isEmpty) {
      return Image.asset(errorAsset, fit: fit, width: width, height: height);
    }

    return Image.network(
      resolved,
      fit: fit,
      width: width,
      height: height,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Image.asset(
          placeholderAsset,
          fit: fit,
          width: width,
          height: height,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(errorAsset, fit: fit, width: width, height: height);
      },
    );
  }
}
