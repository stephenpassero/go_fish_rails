export default class Opponent {
  constructor(opponent) {
    this._name = opponent.name
    this._totalCards = opponent.cards_left
    this._pairs = opponent.pairs
  }

  name() {
    return this._name
  }

  totalCards() {
    return this._totalCards
  }

  pairs() {
    return this._pairs
  }
}
