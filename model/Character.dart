import 'Monster.dart';

class Character {
  String name;
  int strength;
  int offense;
  int defence;

  Character(this.name, this.strength, this.offense, this.defence);

  @override
  String toString() {
    return 'Character{name: $name, strength: $strength, offense: $offense, defence: $defence}';
  }

  void attackMonster(Monster monster) {
    // 몬스터 공격
  }

  void defend() {
    // 방어 시 특정 행동을 수행
  }

  void showStatus() {
    // 캐릭터의 현재 체력, 공격력, 방어력 출력
    print("${name} - 체력: ${strength}, 공격력: ${offense}, 방어력: ${defence}");
  }
}
