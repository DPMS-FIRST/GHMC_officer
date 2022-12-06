import 'package:flutter/cupertino.dart';
import 'package:ghmc_officer/Model/full_details_response.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/View/full_grievance_details.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ImageViewPage extends StatefulWidget {
  const ImageViewPage({super.key, this.img});
  final img;

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
GrievanceFullDetails? grievanceFullDetails;

  @override
  Widget build(BuildContext context) {
   
    return Container(
      child: widget.img.contains('.pdf') ? 
      SfPdfViewer.network(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
        /* errorBuilder: (BuildContext context, Object exception,
            StackTrace? stackTrace) {
         return Image.asset(ImageConstants.no_uploaded);
            } */
     ): 
     Image.network(
        widget.img,
        errorBuilder: (BuildContext context, Object exception,
            StackTrace? stackTrace) {
         return Image.asset(ImageConstants.no_uploaded);
       },
      ),
    );
    
  }
}
/* errorBuilder: (BuildContext context, Object exception,
            StackTrace? stackTrace) {
         return Image.asset(ImageConstants.no_uploaded);
       }, */