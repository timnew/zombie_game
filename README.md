Zombie Game Judge
=================

Zombie Game is a turn-based party game, large group of people to play together.

## Rule

Players are divided into 2 groups, most of them are `humans`, small portion of them are `zombies`.

When game begins:
  * Judge tells each player his/her **identity** **privately**, a human or a zombie.
  * Judge announces the **number** of zombies and humans **publicly**.

During the turn, player can interact with other players,
  * Every player **must** interact with **at least one** another player per turn
  * Every player **can** interact with **multiple players** per turn
  * Every player **cannot** interact a **single player** for **multiple times** in a turn
  * Interaction works in **bi-directional**, `A interacting with B` is equivalent to `B interacting with A`.

Player can have 3 state, `human`, `zombie`, `infected`. In which, `human` and `zombie` are assigned by the begin of the game. And `infected` state is created during the game play. Player with different state interacts with other player has different effects:
  * A human player interacts with a humber player (without precaution), both human players gain 1 antibody.
  * A human player interacts with a zombie player (without precaution), then human player become infected.
  * A human player interacts with a infected player (without precaution), the infected player gets 1 antibody, but the human player get infected.  
  * A infected player interacts with infected player, nothing happens.
  * A infected player interacts with zombie player, the infected player antibody decreases.
  * A zombie player interacts with zombie player, both zombie players gain a virus.

Human player's precaution and antibody,
  * By consuming antibody, a human player can protect himself/herself by apply precaution in a particular interaction.
  * With precaution, human player won't get infected when interacts with infected player.
  * With precaution, human player won't get infected when interacts with zombie player without reinforced infection.
  * Precaution also enable human player to defend the reinforced infection by zombie players.
  * Precaution must be apply in interaction, and is only valid for that interaction.
  * Apply precaution consumes 1 antibody every time.
  * Human player cannot apply precaution if he/she doesn't have antibody.

Infected player and antibody,
  * Human player without precaution gets infected when interacts with another infected player.
  * Human player without precaution gets infected when interacts with zombie player.
  * Infected player can cure himself/herself at anytime by consuming 1 antibody.
  * Infected player will become human player again after cured.
  * Infected player cannot cure himself/herself without antibody.
  * Player won't be told whether/when/why/how he/she is infected.
  * Infected player can also apply precaution by consuming 1 antibody, but it has not effect.
  * Infected player loses 1 antibody per turn.
  * Infected player turns into a zombie player if he/she has 0 antibody by the end of turn.
  * Infected player can keep himself/herself in infected by the end of turn, if he/she still have antibody.

Virus and reinforced infection,
  * By applying virus, a zombie player can reinforce the infection when interacts another player.
  * Zombie player can apply more than 1 virus in one interaction, the effect of virus accumulates.
  * All virus applied are all transferred to the player touched by zombie player.
  * Virus neutralizes antibody that human/infected player has.
  * 1 virus neutralizes 1 antibody.
  * Human player without precaution will be infected by reinforced infection as well as losing antibody.
  * Human player with precaution will not be infected by reinforced infection, but will lose antibody.
  * Infected player loses antibody when touched by reinforced infection.
  * Human player get infected if he/she lost all antibody
  * Virus can be transferred from a zombie player to another by applying reinforced infection on another zombie player.
  * Apply reinforced infection on another zombie player won't generates virus for both players as normal interaction.

Player can declare he/she end of turn,
  * Player can declare he/she ends the turn after he/she had at least 1 interaction.
  * Players who ended the turn cannot be interacted by other players any more.

The turn ends when all players declared `end of the turn`. Then the judge
  * Inform privately each player about
    * their identity (`zombie` or `human`, it might changed during the turn)
    * The antibody/virus count player has
  * Announces publicly to every player about
    * How many zombies/humans (infected player are counted as human)
    * How many antibody the player who has most antibody has
    * How many virus the player who has most virus has

The game ends, when:
  * **All players** are turned into Zombies by **the end of the turn**, **zombie** wins.
  * **Only 1 human** player survives by ** the end of the turn**, **human** wins. The survivor wins.
  * Game reaches the maximum turns, **human** wins. The human players are ranked by their antibodies.

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
If you want the simulation run automatically after script changed, use following script
```
$ guard
```
