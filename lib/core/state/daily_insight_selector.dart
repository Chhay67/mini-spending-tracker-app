abstract class DailyInsightSelector {
  const DailyInsightSelector();
}

class DailyInsightInitial extends DailyInsightSelector {
  const DailyInsightInitial();
}

class DailyInsightLoading extends DailyInsightSelector {
  const DailyInsightLoading();
}

class DailyInsightLoaded extends DailyInsightSelector {
  const DailyInsightLoaded({
    required this.budgetPerDay,
    required this.actualPerDay,
    this.status,
  });

  final num budgetPerDay;
  final num actualPerDay;
  final String? status;
}

class DailyInsightError extends DailyInsightSelector {
  const DailyInsightError({required this.message});

  final String message;
}
