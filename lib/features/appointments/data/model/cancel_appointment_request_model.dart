class CancelAppointmentRequestModel {
  final int cancellationReason;
  final String otherReason;
  final String cancelledBy;

  CancelAppointmentRequestModel({
    required this.cancellationReason,
    required this.otherReason,
    required this.cancelledBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'cancellation_reason': cancellationReason,
      'other_reason': otherReason,
      'cancelled_by': cancelledBy,
    };
  }
}
