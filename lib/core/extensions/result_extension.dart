import 'package:network_demo/_features.dart';

extension ResultExt<T> on Result<T> {
  bool get isError {
    return when<bool>(
      data: (_) => false,
      error: (_) => true,
    );
  }

  T? get dataOrNull => whenOrNull<T?>(data: (value) => value);

  Exception? get exceptionOrNull {
    return whenOrNull<Exception>(error: (exception) => exception);
  }
}
