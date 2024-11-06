import 'dart:io';
import 'dart:math';

import '../path.dart';
import 'Character.dart';
import 'Monster.dart';
import 'SelectOption.dart';

class Game {
  Character character;
  List<Monster> monster_list;
  Monster? picked_monster;
  int defeated_monster;

  int turn = 0;
  bool autoMode = false;

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
    // 랜덤 몬스터 선택. 후의 전투로 monster_list 원본이 수정되지 않도록 copy.
    int randomIdx = Random().nextInt(monster_list.length);
    picked_monster = monster_list.elementAt(randomIdx).copy();

    // 중복선택 방지. 선택된 몬스터 대기열에서 제거.
    // monster_list.removeAt(randomIdx);

    // 몬스터 출력
    print("\n새로운 몬스터가 나타났습니다!");
    picked_monster!.showStatus();

    // 배틀 시작
    battle();
  }

  // 전투를 진행하는 메서드
  void battle() {
    var state = 0;

    // 전투 턴을 무한히 반복. 조건이 만족되면 break로 빠져나오기.
    while (state == 0) {
      // 턴 수 증가.
      turn++;
      // 3턴마다 방어력 증가.(3번째 턴이 지난 후, 4, 7, 10턴 등이 해당.)
      if (turn % 3 == 1 && turn > 3) {
        picked_monster!.defenceUP();
      }

      // 캐릭터 선공.
      // 길이가 길어 함수로 내보냄.
      if (autoMode) {
        character.attackMonster(picked_monster!);
      } else {
        characterTurn();
      }

      // 체력소진 확인
      if (picked_monster!.strength <= 0) {
        state = 1;
        break;
      }

      // 몬스터 후공
      print("\n- ${picked_monster!.name}의 턴 -\n");
      picked_monster!.attackCharacter(character);

      // 체력소진 확인
      if (character.strength <= 0) {
        state = 2;
        break;
      }
    }

    // 전투 종료 후 state 인덱스별로 다른 코드 실행.
    if (state == 1) {
      // 몬스터 체력 소진. 턴 수 초기화.
      defeated_monster++;
      turn = 0;

      if (autoMode) {
        print("\n${picked_monster!.name}을 물리쳤습니다! 다음 몬스터를 불러옵니다.");
        // NOTE: 캐릭터가 너무 강해져서 전투가 끝나지 않음.
        // character.levelUp();
        getRandomMonster();
      } else {
        selectOne(
            "${picked_monster!.name}을(를) 물리쳤습니다!\n다음 몬스터와 싸우겠습니까? (y/n)", [
          Selectoption("y", () {
            character.levelUp();
            getRandomMonster();
          }),
          Selectoption("n", () => finishGame(0))
        ]);
      }
    }
    if (state == 2) {
      // 캐릭터 체력이 소진되어 게임 종료.
      finishGame(1);
    }
  }

  // 게임을 종료하는 메서드
  void finishGame(int i) {
    selectOne("게임 결과를 저장하시겠습니까? (y/n)", [
      Selectoption("y", () {
        String result =
            "${character.name} - 남은 체력: ${character.strength}, 게임 결과: ${i == 1 ? "패배" : "승리"}, 쓰러트린 몬스터 수: ${defeated_monster}";

        File file = File(result_txt);
        file.writeAsStringSync(result);

        print("저장되었습니다.");
      }),
      Selectoption("n", () => print("게임 결과를 저장하지 않습니다."))
    ]);
  }

  // 캐릭터의 턴을 진행.
  void characterTurn() {
    print("\n- ${character.name}의 턴 -");

    var desc =
        "행동을 선택하세요 (0: ${autoMode ? "자동진행 끄기" : "자동진행 켜기"}, 1: 공격, 2: 방어)";
    var selectOptions = [
      Selectoption("0", () => autoPlay()),
      Selectoption("1", () => character.attackMonster(picked_monster!)),
      Selectoption("2", () => character.defend())
    ];

    // 아이템을 선택하는 선택지. 선택 후 공격/방어 행동 재선택.
    var selectItem = Selectoption("3", () {
      character.useItem();
      selectOne(desc, selectOptions);
    });

    // 아이템을 사용한 경우 selectItem 선택지를 제외하고 selectOne 함수 실행.
    if (character.usedItem) {
      selectOne(desc, selectOptions);
    } else {
      var copyOptions = [...selectOptions];
      copyOptions.add(selectItem);
      selectOne(
          "행동을 선택하세요 (0: ${autoMode ? "자동진행 끄기" : "자동진행 켜기"}, 1: 공격, 2: 방어, 3: 아이템 사용)",
          copyOptions);
    }
  }

  // 자동전투 시작 메서드
  void autoPlay() {
    print("자동전투를 시작합니다.");
    autoMode = true;
    character.attackMonster(picked_monster!);
  }
}

// 선택지 입력 및 행동 진행 함수.
// 공통되는 코드가 많아 함수화 진행.
void selectOne(String desc, List<Selectoption> selectOptions) {
  print("\n" + desc);
  var userInput = stdin.readLineSync();

  bool validInput = false;

  // 선택지에 맞는 output 실행.
  selectOptions.forEach((option) {
    if (userInput == option.input) {
      option.output();
      validInput = true;
      return;
    }
  });

  // 재귀함수로 재입력 진행.
  if (!validInput) {
    print("잘못된 입력입니다. 다시 입력해주세요.");
    selectOne(desc, selectOptions);
  }
}
