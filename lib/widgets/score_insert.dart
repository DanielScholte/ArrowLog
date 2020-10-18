import 'package:arrow_log/models/match_type/target_face.dart';
import 'package:arrow_log/widgets/card.dart';
import 'package:flutter/material.dart';

class ArrowLogScoreInsert extends StatelessWidget {
  final TargetFace targetFace;
  final Function(int) onSelect;

  ArrowLogScoreInsert({
    @required this.targetFace,
    @required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ArrowLogCard(
      header: Text(
        'Scores',
        style:   Theme.of(context).textTheme.headline2.copyWith(
          color: Colors.white
        ),
        textAlign: TextAlign.center,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: targetFace.scores
          .map((s) => Container(
            width: 42.0,
            height: 42.0,
            margin: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90.0),
              color: s.color,
              border: Border.all(
                color: s.foregroundColor,
                width: 2.0
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onSelect != null ? () => onSelect(s.id) : null,
                borderRadius: BorderRadius.circular(90.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    s.label,
                    style: TextStyle(
                      color: s.foregroundColor,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ),
          ))
          .toList(),
      ),
    );
  }
}