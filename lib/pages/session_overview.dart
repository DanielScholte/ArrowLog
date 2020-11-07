import 'package:arrow_log/blocs/session/session_bloc.dart';
import 'package:arrow_log/models/session/session.dart';
import 'package:arrow_log/pages/about.dart';
import 'package:arrow_log/pages/session/new_session.dart';
import 'package:arrow_log/pages/session/session.dart';
import 'package:arrow_log/widgets/appbar.dart';
import 'package:arrow_log/widgets/dismissible_button.dart';
import 'package:arrow_log/widgets/info_block.dart';
import 'package:arrow_log/widgets/list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class SessionOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowLogAppBar(
        title: null,
        displayLogo: true,
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.infoCircle
            ),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AboutPage()
            )),
          )
        ],
      ),
      body: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          if (state is LoadedSessionState) {
            List<Session> sessions = state.sessions;

            if (sessions.isEmpty) {
              return Center(
                child: Text(
                  'No sessions found',
                  style: Theme.of(context).textTheme.headline1,
                ),
              );
            }

            return ArrowLogListView(
              children: sessions
                .map((s) => _buildSessionCard(context, s))
                .toList(),
            );
          }
          
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NewSessionPage()
        )),
        label: Text(
          'New session'
        ),
        icon: Icon(
          FontAwesomeIcons.plus,
          size: 20.0,
        ),
      ),
    );
  }

  Widget _buildSessionCard(BuildContext context, Session session) {
    return ArrowLogDismissibleButton(
      key: ValueKey(session.id),
      name: 'Session',
      value: session.name,
      onRename: (name) => BlocProvider.of<SessionBloc>(context).add(RenameSessionEvent(sessionId: session.id, name: name)),
      onDelete: () => BlocProvider.of<SessionBloc>(context).add(DeleteSessionEvent(sessionId: session.id)),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SessionPage(session: session,)
      )),
      child: Column(
        children: [
          if (session.state.status == SessionStatus.IN_PROGRESS)
            Text(
              'In-progress',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.white
              ),
            ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      session.name,
                      style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Colors.white
                      ),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(session.when),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
              ArrowLogInfoBlock(
                fontSize: 18,
                secondaryFontSize: 16,
                value: '${session.state.currentScrore}',
                header: '${session.state.maxScore}',
              ),
              Icon(
                FontAwesomeIcons.chevronRight,
                color: Colors.white,
                size: 18.0,
              )
            ],
          ),
        ],
      ),
    );
  }
}