import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'hint_model.dart';
export 'hint_model.dart';

class HintWidget extends StatefulWidget {
  const HintWidget({Key? key}) : super(key: key);

  @override
  _HintWidgetState createState() => _HintWidgetState();
}

class _HintWidgetState extends State<HintWidget> {
  late HintModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HintModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        child: Container(
          width: 300,
          height: 330,
          constraints: BoxConstraints(
            maxWidth: double.infinity,
            maxHeight: 330,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: FlutterFlowTheme.of(context).lineColor,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Wrap(
                        spacing: 0,
                        runSpacing: 0,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: [
                          Text(
                            'Choose a hint',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: FlutterFlowTheme.of(context).title3,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                            child: InkWell(
                              onTap: () async {
                                if (currentUserDocument!
                                        .userStats.usersPoints! >=
                                    50) {
                                  final usersUpdateData = createUsersRecordData(
                                    userStats: createUsersStatisticStruct(
                                      usersGames: updateAllComplitedGamesStruct(
                                        currentUserDocument!
                                            .userStats.usersGames,
                                        clearUnsetFields: false,
                                      ),
                                      fieldValues: {
                                        'usersPoints':
                                            FieldValue.increment(-(50)),
                                      },
                                      clearUnsetFields: false,
                                    ),
                                  );
                                  await currentUserReference!
                                      .update(usersUpdateData);
                                  await Future.delayed(
                                      const Duration(milliseconds: 50));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'У вас недостаточно очков',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 2000),
                                      backgroundColor: Color(0x00000000),
                                    ),
                                  );
                                  return;
                                }

                                if (FFAppState().newGameVars.first ==
                                    FFAppState().typeOfGame[0]) {
                                  FFAppState().update(() {
                                    FFAppState().currentFourItem = functions
                                        .booksGetFourItems(
                                            FFAppState().allAuthorList.toList(),
                                            'myId',
                                            getJsonField(
                                              FFAppState().newGameBooks[
                                                  FFAppState().counterQuestion],
                                              r'''$.authorId''',
                                            ).toString())
                                        .toList();
                                  });
                                } else {
                                  FFAppState().update(() {
                                    FFAppState().currentFourItem = functions
                                        .namesGetFourItems(
                                            FFAppState()
                                                .newGameAuthors
                                                .toList(),
                                            FFAppState().counterQuestion,
                                            FFAppState().allAuthorList.toList())
                                        .toList();
                                  });
                                }

                                Navigator.pop(context);
                              },
                              child: Material(
                                color: Colors.transparent,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x33000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 8, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          'Update responses',
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle2
                                              .override(
                                                fontFamily: 'Urbanist',
                                                fontSize: 17,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '50',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .subtitle1,
                                            ),
                                            Lottie.asset(
                                              'assets/lottie_animations/72821-gold-coin.json',
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                              animate: true,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                            child: InkWell(
                              onTap: () async {
                                if (currentUserDocument!
                                        .userStats.usersPoints! >=
                                    100) {
                                  final usersUpdateData = createUsersRecordData(
                                    userStats: createUsersStatisticStruct(
                                      usersGames: updateAllComplitedGamesStruct(
                                        currentUserDocument!
                                            .userStats.usersGames,
                                        clearUnsetFields: false,
                                      ),
                                      fieldValues: {
                                        'usersPoints':
                                            FieldValue.increment(-(100)),
                                      },
                                      clearUnsetFields: false,
                                    ),
                                  );
                                  await currentUserReference!
                                      .update(usersUpdateData);
                                  await Future.delayed(
                                      const Duration(milliseconds: 50));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'У вас недостаточно очков',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 2000),
                                      backgroundColor: Color(0x00000000),
                                    ),
                                  );
                                  return;
                                }

                                if (FFAppState().newGameVars.first ==
                                    FFAppState().typeOfGame[0]) {
                                  FFAppState().update(() {
                                    FFAppState().currentFourItem = functions
                                        .booksGetTwoItems(
                                            FFAppState().allAuthorList.toList(),
                                            'myId',
                                            getJsonField(
                                              FFAppState().newGameBooks[
                                                  FFAppState().counterQuestion],
                                              r'''$.authorId''',
                                            ).toString())
                                        .toList();
                                  });
                                } else {
                                  FFAppState().update(() {
                                    FFAppState().currentFourItem = functions
                                        .namesGetTwoItems(
                                            FFAppState()
                                                .newGameAuthors
                                                .toList(),
                                            FFAppState().counterQuestion,
                                            FFAppState().allAuthorList.toList())
                                        .toList();
                                  });
                                }

                                Navigator.pop(context);
                              },
                              child: Material(
                                color: Colors.transparent,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x33000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 8, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          '50/50',
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle2
                                              .override(
                                                fontFamily: 'Urbanist',
                                                fontSize: 20,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '100',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .subtitle1,
                                            ),
                                            Lottie.asset(
                                              'assets/lottie_animations/72821-gold-coin.json',
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                              animate: true,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 7),
                            child: InkWell(
                              onTap: () async {
                                if (currentUserDocument!
                                        .userStats.usersPoints! >=
                                    200) {
                                  final usersUpdateData = createUsersRecordData(
                                    userStats: createUsersStatisticStruct(
                                      usersGames: updateAllComplitedGamesStruct(
                                        currentUserDocument!
                                            .userStats.usersGames,
                                        clearUnsetFields: false,
                                      ),
                                      fieldValues: {
                                        'usersPoints':
                                            FieldValue.increment(-(200)),
                                      },
                                      clearUnsetFields: false,
                                    ),
                                  );
                                  await currentUserReference!
                                      .update(usersUpdateData);
                                  await Future.delayed(
                                      const Duration(milliseconds: 50));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'У вас недостаточно очков',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 2000),
                                      backgroundColor: Color(0x00000000),
                                    ),
                                  );
                                  return;
                                }

                                if (FFAppState().newGameVars.first ==
                                    FFAppState().typeOfGame[0]) {
                                  FFAppState().update(() {
                                    FFAppState().currentFourItem = functions
                                        .booksGetOneItems(
                                            FFAppState().allAuthorList.toList(),
                                            'myId',
                                            getJsonField(
                                              FFAppState().newGameBooks[
                                                  FFAppState().counterQuestion],
                                              r'''$.authorId''',
                                            ).toString())
                                        .toList();
                                  });
                                } else {
                                  FFAppState().update(() {
                                    FFAppState().currentFourItem = functions
                                        .namesGetOneItems(
                                            FFAppState()
                                                .newGameAuthors
                                                .toList(),
                                            FFAppState().counterQuestion)
                                        .toList();
                                  });
                                }

                                Navigator.pop(context);
                              },
                              child: Material(
                                color: Colors.transparent,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x33000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 8, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          'Get an answer',
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle2
                                              .override(
                                                fontFamily: 'Urbanist',
                                                fontSize: 17,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '200',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .subtitle1,
                                            ),
                                            Lottie.asset(
                                              'assets/lottie_animations/72821-gold-coin.json',
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                              animate: true,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AuthUserStreamWidget(
                                  builder: (context) => Text(
                                    'У вас ${currentUserDocument!.userStats.usersPoints?.toString()} очков',
                                    textAlign: TextAlign.center,
                                    style:
                                        FlutterFlowTheme.of(context).subtitle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(1, -1),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 0,
                  borderWidth: 0,
                  buttonSize: 40,
                  icon: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 22,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
