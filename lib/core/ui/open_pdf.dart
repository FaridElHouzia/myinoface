import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:myinoface/core/util/url_service.dart';


class OpenPDF extends StatelessWidget {

  final String path;
  final String title;
  const OpenPDF(this.path, this.title, {Key? key}) : super(key: key); // const OpenPDF(this.path, [this.title]);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _connected(),
      body: FutureBuilder<PDFDocument>(
        future: PDFDocument.fromURL(UrlService.rewriteInoserUri(path)),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.data != null) {
                return PDFViewer(
                  document: snapshot.data!,
                  lazyLoad: false,
                  zoomSteps: 1,
                );
              } else {
                return const SizedBox.shrink();
              }
          }
        },
      ),
    );
  }

  // Widget _connected() {
  //   return PDF(
  //     enableSwipe: true,
  //     swipeHorizontal: true,
  //     autoSpacing: true,
  //     pageFling: false,
  //     onError: (error) {
  //       print(error.toString());
  //     },
  //   ).cachedFromUrl(path,
  //     placeholder: (progress) => Center(child: Text('$progress %')),
  //     errorWidget: (error) => Center(child: Text(error.toString())),
  //   );
  // }
}