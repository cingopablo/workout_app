String formatTime({
  bool isPreview = false,
  Duration duration,
}) {
  String minutes = (duration.inMinutes).toString().padLeft(2, '0');
  String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

  if (isPreview) {
    if (minutes == '00') return '$seconds s';
    if (seconds == '00') return '$minutes min';
  }
  return '$minutes:$seconds';
}
