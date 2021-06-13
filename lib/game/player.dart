import 'package:flame/components.dart';

class Player extends SpriteComponent {
  Player({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  Vector2 _moveDirection = Vector2.zero();
  final double _speed = 3;

  @override
  void update(double dt) {
    this.position += _moveDirection * dt * _speed;
    super.update(dt);
  }

  void setMoveDirection(Vector2 newMoveDirection) {
    this._moveDirection = newMoveDirection;
  }
}
