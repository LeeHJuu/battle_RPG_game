import 'dart:math';

import 'Character.dart';
import 'Monster.dart';

class Game {
  Character character;
  List<Monster> monster_list;
  int defeated_monster;

  Game(this.character, this.monster_list, this.defeated_monster);

  @override
  String toString() {
    return 'Game{character: $character, monsterList: $monster_list, defeatedMonster: $defeated_monster}';
  }

  // 게임을 시작하는 메서드
  void startGame() {
    print("게임을 시작합니다!");
    character.showStatus();

    // 몬스터 소환
    getRandomMonster();
  }

  // 전투를 진행하는 메서드
  void battle() {
    // 캐릭터 선공
    // 몬스터 체력이 남아있으면 몬스터 후공, 체력이 소진되면 전투 종료.

    // 몬스터 후공
    // 캐릭터 체력이 남으면 전투 지속, 체력이 소진되면 전투 종료.
  }

  // 랜덤으로 몬스터를 불러오는 메서드
  void getRandomMonster() {
    // 랜덤 몬스터 선택
    int randomIdx = Random().nextInt(monster_list.length);
    Monster picked_monster = monster_list.elementAt(randomIdx);

    // 중복선택 방지. 선택된 몬스터 대기열에서 제거.
    monster_list.removeAt(randomIdx);

    // 몬스터 출력
    print("새로운 몬스터가 나타났습니다!");
    picked_monster.showStatus();
  }
}
