import 'dart:io';
import 'dart:math';

import '../path.dart';
import 'Character.dart';
import 'Monster.dart';

class Game {
  Character character;
  List<Monster> monster_list;
  Monster? picked_monster;
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

  // 랜덤으로 몬스터를 불러오는 메서드
  void getRandomMonster() {
    // 랜덤 몬스터 선택
    int randomIdx = Random().nextInt(monster_list.length);
    picked_monster = monster_list.elementAt(randomIdx);

    // 중복선택 방지. 선택된 몬스터 대기열에서 제거.
    monster_list.removeAt(randomIdx);

    // 몬스터 출력
    print("새로운 몬스터가 나타났습니다!");
    picked_monster!.showStatus();

    // 배틀 시작
    battle();
  }

  // 전투를 진행하는 메서드
  void battle() {
    var state = 0;

    // 전투 턴을 무한히 반복. 조건이 만족되면 break로 빠져나오기.
    while (state == 0) {
      // 캐릭터 선공
      // TODO: 공격과 방어 중 선택하여 행동하도록.
      character.attackMonster(picked_monster!);

      if (picked_monster!.strength <= 0) {
        state = 1;
        break;
      }

      // 몬스터 후공
      picked_monster!.attackCharacter(character);

      if (character.strength <= 0) {
        state = 2;
        break;
      }
    }

    // 전투 종료 후 state 인덱스별로 다른 코드 실행.

    if (state == 1) {
      // 몬스터 체력 소진. 다음 전투를 치를 것인지 선택.
      print("${picked_monster!.name}을(를) 물리쳤습니다!\n다음 몬스터와 싸우겠습니까? (y/n)");
      var userInput = stdin.readLineSync();

      switch (userInput) {
        case "y":
          getRandomMonster();

        case "n":
          finishGame(0);

        default:
          print("잘못된 입력입니다.");
      }
    }
    if (state == 2) {
      // 캐릭터 체력이 소진되어 게임 종료.
      finishGame(1);
    }
  }

  // 게임을 종료하는 메서드
  void finishGame(int i) {
    print("게임 결과를 저장하시겠습니까? (y/n)");
    var userInput = stdin.readLineSync();

    switch (userInput) {
      case "y":
        String result =
            "${character.name} - 남은 체력: ${character.strength}, 게임 결과: ${i == 0 ? "패배" : "승리"}";

        File file = File(result_txt);
        file.writeAsStringSync(result);

        print("저장되었습니다.");

      case "n":
        print("저장안할게요.");

      default:
        print("잘못된 입력입니다.");
        finishGame(i);
    }
  }
}
