# Boxel

## Description
Boxel is a 2D side-scrolling action game.  The name of the game is to
defeat as many greenie meanies as possible using your trusty laser rifle
and modular replicator.  Objects in Boxel each have special modules, which
can be acquired or swapped using the modular replicator.  Players can
employ clever tactics by combining various modules or even altering the
modules of their enemies in order to defeat them.  This high-action,
high-octane thrill ride of a game will have you clinging to your seat as
you wipe out round after round of greanie meanies!  Will you survive?

## How to Play
### Controls
* w/space - Jump
* a - Move left
* s - Crouch
* d - Move right
* s + jump - Fall through platform
* j - Fire laser
* k - Start game/Fire modular replicator
* esc - Exit game
* i - Eat/Restart game (after death)

### Modules

| Image | Module | Effect
--- | --- | ---
![Bomb][Bomb] | Bomb | Causes explosions on use, impact, or coming in contact with fire
![Delicious][Delicious] | Delicious  | Object possessing this module can be eaten to regain health
![Duplicator][Duplicator] | Duplicator | Creates duplicates on death<br>Causes player to revive with half health
![Emitter][Emitter] | Emitter | Periodically release shots in random directions
![Glass][Glass] | Glass | Take additional damage and shatter on death<br>Shots shatter after a short distance<br>Falling from great heights causes death
![Flaming][Flaming] | Flaming | Releases a stream of flames vertically<br>Causes lasers to temporarily light enemies on fire
![Ninja][Ninja] | Ninja | Increases fire speed<br>Enables double jump
![Plant][Plant] | Plant | Release wood chunks on use or impact<br>Catches fire easily<br>Slowly heals when exposed to light
![Radiant][Radiant] | Radiant | Releases a glowing aura of light that kills vampires and heals plants
![Super Heavy][SuperHeavy] | Super Heavy | Reduces movement speed<br>Falling from heights deals damage in an a zone
![Vampiric][Vampiric] | Vampiric | Heals on dealing damage<br>Can be killed by light

## Building the Game
There are two methods to running the game.  The first is to download the
Boxel source code and Love2D v0.9.2 for your platform from
[here][Love2DVersions].  Then you can run the game using [these
instructions][Love2DGettingStarted].  Alternatively, you can just download
and run a version of the game from the [releases page][Releases].

## Dependencies
* [Love2D] \(v0.9.2\)

## Special Thanks
Big shout out to [Sonniss] and [OurMusicBox] for providing free music and sound effects for the betterment of the game development community!

[Sonniss]: http://www.sonniss.com/gameaudiogdc2016/
[Love2D]: https://love2d.org/
[OurMusicBox]: http://ourmusicbox.com/
[Bomb]:
https://raw.githubusercontent.com/Murfalo/game-off-2016/master/assets/spr/bomb.png
[Delicious]:
https://raw.githubusercontent.com/Murfalo/game-off-2016/master/assets/spr/delicious.png
[Duplicator]:
https://raw.githubusercontent.com/Murfalo/game-off-2016/master/assets/spr/duplicator.png
[Emitter]:
https://raw.githubusercontent.com/Murfalo/game-off-2016/master/assets/spr/emitter.png
[Glass]:
https://raw.githubusercontent.com/Murfalo/game-off-2016/master/assets/spr/glass.png
[Flaming]:
https://raw.githubusercontent.com/Murfalo/game-off-2016/master/assets/spr/fire.png
[Ninja]:
https://raw.githubusercontent.com/Murfalo/game-off-2016/master/assets/spr/ninja.png
[Plant]:
https://raw.githubusercontent.com/Murfalo/game-off-2016/master/assets/spr/wooden.png
[Radiant]:
https://raw.githubusercontent.com/Murfalo/game-off-2016/master/assets/spr/radiant.png
[SuperHeavy]:
https://raw.githubusercontent.com/Murfalo/game-off-2016/master/assets/spr/superHeavy.png
[Vampiric]:
https://raw.githubusercontent.com/Murfalo/game-off-2016/master/assets/spr/vampiric.png
[Love2DVersions]: https://bitbucket.org/rude/love/downloads
[Love2DGettingStarted]: https://love2d.org/wiki/Getting_Started
[Releases]: https://github.com/Murfalo/game-off-2016/releases
