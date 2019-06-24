export default class Opponent {
  constructor(name, totalCards, pairs) {
    this._name = name
    this._totalCards = totalCards
    this._pairs = pairs
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
