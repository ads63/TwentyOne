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

<a href="https://github.com/ads63/TwentyOne/tree/main/TwentyOne/API/APIData/">API/APIData/*.swift - structures to decode API responses</a>\

API/APIData/*.swift - structures to decode API responses

API/APIClient.swift - API client  

API/Methhod.swift - enum to get API URLRequests

ViewModel/Game.swift - game view model class

ViewModel/GameEnums.swift - different enums for Game class

ViewModel/Player.swift - player view model vlass

UI/ContentView.swift -  root view

UI/GameView.swift -  main game view

UI/GameOverView.swift -  game results view

UI/ErrorView.swift  - error state view

UI/PlayerVuew.swift - player view (for GameView)

UI/CardsView.swift - set of player cards view (for PlayerView, GameOverView)

UI/CardView.swift - single card view (for CardsView)

UI/CustomButton.swift - general animated button for all the views


