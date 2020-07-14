String formatTime({
  bool isPreview = false,
  Duration duration,
}) {
  String minutes = (duration.inMinutes).toString().padLeft(2, '0');
  String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

  if (isPreview) {
    if (duration.inSeconds > 0) {
      return '${duration.inMinutes + 1} Min.';
    }
  }

  return '$minutes:$seconds';
}
