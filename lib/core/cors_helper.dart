// import 'package:flutter/material.dart';

// class CORSHelper {
//   // Função para gerar a URL com proxy AllOrigins
//   static String getProxiedImageUrl(String originalUrl) {
//     return 'https://api.allorigins.win/raw?url=${Uri.encodeComponent(originalUrl)}';
//   }

//   // Widget para carregar a imagem com tratamento de erros
//   static Widget loadImageWithProxy({
//     required String imageUrl,
//     BoxFit fit = BoxFit.cover,
//     double width = double.infinity,
//     double height = double.infinity,
//   }) {
//     final proxiedUrl = getProxiedImageUrl(imageUrl);

//     return Image.network(
//       proxiedUrl,
//       fit: fit,
//       width: width,
//       height: height,
//       loadingBuilder: (context, child, loadingProgress) {
//         if (loadingProgress == null) return child;
//         return Container(
//           width: width,
//           height: height,
//           color: Colors.grey[200],
//           child: const Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//       errorBuilder: (context, error, stackTrace) {
//         return Container(
//           width: width,
//           height: height,
//           color: Colors.grey[200],
//           child: const Icon(Icons.broken_image, color: Colors.grey),
//         );
//       },
//     );
//   }
// }
