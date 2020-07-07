class Settings {
  bool nightMode;
  bool silentMode;
  String countdownPip;
  String startRep;
  String startRest;
  String startBreak;
  String startSet;
  String endWorkout;

  Settings({
    this.nightMode = false,
    this.silentMode = false,
    this.countdownPip = 'pip.mp3',
    this.startRep = 'boop.mp3',
    this.startRest = 'dingdingding.mp3',
    this.startBreak = 'dingdingding.mp3',
    this.startSet = 'boop.mp3',
    this.endWorkout = 'dingdingding.mp3',
  });
}
