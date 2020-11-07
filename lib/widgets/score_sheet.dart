import 'package:arrow_log/models/match_type/target_face.dart';
import 'package:arrow_log/models/session/session.dart';
import 'package:arrow_log/widgets/inline_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'card.dart';

enum _ViewType {
  total,
  subtotal
}

class ArrowLogScoreSheet extends StatefulWidget {
  final Session session;
  final int selectedIndex;
  final Function(int) onSelect;
  final bool interactiveHeader;

  ArrowLogScoreSheet({
    @required this.session,
    this.interactiveHeader = true,
    this.selectedIndex,
    this.onSelect,
  });

  @override
  _ArrowLogScoreSheetState createState() => _ArrowLogScoreSheetState();
}

class _ArrowLogScoreSheetState extends State<ArrowLogScoreSheet> {
  _ViewType _viewType = _ViewType.subtotal;

  final double _interactiveEndWidth = 64;
  final double _passiveEndWidth = 80;

  @override
  void didUpdateWidget(ArrowLogScoreSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.session.id != oldWidget.session.id
      || !listEquals(widget.session.scoreIds, oldWidget.session.scoreIds)
      || widget.selectedIndex != oldWidget.selectedIndex) {
        setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    int rounds = widget.session.matchType.rounds;
    int arrows = widget.session.matchType.arrowsPerRound;

    return ArrowLogCard(
      paddingHeader: EdgeInsets.symmetric(horizontal: 4.0),
      header: _buildHeader(),
      child: Column(
        children: Iterable<int>.generate(rounds)
          .map((round) => Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: Iterable<int>.generate(arrows)
                    .map((arrow) => _buildScoreSlot(round * arrows + arrow))
                    .toList(),
                ),
              ),
              _buildSide(round),
            ],
          ))
          .toList(),
      ),
      footer: _buildFooter(),
    );
  }

  Widget _buildHeader() {
    if (widget.interactiveHeader) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, top: 12.0, bottom: 12.0),
              child: Text(
                'Arrows',
                style: Theme.of(context).textTheme.headline2.copyWith(
                  color: Colors.white
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ArrowLogInlineButton(
            text: _viewType == _ViewType.subtotal ? 'Total' : 'Running',
            margin: EdgeInsets.zero,
            width: _interactiveEndWidth + 16,
            textSize: 18.0,
            color: Colors.white,
            onTap: () {
              setState(() {
                _viewType = _viewType == _ViewType.subtotal ? _ViewType.total : _ViewType.subtotal;
              });
            },
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Arrows',
              style: Theme.of(context).textTheme.headline2.copyWith(
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: _passiveEndWidth,
            child: Text(
              'Total',
              style: Theme.of(context).textTheme.headline2.copyWith(
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: _passiveEndWidth,
            child: Text(
              'Running',
              style: Theme.of(context).textTheme.headline2.copyWith(
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSide(int round) {
    if (widget.interactiveHeader) {
      return Container(
        width: _interactiveEndWidth,
        child: _ArrowLogScoreSheetAnimatedValue(
          _viewType == _ViewType.subtotal ?
          widget.session.state.subTotalScoreSegments[round] :
          widget.session.state.totalScoreSegments[round]
        ),
      );
    }

    return Container(
      child: Row(
        children: [
          Container(
            width: _passiveEndWidth,
            child: Text(
              widget.session.state.subTotalScoreSegments[round].toString(),
              style: Theme.of(context).textTheme.headline2.copyWith(
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: _passiveEndWidth,
            child: Text(
              widget.session.state.totalScoreSegments[round].toString(),
              style: Theme.of(context).textTheme.headline2.copyWith(
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFooter() {
    if (widget.interactiveHeader) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'End score',
              style: Theme.of(context).textTheme.headline2.copyWith(
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: _interactiveEndWidth,
            child: _ArrowLogScoreSheetAnimatedValue(widget.session.state.currentScrore,),
          ),
        ],
      );
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'End score',
            style: Theme.of(context).textTheme.headline2.copyWith(
              color: Colors.white
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: _passiveEndWidth
        ),
        Container(
          width: _passiveEndWidth,
          child: _ArrowLogScoreSheetAnimatedValue(widget.session.state.currentScrore,),
        ),
      ],
    );
  }

  Widget _buildScoreSlot(int index) {
    TargetFaceScore score = widget.session.state.scores[index];

    return _ArrowLogScoreSheetScore(
      // key: ValueKey(index),
      score: score,
      onTap: () {
        if (widget.onSelect != null) {
          widget.onSelect(index);
        }
      },
      selected: widget.selectedIndex == index,
    );
  }
}

class _ArrowLogScoreSheetScore extends StatefulWidget {
  final TargetFaceScore score;
  final VoidCallback onTap;
  final bool selected;

  _ArrowLogScoreSheetScore({
    Key key,
    @required this.score,
    @required this.onTap,
    @required this.selected,
  }) : super(key: key);

  @override
  __ArrowLogScoreSheetScoreState createState() => __ArrowLogScoreSheetScoreState();
}

class __ArrowLogScoreSheetScoreState extends State<_ArrowLogScoreSheetScore> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
      value: 0,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut
    );

    if (widget.score != null) {
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_ArrowLogScoreSheetScore oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selected != oldWidget.selected || widget.score != oldWidget.score) {
      setState(() {});

      if (oldWidget.score == null && widget.score != null) {
        _controller.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        width: 32.0,
        height: 32.0,
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.0),
          color: Theme.of(context).cardColor,
          border: widget.score != null ? Border.all(
            color: widget.score.foregroundColor,
            width: widget.selected ? 2.0 : 1.0,
          ) : Border.all(
            color: Colors.white,
            width: widget.selected ? 2.0 : 0.0,
          ),
        ),
        child: ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90.0),
              color: widget.score != null ? widget.score.color : null,
            ),
            alignment: Alignment.center,
            child: Text(
              widget.score != null ? widget.score.label : '',
              style: Theme.of(context).textTheme.headline2.copyWith(
                color: widget.score != null ? widget.score.foregroundColor : Colors.black
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ArrowLogScoreSheetAnimatedValue extends StatefulWidget {
  final int value;

  _ArrowLogScoreSheetAnimatedValue(this.value,);

  @override
  __ArrowLogScoreSheetAnimatedValueState createState() => __ArrowLogScoreSheetAnimatedValueState();
}

class __ArrowLogScoreSheetAnimatedValueState extends State<_ArrowLogScoreSheetAnimatedValue> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _animation = new Tween<double>(
      begin: widget.value.toDouble(),
      end: widget.value.toDouble(),
    ).animate(new CurvedAnimation(
      curve: Curves.easeOut,
      parent: _controller,
    ));
    super.initState();
  }

  @override
  void didUpdateWidget(_ArrowLogScoreSheetAnimatedValue oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      setState(() {
        _animation = new Tween<double>(
          begin: _animation.value,
          end: widget.value.toDouble(),
        ).animate(new CurvedAnimation(
          curve: Curves.easeOut,
          parent: _controller,
        ));
      });
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        return new Text(
          _animation.value.toStringAsFixed(0),
          style: Theme.of(context).textTheme.headline2.copyWith(
            color: Colors.white
          ),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}