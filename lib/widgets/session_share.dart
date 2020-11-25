import 'package:arrow_log/models/session/session.dart';
import 'package:arrow_log/utils/theme.dart';
import 'package:arrow_log/widgets/card.dart';
import 'package:arrow_log/widgets/info_block.dart';
import 'package:arrow_log/widgets/score_sheet.dart';
import 'package:flutter/material.dart';

class ArrowLogSessionShare extends StatelessWidget {
  final Session session;

  ArrowLogSessionShare({
    @required this.session
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeUtil.lightTheme(),
      child: Builder(
        builder: (context) => Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              children: [
                ArrowLogCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        session.name,
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        session.matchType.name,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 16.0,
                          color: Colors.white70,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
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
                  interactiveHeader: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 24,
                        height: 24,
                      ),
                      Container(width: 4,),
                      Text(
                        'ArrowLog',
                        style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 18.0)
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}