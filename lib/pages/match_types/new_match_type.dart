import 'package:arrow_log/blocs/match_type/matchtype_bloc.dart';
import 'package:arrow_log/models/match_type/match_type.dart';
import 'package:arrow_log/models/match_type/target_face.dart';
import 'package:arrow_log/widgets/appbar.dart';
import 'package:arrow_log/widgets/inline_button.dart';
import 'package:arrow_log/widgets/card.dart';
import 'package:arrow_log/widgets/input_slider.dart';
import 'package:arrow_log/widgets/input_text.dart';
import 'package:arrow_log/widgets/list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewMatchTypePage extends StatefulWidget {
  @override
  _NewMatchTypePageState createState() => _NewMatchTypePageState();
}

class _NewMatchTypePageState extends State<NewMatchTypePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  int _distance = 18;
  int _arrows = 3;
  int _rounds = 10;
  int _target = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowLogAppBar(
        title: 'New Match Type',
      ),
      body: Form(
        key: _formKey,
        child: BlocBuilder<MatchtypeBloc, MatchtypeState>(
          builder: (context, state) {
            if (state is MatchTypesState) {
              final List<TargetFace> targetFaces = state.targetFaces;

              return Column(
                children: <Widget>[
                  Expanded(
                    child: ArrowLogListView(
                      enableSafeArea: false,
                      children: <Widget>[
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
                          padding: EdgeInsets.all(8.0),
                          header: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Distance',
                                    style: Theme.of(context).textTheme.headline2.copyWith(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                                Text(
                                  '${_distance}m',
                                  style: Theme.of(context).textTheme.headline2.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300
                                  ),
                                )
                              ],
                            ),
                          ),
                          child: ArrowLogInputSlider(
                            value: _distance.toDouble(),
                            onValueChanged: (value) => setState(() => _distance = value.toInt()),
                            min: 10,
                            max: 100,
                          ),
                        ),
                        ArrowLogCard(
                          padding: EdgeInsets.all(8.0),
                          header: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Arrows per round',
                                    style: Theme.of(context).textTheme.headline2.copyWith(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                                Text(
                                  '$_arrows',
                                  style: Theme.of(context).textTheme.headline2.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300
                                  ),
                                )
                              ],
                            ),
                          ),
                          child: ArrowLogInputSlider(
                            value: _arrows.toDouble(),
                            onValueChanged: (value) => setState(() => _arrows = value.toInt()),
                            min: 1,
                            max: 6,
                          ),
                        ),
                        ArrowLogCard(
                          padding: EdgeInsets.all(8.0),
                          header: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Rounds',
                                    style: Theme.of(context).textTheme.headline2.copyWith(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                                Text(
                                  '$_rounds',
                                  style: Theme.of(context).textTheme.headline2.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300
                                  ),
                                )
                              ],
                            ),
                          ),
                          child: ArrowLogInputSlider(
                            value: _rounds.toDouble(),
                            onValueChanged: (value) => setState(() => _rounds = value.toInt()),
                            min: 5,
                            max: 30,
                          ),
                        ),
                        ArrowLogCard(
                          header: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Target face',
                                  style: Theme.of(context).textTheme.headline2.copyWith(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                              Text(
                                '${targetFaces.firstWhere((f) => f.id == _target, orElse: () => TargetFace(name: '')).name}',
                                style: Theme.of(context).textTheme.headline2.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                                ),
                              )
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: 8.0),
                            height: 128.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: targetFaces
                                .map((f) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0
                                    ),
                                    color: _target == f.id ? Colors.white12 : Colors.transparent
                                  ),
                                  margin: EdgeInsets.only(
                                    left: targetFaces.first != f ? 4 : 0,
                                    right: targetFaces.last != f ? 4 : 0,
                                  ),
                                  width: 100.0,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => setState(() => _target = f.id),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            f.name,
                                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                                              color: Colors.white
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Image.asset(
                                            f.imageUrl,
                                            width: 72.0,
                                            height: 72.0,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                                .toList()
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      border: Border(
                        top: BorderSide(
                          color: Colors.white,
                          width: 2.0
                        )
                      )
                    ),
                    child: SafeArea(
                      top: false,
                      right: false,
                      left: false,
                      child: ArrowLogInlineButton(
                        text: 'Save',
                        color: Colors.white,
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            BlocProvider.of<MatchtypeBloc>(context).add(AddMatchTypeEvent(
                              matchType: MatchType(
                                name: _nameController.text,
                                distance: _distance,
                                arrowsPerRound: _arrows,
                                rounds: _rounds,
                                targetFaceId: _target,
                              ),
                            ));
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ),
                ],
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