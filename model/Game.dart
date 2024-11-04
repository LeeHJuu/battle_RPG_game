import 'Character.dart';
import 'Monster.dart';

class Game {
  Character character;
  List<Monster> monster_list;
  int defeated_monster;

  Game(this.character, this.monster_list, this.defeated_monster);

  void startGame(){
    // 게임을 시작하는 메서드
  }

  void battle(){
    // 전투를 진행하는 메서드
  }

  void getRandomMonster(){
    // 랜덤으로 몬스터를 불러오는 메서드
  }
}