import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../custom_code/actions/index.dart' as actions;
import '../flutter_flow/admob_util.dart' as admob;
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'end_game_model.dart';
export 'end_game_model.dart';

class EndGameWidget extends StatefulWidget {
  const EndGameWidget({Key? key}) : super(key: key);

  @override
  _EndGameWidgetState createState() => _EndGameWidgetState();
}

class _EndGameWidgetState extends State<EndGameWidget>
    with TickerProviderStateMixin {
  late EndGameModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 200.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 500.ms,
          begin: Offset(0, 0),
          end: Offset(0, -5),
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 500.ms,
          duration: 600.ms,
          begin: Offset(0, -5),
          end: Offset(0, 5),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EndGameModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      admob.loadInterstitialAd(
        "",
        "ca-app-pub-8179877165837386/9881903451",
        false,
      );
    });
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
        FFAppState().update(() {
          FFAppState().newGameVars = [];
          FFAppState().allAuthorList = [];
          FFAppState().newGameAuthors = [];
          FFAppState().counterQuestion = 0;
          FFAppState().errorCounter = 3;
          FFAppState().newGameBooks = [];
          FFAppState().allBookList = [];
        });
        await Future.delayed(const Duration(milliseconds: 100));
        context.goNamed('homePage');
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
            actions: [
              FlutterFlowIconButton(
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
                  FFAppState().update(() {
                    FFAppState().newGameVars = [];
                    FFAppState().allAuthorList = [];
                    FFAppState().newGameAuthors = [];
                    FFAppState().counterQuestion = 0;
                    FFAppState().errorCounter = 3;
                    FFAppState().allBookList = [];
                    FFAppState().newGameBooks = [];
                    FFAppState().localPoints = 0;
                  });

                  context.goNamed('homePage');
                },
              ),
            ],
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
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 36, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                      child: Text(
                        'You have successfully completed!',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Urbanist',
                              color: FlutterFlowTheme.of(context).dark600,
                            ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(),
                      child: Lottie.asset(
                        'assets/lottie_animations/67230-trophy-winner.json',
                        width: 100,
                        height: 200,
                        fit: BoxFit.contain,
                        animate: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Your reward ${FFAppState().localPoints.toString()} points',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Urbanist',
                                  color: FlutterFlowTheme.of(context).dark600,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
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
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
                      child: GridView(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 40,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2,
                        ),
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              FFAppState().update(() {
                                FFAppState().newGameVars = functions
                                    .deleteLastIndexArr(
                                        FFAppState().newGameVars.toList())!
                                    .toList();
                                FFAppState().allAuthorList = [];
                                FFAppState().newGameAuthors = [];
                                FFAppState().counterQuestion = 0;
                                FFAppState().errorCounter = 3;
                                FFAppState().newGameBooks = [];
                                FFAppState().allBookList = [];
                                FFAppState().localPoints = 0;
                              });

                              context.goNamed('difficulty');
                            },
                            text: 'Try again',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Urbanist',
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              var _shouldSetState = false;
                              _model.internet =
                                  await actions.checkInternetConnection();
                              _shouldSetState = true;
                              if (!_model.internet!) {
                                FFAppState().update(() {
                                  FFAppState().buttonDidabled = true;
                                });
                              }
                              if (FFAppState().buttonDidabled) {
                                if (_shouldSetState) setState(() {});
                                return;
                              }

                              _model.interstitialAdSuccess =
                                  await admob.showInterstitialAd();

                              _shouldSetState = true;
                              await Future.delayed(
                                  const Duration(milliseconds: 300));
                              if (_model.interstitialAdSuccess!) {
                                final usersUpdateData = createUsersRecordData(
                                  userStats: createUsersStatisticStruct(
                                    usersGames: updateAllComplitedGamesStruct(
                                      currentUserDocument!.userStats.usersGames,
                                      clearUnsetFields: false,
                                    ),
                                    fieldValues: {
                                      'usersPoints': FieldValue.increment(
                                          FFAppState().localPoints),
                                    },
                                    clearUnsetFields: false,
                                  ),
                                );
                                await currentUserReference!
                                    .update(usersUpdateData);
                                await Future.delayed(
                                    const Duration(milliseconds: 300));
                                FFAppState().update(() {
                                  FFAppState().localPoints =
                                      FFAppState().localPoints +
                                          FFAppState().localPoints;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Check your Internet connection',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 2000),
                                    backgroundColor: Color(0x00000000),
                                  ),
                                );
                              }

                              FFAppState().update(() {
                                FFAppState().buttonDidabled = true;
                              });
                              if (_shouldSetState) setState(() {});
                            },
                            child: Material(
                              color: Colors.transparent,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: FFAppState().buttonDidabled
                                      ? FlutterFlowTheme.of(context)
                                          .secondaryText
                                      : FlutterFlowTheme.of(context)
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
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 0, 4, 0),
                                          child: Text(
                                            'Double points',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
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
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation2']!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ).animateOnPageLoad(
                animationsMap['containerOnPageLoadAnimation1']!),
          ),
        ),
      ),
    );
  }
}
