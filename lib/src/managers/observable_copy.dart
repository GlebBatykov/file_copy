import '../copy_progress.dart';

class ObservableCopy {
  final Stream<CopyProgress> progressStream;

  final Future<void> onDone;

  ObservableCopy(this.progressStream, this.onDone);
}
