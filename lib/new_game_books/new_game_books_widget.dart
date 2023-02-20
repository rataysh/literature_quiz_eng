import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/hint_widget.dart';
import '../components/you_lose_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/admob_util.dart' as admob;
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'new_game_books_model.dart';
export 'new_game_books_model.dart';

class NewGameBooksWidget extends StatefulWidget {
  const NewGameBooksWidget({Key? key}) : super(key: key);

  @override
  _NewGameBooksWidgetState createState() => _NewGameBooksWidgetState();
}

class _NewGameBooksWidgetState extends State<NewGameBooksWidget>
    with TickerProviderStateMixin {
  late NewGameBooksModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final animationsMap = {
    'iconOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        VisibilityEffect(duration: 1.ms),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 500.ms,
          begin: Offset(0, 0),
          end: Offset(100, 0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 500.ms,
          begin: 1,
          end: 0,
        ),
      ],
    ),
    'containerOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ShakeEffect(
          curve: Curves.elasticOut,
          delay: 0.ms,
          duration: 1000.ms,
          hz: 3,
          offset: Offset(0, 0),
          rotation: 0.052,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewGameBooksModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().update(() {
        FFAppState().currentFourItem = functions
            .booksGetFourItems(
                FFAppState().allAuthorList.toList(),
                'myId',
                getJsonField(
                  FFAppState().newGameBooks[FFAppState().counterQuestion],
                  r'''$.authorId''',
                ).toString().toString())
            .toList();
      });

      admob.loadInterstitialAd(
        "",
        "ca-app-pub-8179877165837386/4821148467",
        false,
      );
    });

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
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

    return WillPopScope(
      onWillPop: () async {
        var confirmDialogResponse = await showDialog<bool>(
              context: context,
              builder: (alertDialogContext) {
                return AlertDialog(
                  title: Text('Go to home?'),
                  content: Text('Are you sure you want to get out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext, false),
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext, true),
                      child: Text('Yes'),
                    ),
                  ],
                );
              },
            ) ??
            false;
        if (confirmDialogResponse) {
          context.goNamed('homePage');

          await Future.delayed(const Duration(milliseconds: 300));
        } else {
          return false;
        }

        FFAppState().update(() {
          FFAppState().newGameVars = [];
          FFAppState().allAuthorList = [];
          FFAppState().newGameAuthors = [];
          FFAppState().counterQuestion = 0;
          FFAppState().errorCounter = 3;
          FFAppState().newGameBooks = [];
          FFAppState().allBookList = [];
        });
        return false;
      },
      child: Scaffold(
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
                Icons.home_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30,
              ),
              onPressed: () async {
                var confirmDialogResponse = await showDialog<bool>(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text('Go to home?'),
                          content: Text('Are you sure you want to get out?'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, false),
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, true),
                              child: Text('Yes'),
                            ),
                          ],
                        );
                      },
                    ) ??
                    false;
                if (confirmDialogResponse) {
                  context.goNamed('homePage');

                  await Future.delayed(const Duration(milliseconds: 300));
                } else {
                  return;
                }

                FFAppState().update(() {
                  FFAppState().newGameVars = [];
                  FFAppState().allAuthorList = [];
                  FFAppState().newGameAuthors = [];
                  FFAppState().counterQuestion = 0;
                  FFAppState().errorCounter = 3;
                  FFAppState().newGameBooks = [];
                  FFAppState().allBookList = [];
                });
              },
            ),
            actions: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: FaIcon(
                  FontAwesomeIcons.solidLightbulb,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 27,
                ),
                onPressed: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: HintWidget(),
                      );
                    },
                  ).then((value) => setState(() {}));
                },
              ),
            ],
            elevation: 1,
          ),
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: LinearPercentIndicator(
                            percent: functions.progressBarProcent(() {
                              if (FFAppState().newGameVars[1] == '0') {
                                return '10';
                              } else if (FFAppState().newGameVars[1] == '1') {
                                return '15';
                              } else {
                                return '20';
                              }
                            }(), FFAppState().counterQuestion)!,
                            width: MediaQuery.of(context).size.width,
                            lineHeight: 24,
                            animation: false,
                            progressColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            backgroundColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            center: Text(
                              '${functions.incrementInt(FFAppState().counterQuestion).toString()}/${() {
                                if (FFAppState().newGameVars[1] == '0') {
                                  return '10';
                                } else if (FFAppState().newGameVars[1] == '1') {
                                  return '15';
                                } else {
                                  return '20';
                                }
                              }()}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Urbanist',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                            ),
                            barRadius: Radius.circular(8),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 8, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            'Who wrote ',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .title2
                                                .override(
                                                  fontFamily: 'Urbanist',
                                                  fontSize: 21,
                                                ),
                                          ),
                                        ),
                                        Wrap(
                                          spacing: 0,
                                          runSpacing: 0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          direction: Axis.horizontal,
                                          runAlignment: WrapAlignment.start,
                                          verticalDirection:
                                              VerticalDirection.down,
                                          clipBehavior: Clip.none,
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 24, 0, 0),
                                                child: Text(
                                                  '\"${getJsonField(
                                                    FFAppState().newGameBooks[
                                                        FFAppState()
                                                            .counterQuestion],
                                                    r'''$.title''',
                                                  ).toString()}\"',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .title2
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        fontSize: 21,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(6, 0, 6, 0),
                            child: Icon(
                              Icons.favorite_rounded,
                              color: FlutterFlowTheme.of(context).redApple,
                              size: 30,
                            ).animateOnActionTrigger(
                              animationsMap['iconOnActionTriggerAnimation']!,
                            ),
                          ),
                          badges.Badge(
                            badgeContent: Text(
                              FFAppState().errorCounter.toString(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Urbanist',
                                    color: Colors.white,
                                  ),
                            ),
                            showBadge: true,
                            shape: badges.BadgeShape.circle,
                            badgeColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            elevation: 4,
                            position: badges.BadgePosition.topEnd(),
                            animationType: badges.BadgeAnimationType.scale,
                            toAnimate: true,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(6, 0, 6, 0),
                              child: Icon(
                                Icons.favorite_rounded,
                                color: FlutterFlowTheme.of(context).redApple,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 24),
                        child: Builder(
                          builder: (context) {
                            final answer =
                                FFAppState().currentFourItem.toList();
                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 24,
                                childAspectRatio: MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 2),
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: answer.length,
                              itemBuilder: (context, answerIndex) {
                                final answerItem = answer[answerIndex];
                                return InkWell(
                                  onTap: () async {
                                    if (FFAppState().errorCounter <= 0) {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        isDismissible: false,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: YouLoseWidget(),
                                          );
                                        },
                                      ).then((value) => setState(() {}));

                                      return;
                                    }
                                    if (getJsonField(
                                          FFAppState().newGameBooks[
                                              FFAppState().counterQuestion],
                                          r'''$.authorId''',
                                        ) !=
                                        getJsonField(
                                          answerItem,
                                          r'''$.myId''',
                                        )) {
                                      if (animationsMap[
                                              'containerOnActionTriggerAnimation'] !=
                                          null) {
                                        animationsMap[
                                                'containerOnActionTriggerAnimation']!
                                            .controller
                                            .forward(from: 0.0);
                                      }
                                      if (FFAppState().errorCounter == 3) {
                                        FFAppState().update(() {
                                          FFAppState().errorCounter =
                                              FFAppState().errorCounter + -1;
                                        });
                                        if (animationsMap[
                                                'iconOnActionTriggerAnimation'] !=
                                            null) {
                                          await animationsMap[
                                                  'iconOnActionTriggerAnimation']!
                                              .controller
                                              .forward(from: 0.0);
                                        }
                                        if (animationsMap[
                                                'iconOnActionTriggerAnimation'] !=
                                            null) {
                                          animationsMap[
                                                  'iconOnActionTriggerAnimation']!
                                              .controller
                                              .reset();
                                        }
                                        return;
                                      } else {
                                        if (FFAppState().errorCounter == 2) {
                                          FFAppState().update(() {
                                            FFAppState().errorCounter =
                                                FFAppState().errorCounter + -1;
                                          });
                                          if (animationsMap[
                                                  'iconOnActionTriggerAnimation'] !=
                                              null) {
                                            await animationsMap[
                                                    'iconOnActionTriggerAnimation']!
                                                .controller
                                                .forward(from: 0.0);
                                          }
                                          if (animationsMap[
                                                  'iconOnActionTriggerAnimation'] !=
                                              null) {
                                            animationsMap[
                                                    'iconOnActionTriggerAnimation']!
                                                .controller
                                                .reset();
                                          }
                                          return;
                                        } else {
                                          FFAppState().update(() {
                                            FFAppState().errorCounter =
                                                FFAppState().errorCounter + -1;
                                          });
                                          if (animationsMap[
                                                  'iconOnActionTriggerAnimation'] !=
                                              null) {
                                            await animationsMap[
                                                    'iconOnActionTriggerAnimation']!
                                                .controller
                                                .forward(from: 0.0);
                                          }
                                          if (animationsMap[
                                                  'iconOnActionTriggerAnimation'] !=
                                              null) {
                                            animationsMap[
                                                    'iconOnActionTriggerAnimation']!
                                                .controller
                                                .reset();
                                          }
                                        }

                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          isDismissible: false,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding: MediaQuery.of(context)
                                                  .viewInsets,
                                              child: YouLoseWidget(),
                                            );
                                          },
                                        ).then((value) => setState(() {}));
                                      }
                                    }
                                    if ('${functions.incrementInt(FFAppState().counterQuestion).toString()}' ==
                                        () {
                                          if (FFAppState().newGameVars[1] ==
                                              '0') {
                                            return '10';
                                          } else if (FFAppState()
                                                  .newGameVars[1] ==
                                              '1') {
                                            return '15';
                                          } else {
                                            return '20';
                                          }
                                        }()) {
                                      context.goNamed('endGame');

                                      FFAppState().update(() {
                                        FFAppState().localPoints = () {
                                          if (FFAppState().newGameVars[1] ==
                                              '0') {
                                            return 30;
                                          } else if (FFAppState()
                                                  .newGameVars[1] ==
                                              '1') {
                                            return 60;
                                          } else {
                                            return 140;
                                          }
                                        }();
                                      });

                                      final usersUpdateData =
                                          createUsersRecordData(
                                        userStats: createUsersStatisticStruct(
                                          usersGames:
                                              createAllComplitedGamesStruct(
                                            fieldValues: {
                                              'booksGameCounter':
                                                  FieldValue.increment(1),
                                            },
                                            clearUnsetFields: false,
                                          ),
                                          fieldValues: {
                                            'usersPoints':
                                                FieldValue.increment(() {
                                              if (FFAppState().newGameVars[1] ==
                                                  '0') {
                                                return 30;
                                              } else if (FFAppState()
                                                      .newGameVars[1] ==
                                                  '1') {
                                                return 60;
                                              } else {
                                                return 140;
                                              }
                                            }()),
                                            'usersLevel':
                                                FieldValue.increment(() {
                                              if (FFAppState().newGameVars[1] ==
                                                  '0') {
                                                return 30;
                                              } else if (FFAppState()
                                                      .newGameVars[1] ==
                                                  '1') {
                                                return 60;
                                              } else {
                                                return 140;
                                              }
                                            }()),
                                          },
                                          clearUnsetFields: false,
                                        ),
                                      );
                                      await currentUserReference!
                                          .update(usersUpdateData);
                                      FFAppState().update(() {
                                        FFAppState().allAuthorList = [];
                                        FFAppState().newGameAuthors = [];
                                        FFAppState().counterQuestion = 0;
                                        FFAppState().errorCounter = 3;
                                      });
                                      return;
                                    }
                                    FFAppState().update(() {
                                      FFAppState().counterQuestion =
                                          FFAppState().counterQuestion + 1;
                                    });
                                    await Future.delayed(
                                        const Duration(milliseconds: 100));
                                    FFAppState().update(() {
                                      FFAppState().currentFourItem = functions
                                          .booksGetFourItems(
                                              FFAppState()
                                                  .allAuthorList
                                                  .toList(),
                                              'myId',
                                              getJsonField(
                                                FFAppState().newGameBooks[
                                                    FFAppState()
                                                        .counterQuestion],
                                                r'''$.authorId''',
                                              ).toString())
                                          .toList();
                                    });
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4,
                                            color: Color(0x33000000),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Wrap(
                                          spacing: 0,
                                          runSpacing: 0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          direction: Axis.horizontal,
                                          runAlignment: WrapAlignment.start,
                                          verticalDirection:
                                              VerticalDirection.down,
                                          clipBehavior: Clip.none,
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(4, 0, 4, 0),
                                                child: Text(
                                                  '${getJsonField(
                                                    answerItem,
                                                    r'''$.fullName''',
                                                  ).toString()}',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .subtitle2
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ).animateOnActionTrigger(
                                  animationsMap[
                                      'containerOnActionTriggerAnimation']!,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
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
