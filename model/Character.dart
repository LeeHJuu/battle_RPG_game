import 'dart:math';

import 'Monster.dart';

class Character {
  String name;
  int strength;
  int offense;
  int defence;

  int mode = 0; // 0: 기본, 1: 방어모드, 2: 아이템 사용
  bool usedItem = false; // 아이템 소진 여부

  Character(this.name, this.strength, this.offense, this.defence);

  @override
  String toString() {
    return 'Character{name: $name, strength: $strength, offense: $offense, defence: $defence}';
  }

  void getBonusHP() {
    int random = Random().nextInt(10);

    if (random < 3) {
      strength += 10;
      print('보너스 체력을 얻었습니다! 현재 체력: ${strength}');
    }
  }

  void useItem(){
    print("아이템을 사용했습니다. 이번 턴에서의 공격력이 2배가 됩니다.");
    mode = 2;
    usedItem = true;
  }

  void attackMonster(Monster monster) {
    // 몬스터 공격
    int damage = offense - monster.defence;
    damage = damage > 0 ? damage : 0;

    // 아이템 사용 확인
    if(mode == 2){
      damage *= 2;
      print("강력한 공격을 행합니다.");
    }
    
    monster.strength -= damage;

    print("$name이(가) ${monster.name}에게 $damage의 데미지를 입혔습니다.");
    monster.showStatus();
  }

  void defend() {
    // 방어 시 해당 턴에서 받는 데미지 대폭 감소.
    mode = 1;
    print("방어 태세를 취합니다. 이번 공격에서 받는 데미지가 감소합니다.");
  }

  void showStatus() {
    // 캐릭터의 현재 체력, 공격력, 방어력 출력
    print("${name} - 체력: ${strength}, 공격력: ${offense}, 방어력: ${defence}");
  }
}
