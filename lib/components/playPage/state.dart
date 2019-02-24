import 'package:dva_dart/dva_dart.dart';

/// you should write your state with DvaState
/// for this version, you have to implements it
/// nothing more to say, this `PlayerState` is really simple.
class PlayerState implements DvaState {
  final bool isInitial;
  final bool isPlaying;
  final bool isPaused;
  final bool isStopped;
  final String status;

  PlayerState.initial(
      {this.isInitial = true,
      this.isPlaying = false,
      this.isPaused = false,
      this.isStopped = false,
      this.status = 'Ready'});

  PlayerState.playing(
      {this.isInitial = false,
      this.isPlaying = true,
      this.isPaused = false,
      this.isStopped = false,
      this.status = 'Playing'});

  PlayerState.paused(
      {this.isInitial = false,
      this.isPlaying = false,
      this.isPaused = true,
      this.isStopped = false,
      this.status = 'Paused'});

  PlayerState.stopped(
      {this.isInitial = false,
      this.isPlaying = false,
      this.isPaused = false,
      this.isStopped = true,
      this.status = 'Stopped'});
}
