import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'each_author_books_model.dart';
export 'each_author_books_model.dart';

class EachAuthorBooksWidget extends StatefulWidget {
  const EachAuthorBooksWidget({Key? key}) : super(key: key);

  @override
  _EachAuthorBooksWidgetState createState() => _EachAuthorBooksWidgetState();
}

class _EachAuthorBooksWidgetState extends State<EachAuthorBooksWidget> {
  late EachAuthorBooksModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EachAuthorBooksModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          context.pushNamed('addBook');
        },
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        elevation: 8,
        child: Icon(
          Icons.add,
          color: FlutterFlowTheme.of(context).secondaryBackground,
          size: 30,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30,
            ),
            onPressed: () async {
              FFAppState().update(() {
                FFAppState().currentAuthor = null;
                FFAppState().currentAuthorName = '';
                FFAppState().currentAuthorId = '';
              });

              context.goNamed('adminPage');
            },
          ),
          actions: [],
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              FFAppState().currentAuthorName,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).title2,
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 1,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FutureBuilder<AllAuthorsRecord>(
                    future: AllAuthorsRecord.getDocumentOnce(
                        FFAppState().currentAuthor!),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: Image.network(
                            '',
                          ),
                        );
                      }
                      final circleImageAllAuthorsRecord = snapshot.data!;
                      return InkWell(
                        onLongPress: () async {
                          final selectedMedia = await selectMedia(
                            imageQuality: 50,
                            mediaSource: MediaSource.photoGallery,
                            multiImage: false,
                          );
                          if (selectedMedia != null &&
                              selectedMedia.every((m) =>
                                  validateFileFormat(m.storagePath, context))) {
                            setState(() => _model.isMediaUploading = true);
                            var selectedUploadedFiles = <FFUploadedFile>[];
                            var downloadUrls = <String>[];
                            try {
                              showUploadMessage(
                                context,
                                'Uploading file...',
                                showLoading: true,
                              );
                              selectedUploadedFiles = selectedMedia
                                  .map((m) => FFUploadedFile(
                                        name: m.storagePath.split('/').last,
                                        bytes: m.bytes,
                                        height: m.dimensions?.height,
                                        width: m.dimensions?.width,
                                      ))
                                  .toList();

                              downloadUrls = (await Future.wait(
                                selectedMedia.map(
                                  (m) async =>
                                      await uploadData(m.storagePath, m.bytes),
                                ),
                              ))
                                  .where((u) => u != null)
                                  .map((u) => u!)
                                  .toList();
                            } finally {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              _model.isMediaUploading = false;
                            }
                            if (selectedUploadedFiles.length ==
                                    selectedMedia.length &&
                                downloadUrls.length == selectedMedia.length) {
                              setState(() {
                                _model.uploadedLocalFile =
                                    selectedUploadedFiles.first;
                                _model.uploadedFileUrl = downloadUrls.first;
                              });
                              showUploadMessage(context, 'Success!');
                            } else {
                              setState(() {});
                              showUploadMessage(
                                  context, 'Failed to upload media');
                              return;
                            }
                          }

                          final allAuthorsUpdateData =
                              createAllAuthorsRecordData(
                            image: _model.uploadedFileUrl,
                          );
                          await circleImageAllAuthorsRecord.reference
                              .update(allAuthorsUpdateData);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            circleImageAllAuthorsRecord.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                    child: Text(
                      'Hold to upload picture',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                  StreamBuilder<List<BooksRecord>>(
                    stream: queryBooksRecord(
                      queryBuilder: (booksRecord) => booksRecord.where(
                          'authorId',
                          isEqualTo: FFAppState().currentAuthorId),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }
                      List<BooksRecord> listViewBooksRecordList =
                          snapshot.data!;
                      return ListView.builder(
                        primary: false,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewBooksRecordList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewBooksRecord =
                              listViewBooksRecordList[listViewIndex];
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 4, 24, 4),
                                    child: Slidable(
                                      actionPane:
                                          const SlidableScrollActionPane(),
                                      secondaryActions: [
                                        IconSlideAction(
                                          caption: 'Delete',
                                          color: FlutterFlowTheme.of(context)
                                              .redApple,
                                          icon: Icons.delete_rounded,
                                          onTap: () async {
                                            await listViewBooksRecord.reference
                                                .delete();
                                          },
                                        ),
                                        IconSlideAction(
                                          caption: 'Edit',
                                          color: Colors.blue,
                                          icon: Icons.edit_rounded,
                                          onTap: () async {
                                            FFAppState().update(() {
                                              FFAppState().editBook =
                                                  listViewBooksRecord.title!;
                                            });

                                            context.pushNamed('editBook');
                                          },
                                        ),
                                      ],
                                      child: ListTile(
                                        title: Text(
                                          listViewBooksRecord.title!,
                                          style: FlutterFlowTheme.of(context)
                                              .title3
                                              .override(
                                                fontFamily: 'Urbanist',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .dark600,
                                              ),
                                        ),
                                        subtitle: Text(
                                          FFAppState().currentAuthorName,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                        trailing: Icon(
                                          Icons.swipe,
                                          color: Color(0xFF303030),
                                          size: 30,
                                        ),
                                        tileColor: Color(0xFFF5F5F5),
                                        dense: false,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
