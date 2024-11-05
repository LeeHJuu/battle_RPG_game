import 'dart:io';

import 'model/Character.dart';
import 'model/Game.dart';
import 'model/Monster.dart';
import 'path.dart';

void main(List < String > args) {
    // 캐릭터 이름 설정, 스탯 읽어오기 등 설정.
    Character character = load_character_stats();
    character.getBonusHP();

    // 몬스터 불러오기
    List<Monster> monster_list = load_monster_stats();

    // 게임 초기화
    Game game = Game(character, monster_list, 0);

    game.startGame();
}


// TODO: 파일 읽기 비동기 처리
// 몬스터 스탯 읽어와 생성하는 메서드
List<Monster> load_monster_stats() {
    List<Monster> monster_list = [];

    // 몬스터 스탯 로드
    final file = File(monsters_txt);
    final content = file.readAsStringSync();

    content
        .split("\n")
        .forEach((e) {
            var stats = e.split(',');
            monster_list.add(Monster(
                stats.elementAt(0),
                int.parse(stats.elementAt(1)),
                int.parse(stats.elementAt(2))
            ));
        });
    return monster_list;
}

// TODO: 파일 읽기 비동기 처리
// 캐릭터 스탯 읽어와 생성하는 메서드
Character load_character_stats() {
    // 캐릭터 스탯 로드
    final file = File(characters_txt);
    final content = file.readAsStringSync();
    final stats = content
        .split(',')
        .map((e) => int.parse(e));

    // 캐릭터 이름 입력
    var name = inputName();

    return Character(
        name,
        stats.elementAt(0),
        stats.elementAt(1),
        stats.elementAt(2)
    );
}

// 캐릭터 이름 입력, 정규표현식에 따라 이름을 제한하는 메서드.
String inputName(){
    var pass = false;
    RegExp regex = RegExp(r'^[a-zA-Z가-힣]+$');
    var name = "";

    print("캐릭터 이름을 입력해주세요.");
    
    while(!pass) {
        var input = stdin.readLineSync();

        if(regex.hasMatch(input!)){
            name = input;
            pass = true;
        } else {
            print("잘못된 입력입니다. 특수문자나 숫자를 허용하지 않습니다.");
        }
    }
    
    return name;
}
