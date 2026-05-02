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
    required this.status,
    required this.statusColor,
    required this.statusLabel,
  });

  final num budgetPerDay;
  final num actualPerDay;
  final String status;
  final String statusLabel;
  final String statusColor;
}

class DailyInsightError extends DailyInsightSelector {
  const DailyInsightError({required this.message});

  final String message;
}
