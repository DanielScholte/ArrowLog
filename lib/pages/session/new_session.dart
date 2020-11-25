import 'package:arrow_log/blocs/match_type/matchtype_bloc.dart';
import 'package:arrow_log/blocs/session/session_bloc.dart';
import 'package:arrow_log/models/session/session.dart';
import 'package:arrow_log/pages/match_types/overview.dart';
import 'package:arrow_log/widgets/appbar.dart';
import 'package:arrow_log/widgets/inline_button.dart';
import 'package:arrow_log/widgets/card.dart';
import 'package:arrow_log/widgets/input_date.dart';
import 'package:arrow_log/widgets/input_dropdown.dart';
import 'package:arrow_log/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewSessionPage extends StatefulWidget {
  @override
  _NewSessionPageState createState() => _NewSessionPageState();
}

class _NewSessionPageState extends State<NewSessionPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  int _matchTypeId;
  DateTime _when = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowLogAppBar(
        title: 'New Session',
      ),
      body: BlocListener<SessionBloc, SessionState>(
        listenWhen: (prev, curr) =>
          !(prev is LoadedSessionState) && curr is LoadedSessionState,
        listener: (context, state) => Navigator.of(context).pop(),
        child: BlocBuilder<SessionBloc, SessionState>(
          builder: (context, state) {
            if (state is LoadedSessionState) {
              return Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Container(height: 8.0,),
                    ArrowLogCard(
                      alignment: CrossAxisAlignment.start,
                      header: Text(
                        'Name',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white
                        ),
                      ),
                      child: ArrowLogInputText(
                        controller: _nameController,
                        type: 'name',
                      ),
                    ),
                    ArrowLogCard(
                      alignment: CrossAxisAlignment.start,
                      header: Text(
                        'When',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white
                        ),
                      ),
                      child: ArrowLogInputDate(
                        date: _when,
                        onDateChanged: (date) => setState(() => _when = date),
                      )
                    ),
                    BlocBuilder<MatchtypeBloc, MatchtypeState>(
                      builder: (context, matchTypeState) {
                        return ArrowLogCard(
                          paddingHeader: EdgeInsets.symmetric(horizontal: 4.0),
                          header: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                                  child: Text(
                                    'Match type',
                                    style: Theme.of(context).textTheme.headline2.copyWith(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                              ArrowLogInlineButton(
                                text: 'Manage types',
                                width: 175.0,
                                textSize: 18.0,
                                margin: EdgeInsets.zero,
                                color: Colors.white,
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MatchTypeOverviewPage()
                                )),
                              ),
                            ],
                          ),
                          child: Builder(
                            builder: (context) {
                              if (matchTypeState is MatchTypesState) {
                                return ArrowLogInputDropdown(
                                  value: _matchTypeId,
                                  onValueChanged: (id) => setState(() => _matchTypeId = id),
                                  placeholder: matchTypeState.matchTypes.isNotEmpty ? 'Select a match type' : 'No match types found',
                                  options: matchTypeState.matchTypes
                                    .map((m) => ArrowLogInputDropdownOption(m.id, m.name))
                                    .toList(),
                                );
                              }

                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          ),
                        );
                      }
                    ),
                    ArrowLogInlineButton(
                      text: 'Start',
                      onTap: () {
                        if (_formKey.currentState.validate() && _matchTypeId != null) {
                          BlocProvider.of<SessionBloc>(context).add(StartNewSessionEvent(
                            session: Session(
                              name: _nameController.text,
                              when: _when,
                              matchTypeId: _matchTypeId,
                            ),
                          ));
                        }
                      },
                    )
                  ],
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
      ),
    );
  }
}