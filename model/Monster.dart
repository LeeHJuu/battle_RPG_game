import 'dart:math';

import 'Character.dart';

class Monster {
  String name;
  int strength;
  int max_offense;
  int defence = 0;

  Monster(this.name, this.strength, this.max_offense);

  // 랜덤 몬스터 선택 시, 후의 전투로 monster_list 원본이 수정되지 않도록 copy.
  Monster copy(){
    return Monster(this.name, this.strength, this.max_offense);
  }

  @override
  String toString() {
    return 'Monster{name: $name, strength: $strength, maxOffense: $max_offense, defence: $defence}';
  }

  void attackCharacter(Character character) {
    // 캐릭터를 공격.
    // 데미지 = 몬스터 공격력 - 캐릭터 방어력. 최소 0 이상.
    int damage = Random().nextInt(max_offense) - character.defence;
    damage = damage > 0 ? damage : 0;

    // 캐릭터 방어 선택시 데미지 감소
    if(character.mode == 1){
      damage ~/= 10;
      character.mode = 0;
    }
    
    character.strength -= damage;

    print("$name이(가) ${character.name}에게 $damage의 데미지를 입혔습니다.");
    character.showStatus();
  }

  void showStatus() {
    // 체력과 공격력 출력.
    print("${name} - 체력: ${strength}, 공격력: ${max_offense}");
  }

  void defenceUP(){
    defence += 2;
    print("$name의 방어력이 증가했습니다! 현재 방어력: $defence");
  }
}
