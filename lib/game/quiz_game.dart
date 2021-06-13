import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:quiz/game/player.dart';

class QuizGame extends BaseGame with PanDetector {
  late Player _player;
  Vector2? _pointerStartPosition;
  Vector2? _pointerCurrentPosition;
  final double _joystickRadius = 60;
  final double _stopZoneRadius = 10;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await images.load('character_zombie_sheet.png');
    final spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache('character_zombie_sheet.png'),
      columns: 9,
      rows: 5,
    );
    _player = Player(
      sprite: spriteSheet.getSprite(3, 8),
      position: viewport.canvasSize / 2,
      size: Vector2(100, 150),
    );
    _player.anchor = Anchor.center;
    add(_player);
  }

  @override
  void render(Canvas canvas) {
    if (_pointerStartPosition != null) {
      canvas.drawCircle(
        _pointerStartPosition!.toOffset(),
        60,
        Paint()..color = Colors.grey.withAlpha(100),
      );
    }

    if (_pointerCurrentPosition != null) {
      Vector2 delta = _pointerCurrentPosition! - _pointerStartPosition!;
      if (delta.length > _joystickRadius) {
        delta = _pointerStartPosition! + (delta.normalized() * _joystickRadius);
      } else {
        delta = _pointerCurrentPosition!;
      }
      canvas.drawCircle(
        delta.toOffset(),
        15,
        Paint()..color = Colors.grey.withAlpha(100),
      );
    }
    super.render(canvas);
  }

  @override
  void onPanStart(DragStartInfo info) {
    _pointerStartPosition = info.eventPosition.global;
    _pointerCurrentPosition = info.eventPosition.global;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    _pointerCurrentPosition = info.eventPosition.global;
    final delta = _pointerCurrentPosition! - _pointerStartPosition!;
    if (delta.length > _stopZoneRadius) {
      _player.setMoveDirection(delta);
    } else {
      _player.setMoveDirection(Vector2.zero());
    }
  }

  @override
  void onPanEnd(DragEndInfo info) {
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    _player.setMoveDirection(Vector2.zero());
  }

  @override
  void onPanCancel() {
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    _player.setMoveDirection(Vector2.zero());
  }
}
