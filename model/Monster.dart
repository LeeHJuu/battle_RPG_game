import 'Character.dart';

class Monster {
  String name;
  int strength;
  int max_offense;
  int defence = 0;

  Monster(this.name, this.strength, this.max_offense);

  @override
  String toString() {
    return 'Monster{name: $name, strength: $strength, maxOffense: $max_offense, defence: $defence}';
  }

  void attackCharacter(Character character) {
    // 캐릭터를 공격.
    // 데미지 = 몬스터 공격력 - 캐릭터 방어력. 최소 0 이상.
  }

  void showStatus() {
    // 체력과 공격력 출력.
    print("${this.name} - 체력: ${this.strength}, 공격력: ${this.max_offense}");
  }
}
