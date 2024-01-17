part of 'recommend_imports.dart';

class BudgetSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: BlocBuilder<RecommendationCubit, RecommendationState>(
        builder: (context, state) => SliderTheme(
          data: SliderThemeData(
            thumbColor: Colors.blue.shade900,
            inactiveTrackColor: Colors.blue.shade200,
            activeTrackColor: Colors.blue.shade900,
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 10,
              elevation: 5,
            ),
            valueIndicatorTextStyle: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.white),
            // showValueIndicator: ShowValueIndicator.always,
            valueIndicatorColor: Colors.blue.shade900,
            activeTickMarkColor: Colors.blue.shade900,
          ),
          child: Slider(
            value:
                context.watch<RecommendationCubit>().budget.round().toDouble(),
            label: numberConverter(
                context.read<RecommendationCubit>().budget.round().toString()),
            min: 20000,
            max: 10000000,
            onChanged: (val) {
              context.read<RecommendationCubit>().changeBudget(val);
            },
          ),
        ),
      ),
    );
  }
}
