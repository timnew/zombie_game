Zombie Game Judge
=================

Zombie Game is a turn-based party game, large group of people to play together.

## Rule

Players are divided into 2 groups, most of them are `humans`, small portion of them are `zombies`. 

When game begins: 
  * Judge tells each player his/her identity, a human or a zombie.
  * Judge announce, the number of zombies and humans.

Each turn, players interact with others:
  * One player can interact with another player once in a turn
  * One player can interact with several players in a turn

If 
  * **Human** player interacts with **human** player, both of them get 1 score!
  * **Human** player interacts with **zombie**, **human** player got **temporaryly infected**, **zombie** player get 1 **score**!
  * **Temporary infected** player turns into a **permanent infected** player after **3 turns**! And whose **scores** are **cleared**!
  * **Temporary infected** player can **cure** himself/herself by appling **anitdote**. **Every** player, including the zombies has 1 antidote when game started. **Temporary infected** becomes **human** again after used the **antidote**, the **antidote** can be used **only once**!
  * Antidote has **no effect** if applied to **human** player, **permanent infected** player, or **zombie**, but the antidote is **still consumed**.
  * **Human player** interacts with infected player, either **temporary** or **permanent** one, human player get infected too.
  * **Permanent Infected** player get 1 sccore when he/she successfully infected a human player.
  * **Temporary Infected** player doesn't score, even he/she infected a human player.
  * Players are **not** informed whether he/she is infected or not.
  * (Optional) One player can give his/her antidote to another player.
  
When the turn ends, Judge will announce:
  * The number of human and zombies, **infected** players (both temporary and permanent) will be counts as **zombie**.
  * The **score** (Not name) of the human and zombie player who got the highest scores.

The game ends, when:
  * **All players** are turned into Zombies by **the end of the turn**, **zombie** wins. The zombie players and permanent infected players are ranked by their scores!
  * **Only 1 human** player survives by ** the end of the turn**, **human** wins. The survivor wins.
  * Game reaches the maximum turns, **human** wins. The human players are ranked by their scores.
  
### A tricky, but important case:

1. `A` is a **human** player.
2. In one turn, `A` is touch by a **Zombie** player, so `A` is **temporarly infected**.
3. After that, in the **same turn**, `A` touches another **human** player `B`, so `B` is **temporarly infected**.
4. Then, still in the **same turn**, `A` consumes an **antidote**, so `A` is **cured**, and changed to **human** again.
5. At the same time, `B` is still **temporarly infected**.
6. 3 turns later, `B` is **permanent infected** and lost all scores.

## How to use the code

### Install
```
$ git clone https://github.com/timnew/zombie_game.git
$ cd zombie_game
$ bundle install
```

### Configure the game

Game has a configure file(`config.yml` by default), which includes the player names, and the number of zombie players, and maximum turns for a game. Edit the file according to your case. Then execute following command:

```
$ rake new_game
```

It generates `game.txt`, which is the script describes what happens in the game.

### Record the game
Record what happened in the game into `game.txt`

* `INTERACT a b` means player `A` interacts `B`
* `ANTIDOTE a` means player `A` applied antidote to himself/herself
* `NEXT_TURN` means the end of the turn.

Each command has short acronym, some of them has alais:
* Interacts: `INTERACT`, `TOUCH`, `i`, `t`
* Antidote: `ANTIDOTE`, `a`
* Next Turn: `NEXT_TURN`, `NEXT_ROUND`, `nt`, `nr`

### Run the game
After update the `game.txt`, run the rake task, which will run the script, and generates result
```
$ rake run
```
Or
```
$ rake
```

### Watch script change
If you want the simualtion run automatically after script changed, use following script
```
$ guard
```
