#  Simple card game "21 points"

### (educational project for mastering SwiftUI)

## Platform 

- iOS 16.0

## Stack

- SwiftUI
- Combine
- URLSession

## API

https://deckofcardsapi.com/

## Game view:
  </p>
<div align="center">

![video](/TwentyOne/Doc/twentyOne.gif)
</div>
</p>

## Game description:

### Players
first player - application

second player - user

### Card weights: 
2...10 according to nominal, 

jack - 2

queen - 3

king - 4

ace - 11

### Game rules 

At the beginning of the game we get a new deck of cards, shuffle it and the players draw one card each. Players draw one card in each iteration of the game. 
If any player has scored more than 16 points, he stops drawing cards.
If application stops drawing, it opens cards.

### Winning conditions

- If both players scored from 17 to 20 points, the one who scored more won. 
- If one player scored 21 points and the other less or more than 21, the first one wins.
- If one player scored more than 21 points and the other less than or equal to 21, the second one wins.

### Neutral result conditions:

- If both players scored 21 points, 
- If both players scored any amount more than 21 points, 
- If both players scored the same amount in the range of 17-20 points

## Project structure:

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/API/APIData/">API/APIData/*.swift - structures to decode API responses</a>

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/API/APIClient.swift">API/APIClient.swift - API client</a>

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/API/Method.swift">API/Method.swift - enum to get API URLRequests</a>

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/ViewModel/Game.swift">ViewModel/Game.swift - game view model class</a>

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/ViewModel/GameEnums.swift">ViewModel/GameEnums.swift - enums for Game class</a>

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/ViewModel/Player.swift">ViewModel/Player.swift - player view model class</a>

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/UI/ContentView.swift">UI/ContentView.swift - root view</a>

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/UI/GameView.swift">UI/GameView.swift -  main game view</a>

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/UI/ErrorView.swift">UI/ErrorView.swift  - error state view</a>

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/UI/PlayerView.swift">UI/PlayerView.swift - player view (for GameView)</a>

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/UI/CardsView.swift">UI/CardsView.swift - set of player cards view (for PlayerView, GameOverView)</a>

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/UI/CardView.swift">UI/CardView.swift - single card view (for CardsView)</a>

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/UI/CustomButton.swift">
UI/CustomButton.swift - general animated button for all the views</a>



