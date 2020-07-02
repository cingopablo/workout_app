import 'package:flutter/material.dart';

import '../models/timer_painter.dart';

class CountdownCircle extends StatefulWidget {
  final int workMinutes;
  final int workSeconds;
  final int restMinutes;
  final int restSeconds;
  final int repetitions;
  final bool isPlaying;
  final Function setPlaying;

  CountdownCircle({
    @required this.workMinutes,
    @required this.workSeconds,
    @required this.restMinutes,
    @required this.restSeconds,
    @required this.repetitions,
    @required this.isPlaying,
    @required this.setPlaying,
  });

  @override
  _CountdownCircleState createState() => _CountdownCircleState();
}

class _CountdownCircleState extends State<CountdownCircle>
    with TickerProviderStateMixin {
  AnimationController _controller;

  String get timerString {
    Duration duration = _controller.duration * _controller.value;
    String minutes = _controller.value == 0.0
        ? (_controller.duration.inMinutes % 60).toString().padLeft(2, '0')
        : (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = _controller.value == 0.0
        ? (_controller.duration.inSeconds % 60).toString().padLeft(2, '0')
        : (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  void didUpdateWidget(CountdownCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isPlaying) return _controller.stop();
    if (widget.isPlaying) {
      _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value,
      );
    }
    if (_controller.value == 0.0) widget.setPlaying(false);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        minutes: widget.workMinutes,
        seconds: widget.workSeconds,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_controller.value);
    return Container(
      height: 250,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (ctx, child) => CustomPaint(
                            painter: TimerPainter(
                              animation: _controller,
                              backgroundColor:
                                  Theme.of(context).primaryColorLight,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: FractionalOffset.center,
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (ctx, child) => Text(
                              timerString,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
