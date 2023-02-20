import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../custom_code/actions/index.dart' as actions;
import '../flutter_flow/admob_util.dart' as admob;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'you_lose_model.dart';
export 'you_lose_model.dart';

class YouLoseWidget extends StatefulWidget {
  const YouLoseWidget({Key? key}) : super(key: key);

  @override
  _YouLoseWidgetState createState() => _YouLoseWidgetState();
}

class _YouLoseWidgetState extends State<YouLoseWidget>
    with TickerProviderStateMixin {
  late YouLoseModel _model;

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      loop: true,
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
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => YouLoseModel());
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
          constraints: BoxConstraints(
            maxWidth: double.infinity,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: FlutterFlowTheme.of(context).lineColor,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
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
                        'Oh no... you\'re out of lives',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: FlutterFlowTheme.of(context).title3,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Lottie.asset(
                    'assets/lottie_animations/86967-shiba-sad.json',
                    width: 150,
                    height: 130,
                    fit: BoxFit.cover,
                    animate: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                          child: InkWell(
                            onTap: () async {
                              context.goNamed('homePage');

                              await Future.delayed(
                                  const Duration(milliseconds: 300));
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
                            child: Material(
                              color: Colors.transparent,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                width: 50,
                                height: 50,
                                constraints: BoxConstraints(
                                  maxWidth: double.infinity,
                                  maxHeight: 40,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      FlutterFlowTheme.of(context).secondaryColor,
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
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              4, 0, 4, 0),
                                          child: Text(
                                            'Exit',
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
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                          child: InkWell(
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

                              _model.interstitialAdSuccess =
                                  await admob.showInterstitialAd();

                              _shouldSetState = true;
                              if (FFAppState().buttonDidabled) {
                                if (_shouldSetState) setState(() {});
                                return;
                              }
                              if (_model.interstitialAdSuccess!) {
                                FFAppState().update(() {
                                  FFAppState().errorCounter = 3;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Проверьте соединений с интернетом',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor: Color(0x00000000),
                                  ),
                                );

                                context.goNamed('homePage');

                                await Future.delayed(
                                    const Duration(milliseconds: 300));
                                FFAppState().update(() {
                                  FFAppState().newGameVars = [];
                                  FFAppState().allAuthorList = [];
                                  FFAppState().newGameAuthors = [];
                                  FFAppState().counterQuestion = 0;
                                  FFAppState().errorCounter = 3;
                                  FFAppState().newGameBooks = [];
                                  FFAppState().allBookList = [];
                                });
                                if (_shouldSetState) setState(() {});
                                return;
                              }

                              Navigator.pop(context);
                              FFAppState().update(() {
                                FFAppState().buttonDidabled = true;
                              });
                              if (_shouldSetState) setState(() {});
                            },
                            child: Material(
                              color: Colors.transparent,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                width: 50,
                                height: 50,
                                constraints: BoxConstraints(
                                  maxWidth: double.infinity,
                                  maxHeight: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: FFAppState().buttonDidabled
                                      ? FlutterFlowTheme.of(context).secondaryText
                                      : FlutterFlowTheme.of(context).primaryColor,
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
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 4, 0),
                                    child: AutoSizeText(
                                      'Restore lives',
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
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation']!),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
