import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddNewAuthorsModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for authorName widget.
  TextEditingController? authorNameController;
  String? Function(BuildContext, String?)? authorNameControllerValidator;
  String? _authorNameControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'This field is required';
    }

    return null;
  }

  // State field(s) for authorSecondName widget.
  TextEditingController? authorSecondNameController;
  String? Function(BuildContext, String?)? authorSecondNameControllerValidator;
  String? _authorSecondNameControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'This field is required';
    }

    if (val.length < 2) {
      return 'Requires at least 2 characters.';
    }

    return null;
  }

  // State field(s) for patronymicName widget.
  TextEditingController? patronymicNameController;
  String? Function(BuildContext, String?)? patronymicNameControllerValidator;
  String? _patronymicNameControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'This field is required';
    }

    return null;
  }

  bool isMediaUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    authorNameControllerValidator = _authorNameControllerValidator;
    authorSecondNameControllerValidator = _authorSecondNameControllerValidator;
    patronymicNameControllerValidator = _patronymicNameControllerValidator;
  }

  void dispose() {
    authorNameController?.dispose();
    authorSecondNameController?.dispose();
    patronymicNameController?.dispose();
  }

  /// Additional helper methods are added here.

}
