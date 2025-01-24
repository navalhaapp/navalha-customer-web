import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../api/faq.dart';
import '../model/response_faq.dart';

final faqEndpointProvider = Provider((ref) {
  return FaqEndPoint();
});

final faqRepositoryProvider = Provider(
  (ref) => FaqRepository(
    faqEndPoint: ref.read(faqEndpointProvider),
  ),
);

final faqUseCase = Provider((ref) {
  return FaqUseCase(
    repository: ref.read(faqRepositoryProvider),
  );
});

final faqListProvider =
    FutureProvider.family<ResponseFaqModel, String>((ref, token) async {
  return ref.read(faqUseCase).execute(token);
});

enum FaqState { loggedOut, loading, loggedIn, error }

class FaqStateController extends StateNotifier<FaqState> {
  FaqStateController(
    this._read,
    this.pix,
  ) : super(FaqState.loggedOut);

  final Reader _read;
  ResponseFaqModel? pix;

  static final provider = StateNotifierProvider<FaqStateController, FaqState>(
    (ref) => FaqStateController(ref.read, null),
  );

  Future faqList(String token) async {
    pix = await _read(faqUseCase).execute(token);

    return pix!;
  }
}
