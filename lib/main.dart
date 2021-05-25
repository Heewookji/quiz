import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:quiz/game/zombie_escape_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(GameWidget(game: ZombieEscapeGame()));
}
