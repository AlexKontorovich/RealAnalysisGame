import Game.Levels.L1RealAnalysisStory
import Game.Levels.L1PsetIntro
import Game.Levels.L2NewtonsCalculationOfPi
import Game.Levels.L2PsetIntro
-- import Game.Levels.L3Lecture
-- import Game.Levels.L3PsetIntro
-- import Game.Levels.L4Lecture
-- import Game.Levels.L4PsetIntro
-- import Game.Levels.L5Lecture
-- import Game.Levels.L6Lecture
-- import Game.Levels.L6PsetIntro
-- import Game.Levels.L7Lecture
-- import Game.Levels.L7PsetIntro
-- import Game.Levels.L8Lecture
-- import Game.Levels.L8PsetIntro
-- import Game.Levels.L9Lecture
-- import Game.Levels.L9PsetIntro
-- import Game.Levels.L10Lecture
-- import Game.Levels.L10PsetIntro
-- import Game.Levels.L11Lecture
-- import Game.Levels.L11PsetIntro
-- import Game.Levels.L12Lecture
-- import Game.Levels.L12PsetIntro
-- import Game.Levels.L13Lecture
-- import Game.Levels.L13PsetIntro
-- import Game.Levels.L14Lecture
-- import Game.Levels.L15Lecture
-- import Game.Levels.L15PsetIntro
-- import Game.Levels.L16Lecture
-- import Game.Levels.L16PsetIntro
-- import Game.Levels.L17Lecture
-- import Game.Levels.L17PsetIntro
-- import Game.Levels.L18Lecture
-- import Game.Levels.L18PsetIntro
-- import Game.Levels.L19Lecture
-- import Game.Levels.L20Lecture
-- import Game.Levels.L20PsetIntro
-- import Game.Levels.L21Lecture
-- import Game.Levels.L22Lecture
-- import Game.Levels.L22PsetIntro
-- import Game.Levels.L23Lecture
-- import Game.Levels.L24Lecture
-- import Game.Levels.L24PsetIntro
-- import Game.Levels.L25Lecture

-- -- exercise for later : why not `|a n - a (n + 1)|`?

Dependency NewtonsCalculationOfPi → L2Pset

-- Dependency NewtonsCalculationOfPi → Lecture3

-- Dependency L2Pset → Lecture4

-- Dependency Lecture4 → Lecture5

-- Dependency Lecture5 → Lecture6

-- Dependency L4Pset → Lecture6

-- Dependency Lecture6 → Lecture7

-- Dependency L6Pset → Lecture8

-- Dependency L9Pset → Lecture11

-- Dependency Lecture10 → Lecture11

-- Dependency Lecture11 → Lecture12

-- Dependency Lecture11 → L11Pset

-- Dependency L10Pset → Lecture12

-- Dependency Lecture12 → L12Pset

-- Dependency L11Pset → Lecture13

-- Dependency Lecture13 → L13Pset

-- Dependency L12Pset → Lecture14

-- Dependency Lecture14 → Lecture15

-- Dependency L13Pset → Lecture15

-- Dependency Lecture15 → L15Pset

-- Dependency Lecture15 → Lecture16

-- Dependency Lecture16 → L16Pset

-- Dependency Lecture16 → Lecture17

-- Dependency L15Pset → Lecture17

-- Dependency Lecture17 → L17Pset

-- Dependency Lecture17 → Lecture18

-- Dependency L16Pset → Lecture18

-- Dependency Lecture18 → L18Pset

-- Dependency L17Pset → Lecture19

-- Dependency L18Pset → Lecture20

-- Dependency Lecture19 → Lecture20

-- Dependency Lecture20 → L20Pset

-- Dependency Lecture20 → Lecture21

-- Dependency Lecture21 → Lecture22

-- Dependency L20Pset → Lecture22

-- Dependency Lecture22 → L22Pset

-- Dependency Lecture22 → Lecture23

-- Dependency Lecture23 → Lecture24

-- Dependency L22Pset → Lecture24

-- Dependency Lecture24 → L24Pset

-- Dependency L24Pset → Lecture25

-- Dependency Lecture24 → Lecture25

-- Here's what we'll put on the title screen
Title "Real Analysis, The Game"

Introduction "
# Welcome to Real Analysis, The Game! (v0.1)

This course is was developed for Rutgers University Math 311H by [Alex Kontorovich](https://math.rutgers.edu/~alexk).

Follow along with the course lecture notes and videos, available here: https://alexkontorovich.github.io/2025F311H.

This course takes you through an Introduction to the Real Numbers, rigorous `ε`-`δ` Calculus,
and basic Point-Set Topology.
To get started, click on
**\"Level 1: The Story of Real Analysis\"**, and good luck!

"

Info "
*Real Analysis, The Game*

## About this Course

This course follows the historical crises that forced mathematicians to rebuild
mathematics from the ground up in the 19th century. You'll learn why concepts
like `ε`-`δ` definitions became necessary and how to use them to do advanced calculus.

## Credits

* **Course Design:** By Alex Kontorovich alex.kontorovich@rutgers.edu
* **Interactive Implementation:** Lean 4 Game Engine
* **Mathematical Content:** Following Rudin, Stein-Shakarchi, Abbot, etc.
* **Many thanks to:** Jon Eugster, Heather Macbeth, Michael Stoll, and the students of 311H for a lot of technical support, encouragement, and many great suggestions for improvement!
"

/-! Information to be displayed on the servers landing page. -/
Languages "en"
CaptionShort "Real Analysis, The Game"
CaptionLong "Learn real analysis through the historical crises that forced mathematicians to rebuild calculus from the ground up in the 19th century."

CoverImage "images/cover.png"

set_option lean4game.showDependencyReasons true

/-! Build the game. Show's warnings if it found a problem with your game. -/
MakeGame
