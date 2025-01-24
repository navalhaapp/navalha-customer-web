import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/create_review.dart';

final createReviewEndpointProvider = Provider((ref) {
  return CreateReviewEndPoint();
});

final createReviewRepositoryProvider = Provider(
  (ref) => CreateReviewRepository(
    createReviewEndPoint: ref.read(createReviewEndpointProvider),
  ),
);

final createReviewUseCase = Provider((ref) {
  return CreateReviewUseCase(
    repository: ref.read(createReviewRepositoryProvider),
  );
});

enum CreateReviewState { loggedOut, loading, loggedIn, error }

class CreateReviewStateController extends StateNotifier<CreateReviewState> {
  CreateReviewStateController(
    this._read,
    this.review,
  ) : super(CreateReviewState.loggedOut);

  final Reader _read;
  var review;

  static final provider =
      StateNotifierProvider<CreateReviewStateController, CreateReviewState>(
    (ref) => CreateReviewStateController(ref.read, null),
  );

  Future createReview(
    String token,
    String? description,
    double rating,
    String serviceId,
    String customerId,
  ) async {
    review = await _read(createReviewUseCase).execute(
      token,
      description,
      rating,
      serviceId,
      customerId,
    );
    return review!;
  }
}
