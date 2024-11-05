import 'dart:math';

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

  void getBonusHP() {
    int random = Random().nextInt(10);

    if (random > 3) {
      strength += 10;
      print('보너스 체력을 얻었습니다! 현재 체력: ${strength}');
    }
  }

  void attackMonster(Monster monster) {
    // 몬스터 공격
    int damage = offense;
    monster.strength -= damage;

    print("$name이(가) ${monster.name}에게 $damage의 데미지를 입혔습니다.");
    monster.showStatus();
  }

  void defend() {
    // TODO: 방어 시 특정 행동을 수행
  }

  void showStatus() {
    // 캐릭터의 현재 체력, 공격력, 방어력 출력
    print("${name} - 체력: ${strength}, 공격력: ${offense}, 방어력: ${defence}");
  }
}
