export default {
  player: {
    name: 'Stephen',
    cards: [{ rank: 'A', suit: 'Hearts' }, { rank: '5', suit: 'Diamonds' }],
    pairs: [{ rank: '7', suit: 'Spades' }]
  },
  opponents: [
    {
      name: 'Player2',
      cards_left: 4,
      pairs: [{ rank: 'K', suit: 'Spades' }, { rank: '5', suit: 'Spades' }]
    }
  ],
  players: ['Stephen', 'Player2'],
  cards_left: 23,
  player_turn: 2
}
