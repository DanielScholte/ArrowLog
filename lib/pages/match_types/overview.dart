import 'package:arrow_log/blocs/match_type/matchtype_bloc.dart';
import 'package:arrow_log/models/match_type/match_type.dart';
import 'package:arrow_log/widgets/appbar.dart';
import 'package:arrow_log/widgets/dismissible_button.dart';
import 'package:arrow_log/widgets/info_block.dart';
import 'package:arrow_log/widgets/list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'new_match_type.dart';

class MatchTypeOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowLogAppBar(
        title: 'Match types',
      ),
      body: BlocBuilder<MatchtypeBloc, MatchtypeState>(
        builder: (context, state) {
          if (state is MatchTypesState) {
            final List<MatchType> matchTypes = state.matchTypes;

            if (matchTypes.isEmpty) {
              return Center(
                child: Text(
                  'No match types found',
                  style: Theme.of(context).textTheme.headline1,
                ),
              );
            }

            return ArrowLogListView(
              children: matchTypes
                .map((m) => getMatchTypeCard(context, m))
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
          builder: (context) => NewMatchTypePage()
        )),
        label: Text(
          'New match type'
        ),
        icon: Icon(
          FontAwesomeIcons.plus,
          size: 20.0,
        ),
      )
    );
  }

  

  Widget getMatchTypeCard(BuildContext context, MatchType matchType) {
    return ArrowLogDismissibleButton(
      key: ValueKey(matchType.id),
      name: 'Match Type',
      value: matchType.name,
      onRename: (name) => BlocProvider.of<MatchtypeBloc>(context).add(RenameMatchTypeEvent(matchTypeId: matchType.id, name: name)),
      onDelete: () => BlocProvider.of<MatchtypeBloc>(context).add(DeleteMatchTypeEvent(matchType: matchType)),
      onTap: null,
      child: Column(
        children: <Widget>[
          Text(
            matchType.name,
            style: Theme.of(context).textTheme.headline2.copyWith(
              color: Colors.white
            ),
          ),
          Container(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ArrowLogInfoBlock(
                header: 'Distance',
                value: '${matchType.distance}m',
              ),
              ArrowLogInfoBlock(
                header: 'Arrows',
                value: '${matchType.arrowsPerRound * matchType.rounds}',
              ),
              ArrowLogInfoBlock(
                header: 'Target',
                value: '${matchType.targetFace.name}',
              ),
            ],
          ),
        ],
      )
    );
  }
}