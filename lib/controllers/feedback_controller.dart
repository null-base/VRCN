import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/services/feedback_service.dart';

enum FeedbackSubmitStatus { success, invalidInput, failure }

@immutable
class FeedbackSubmitResult {
  const FeedbackSubmitResult(this.status, [this.error]);

  final FeedbackSubmitStatus status;
  final Object? error;
}

@immutable
class FeedbackSubmitRequest {
  const FeedbackSubmitRequest({
    required this.type,
    required this.title,
    required this.description,
  });

  final String type;
  final String title;
  final String description;
}

class FeedbackController {
  const FeedbackController(this.ref);

  final Ref ref;

  Future<FeedbackSubmitResult> submit(FeedbackSubmitRequest request) async {
    final title = request.title.trim();
    final description = request.description.trim();
    if (title.isEmpty || description.isEmpty) {
      return const FeedbackSubmitResult(FeedbackSubmitStatus.invalidInput);
    }

    try {
      final success = await ref
          .read(feedbackServiceProvider)
          .sendFeedback(
            type: request.type,
            title: title,
            description: description,
          );
      return FeedbackSubmitResult(
        success ? FeedbackSubmitStatus.success : FeedbackSubmitStatus.failure,
      );
    } catch (error) {
      return FeedbackSubmitResult(FeedbackSubmitStatus.failure, error);
    }
  }
}

final feedbackControllerProvider = Provider<FeedbackController>((ref) {
  return FeedbackController(ref);
});
