import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'difficulty_model.dart';
export 'difficulty_model.dart';

class DifficultyWidget extends StatefulWidget {
  const DifficultyWidget({Key? key}) : super(key: key);

  @override
  _DifficultyWidgetState createState() => _DifficultyWidgetState();
}

class _DifficultyWidgetState extends State<DifficultyWidget> {
  late DifficultyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DifficultyModel());
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
                FFAppState().newGameVars = [];
                FFAppState().allAuthorList = [];
                FFAppState().counterQuestion = 0;
                FFAppState().errorCounter = 3;
                FFAppState().allBookList = [];
                FFAppState().newGameAuthors = [];
                FFAppState().newGameBooks = [];
              });

              context.goNamed('homePage');
            },
          ),
          actions: [],
          elevation: 1,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            constraints: BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
            ),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).tertiaryColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                  child: Text(
                    'Select the difficulty',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).title1.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).dark600,
                        ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    final difficults = FFAppState().difficulty.toList();
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: difficults.length,
                      itemBuilder: (context, difficultsIndex) {
                        final difficultsItem = difficults[difficultsIndex];
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 8, 24, 8),
                                child: InkWell(
                                  onTap: () async {
                                    FFAppState().update(() {
                                      FFAppState().allAuthorList =
                                          functions.getAllAuthors()!.toList();
                                      FFAppState().allBookList =
                                          functions.getAllBooks()!.toList();
                                      FFAppState()
                                          .addToNewGameVars(difficultsItem);
                                    });
                                    if (FFAppState().newGameVars.first ==
                                        FFAppState().typeOfGame.first) {
                                      FFAppState().update(() {
                                        FFAppState().newGameBooks = functions
                                            .getNewGameArr(
                                                FFAppState()
                                                    .allBookList
                                                    .toList(),
                                                FFAppState().difficulty[
                                                    difficultsIndex])!
                                            .toList();
                                      });

                                      context.goNamed(
                                        'newGameBooks',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.topToBottom,
                                            duration:
                                                Duration(milliseconds: 800),
                                          ),
                                        },
                                      );
                                    } else {
                                      FFAppState().update(() {
                                        FFAppState().newGameAuthors = functions
                                            .getNewGameArr(
                                                FFAppState()
                                                    .allAuthorList
                                                    .toList(),
                                                difficultsIndex.toString())!
                                            .toList();
                                      });

                                      context.goNamed(
                                        'newGameImage',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.topToBottom,
                                            duration:
                                                Duration(milliseconds: 800),
                                          ),
                                        },
                                      );
                                    }
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x33000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12, 0, 12, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                () {
                                                  if (difficultsItem == '0') {
                                                    return 'Easy';
                                                  } else if (difficultsItem ==
                                                      '1') {
                                                    return 'Medium';
                                                  } else {
                                                    return 'Hard';
                                                  }
                                                }(),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .title1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
