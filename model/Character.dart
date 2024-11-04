import 'Monster.dart';

class Character {
  String name;
  int strength;
  int offense;
  int defence;

  Character(this.name, this.strength, this.offense, this.defence);

  void attackMonster(Monster monster) {
    // 몬스터 공격
  }

  void defend() {
    // 방어 시 특정 행동을 수행
  }

  void showStatus() {
    // 캐릭터의 현재 체력, 공격력, 방어력 출력
    print("${this.name} - 체력: ${this.strength}, 공격력: ${this.offense}, 방어력: ${this.defence}");
  }
}
