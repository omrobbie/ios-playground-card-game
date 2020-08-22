import Foundation

struct Card {
    let color: String
    let number: Int
}

class Player {
    var name: String
    var card: Card? = nil
    var cards: [Card] = []

    init(name: String) {
        self.name = name
    }
}

let colorProperty = ["red", "yellow", "black"]
let numberProperty = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

var deck: [Card] = []

func setupDeckOfCards() {
    for color in colorProperty {
        for number in numberProperty {
            deck.append(Card(color: color, number: number))
        }
    }
}

func introduceAllPlayersName() {
    var playersName: [String] = []

    players.forEach {
        playersName.append($0.name)
    }

    print("")
    print("And please welcome our players:")
    print("\(playersName.joined(separator: ", "))")
}

func shuffleTheDeck() {
    print("")
    print("Lets shuffle the deck...")
    deck.shuffle()
}

func allPlayersTakesCard() {
    print("")
    print("All players takes card:")

    for player in players {
        playerTakesCard(player: player)
    }
}

func playerTakesCard(player: Player) {
    if deck.count > 0 {
        player.card = deck[0]
        deck.removeFirst()
    }

    guard let topCard = player.card else {
        print("There is no card left!")
        return
    }

    let playerName = player.name

    print("\(playerName) takes \(topCard)")
}

func checkTheWinner(players: [Player]) {
    if isCardsInSameColor(players: players) {
        let playerWithHighestNumber = getPlayerWithHighestNumber(players: players)
        playerWin(player: playerWithHighestNumber)
    } else {
        let playerWithHighestNumber = getPlayerWithHighestNumberInSameColor(players: players)

        for (i, color) in colorProperty.enumerated() {
            let pos = i - 1 < 0 ? colorProperty.count - 1 : i - 1

            if let winner = playerWithHighestNumber[color],
                let _ = playerWithHighestNumber[colorProperty[pos]] {
                playerWin(player: winner)
                break
            }
        }
    }
}

func isCardsInSameColor(players: [Player]) -> Bool {
    var tempColor = ""

    for player in players {
        if let playerCard = player.card {
            if tempColor.isEmpty {
                tempColor = playerCard.color
            }

            if playerCard.color != tempColor {
                return false
            }
        } else {
            print("Player \(player.name) doesn't have a card")
        }
    }

    return true
}

func getPlayerWithHighestNumber(players: [Player]) -> Player {
    var tempPlayer = players[0]

    for player in players {
        if let playerCard = player.card {
            if playerCard.number > tempPlayer.card?.number ?? 0 {
                tempPlayer = player
            }
        } else {
            print("Player \(player.name) doesn't have a card")
        }
    }

    return tempPlayer
}

func getPlayerWithHighestNumberInSameColor(players: [Player]) -> [String: Player] {
    var playerCardOnColor = [String: Player]()

    for player in players {
        if let playerCard = player.card {
            for color in colorProperty {
                if playerCard.color == color {
                    if let cardNumber = playerCardOnColor[color]?.card?.number {
                        if playerCard.number > cardNumber {
                            playerCardOnColor[color] = player
                        }
                    } else {
                        playerCardOnColor[color] = player
                    }
                }
            }
        } else {
            print("Player \(player.name) doesn't have a card")
        }
    }

    return playerCardOnColor
}

func playerWin(player winner: Player) {
    print("")
    print("\(winner.name) WIN!!")
    print("Now \(winner.name) can takes all players card")

    for player in players {
        if let playerCard = player.card {
            winner.cards.append(playerCard)
            player.card = nil
        } else {
            print("Player \(player.name) doesn't have a card")
        }
    }
}

func checkCurrentStatus() {
    print("")
    print("Current status:")

    for player in players {
        print("\(player.name) has \(player.cards.count) cards")
    }
}

// Start the game!
print("=====================")
print("Welcome to Card Game!")
print("=====================")

let players: [Player] = [
    Player(name: "omrobbie"),
    Player(name: "Putu"),
    Player(name: "Roby")
]

setupDeckOfCards()
introduceAllPlayersName()
shuffleTheDeck()

while deck.count > 0 {
    allPlayersTakesCard()
    checkTheWinner(players: players)
}

checkCurrentStatus()
