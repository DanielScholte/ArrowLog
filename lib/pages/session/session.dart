import 'package:arrow_log/blocs/session/session_bloc.dart';
import 'package:arrow_log/models/session/session.dart';
import 'package:arrow_log/utils/share.dart';
import 'package:arrow_log/widgets/appbar.dart';
import 'package:arrow_log/widgets/card.dart';
import 'package:arrow_log/widgets/info_block.dart';
import 'package:arrow_log/widgets/list_view.dart';
import 'package:arrow_log/widgets/score_insert.dart';
import 'package:arrow_log/widgets/score_sheet.dart';
import 'package:arrow_log/widgets/session_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SessionPage extends StatefulWidget {
  final Session session;

  SessionPage({
    @required this.session
  });

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  bool _editing = false;
  int _selected;
  List<int> _oldScores;

  @override
  initState() {
    super.initState();

    _selected = widget.session.scoreIds.indexWhere((s) => s == null);

    if (_selected == -1) {
      _selected = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        if (state is LoadedSessionState) {
          Session session = state.sessions.firstWhere((s) => s.id == widget.session.id, orElse: () => null);
          
          if (session != null) {
            return WillPopScope(
              onWillPop: () async {
                if (!_editing) {
                  return true;
                }

                if (_oldScores != null && !listEquals(_oldScores, session.scoreIds)) {
                  bool result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm"),
                        content: Text("Are you sure you want to discard the changes?"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text("Cancel", style: TextStyle(fontSize: 18.0),),
                          ),
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text("Discard", style: TextStyle(fontSize: 18.0),)
                          ),
                        ],
                      );
                    },
                  );

                  if (result) {
                    BlocProvider.of<SessionBloc>(context).add(RefreshSessionsEvent());
                    _oldScores = null;

                    setState(() => _editing = false);
                  }
                } else {
                  _oldScores = null;

                  setState(() => _editing = false);
                }

                return false;
              },
              child: Scaffold(
                appBar: ArrowLogAppBar(
                  title: session.name,
                  actions: session.state.status == SessionStatus.FINISHED ? [
                    if (!_editing)
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.shareAlt,
                          size: 20,
                        ),
                        onPressed: () => _share(context, session),
                      ),
                    if (_editing)
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.save,
                          size: 20,
                        ),
                        onPressed: () {
                          BlocProvider.of<SessionBloc>(context).add(SessionSetScoresEvent(
                            sessionId: session.id,
                            scoreIds: session.scoreIds,
                          ));
                          _oldScores = null;
                          setState(() => _editing = false);
                        },
                      )
                    else
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.pen,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() => _editing = true);
                        },
                      )
                  ] : null,
                ),
                body: _editing || session.state.status == SessionStatus.IN_PROGRESS ? _buildEditing(context, session, state.disableInput) : _buildReadOnly(session),
              ),
            );
          }
        }

        return Scaffold(
          appBar: ArrowLogAppBar(
            title: 'Loading...',
          ),
          body: Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }

  Future<void> _share(BuildContext context, Session session) {
    Size size = Size(
      276 + (session.matchType.arrowsPerRound > 3 ? session.matchType.arrowsPerRound : 3) * 36.0,
      334 + session.matchType.rounds * 36.0
    );

    return ShareUtil.shareWidget(
      ArrowLogSessionShare(session: session,),
      imageSize: size * 3,
      logicalSize: size
    );
  }

  Widget _buildEditing(BuildContext context, Session session, bool disabled) {
    return Column(
      children: [
        Expanded(
          child: ArrowLogListView(
            children: <Widget>[
              ArrowLogScoreSheet(
                session: session,
                selectedIndex: _selected,
                onSelect: (i) {
                  if (disabled) {
                    return;
                  }

                  setState(() => _selected = i);
                }
              )
            ],
          ),
        ),
        if (_selected != null)
          SafeArea(
            top: false,
            left: false,
            right: false,
            child: _buildScoreButtons(context, session, disabled),
          )
      ],
    );
  }

  Widget _buildScoreButtons(BuildContext context, Session session, bool disabled) {
    return ArrowLogScoreInsert(
      targetFace: session.matchType.targetFace,
      onSelect: disabled ? null : (id) {
        if (session.state.status == SessionStatus.FINISHED && _oldScores == null) {
          _oldScores = List.of(session.scoreIds);
        }

        session.scoreIds[_selected] = id;

        BlocProvider.of<SessionBloc>(context).add(SessionSetScoresEvent(
          sessionId: session.id,
          scoreIds: session.scoreIds,
          saveChanges: session.state.status == SessionStatus.IN_PROGRESS
        ));

        setState(() {
          _selected++;

          if (_selected >= session.scoreIds.length) {
            _selected = null;
          }
        });
      },
    );
  }

  Widget _buildReadOnly(Session session) {
    return Scaffold(
      body: ArrowLogListView(
        children: <Widget>[
          ArrowLogCard(
            alignment: CrossAxisAlignment.start,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ArrowLogInfoBlock(
                  fontSize: 18.0,
                  header: 'Distance',
                  value: '${session.matchType.distance}m',
                ),
                ArrowLogInfoBlock(
                  fontSize: 18.0,
                  header: 'Arrows',
                  value: '${session.matchType.arrowsPerRound * session.matchType.rounds}',
                ),
                ArrowLogInfoBlock(
                  fontSize: 18.0,
                  header: 'Target',
                  value: '${session.matchType.targetFace.name}',
                ),
              ],
            ),
          ),
          ArrowLogScoreSheet(
            session: session,
          )
        ],
      ),
    );
  }
}