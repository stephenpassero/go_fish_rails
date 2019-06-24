export default class Player {
  constructor(name, cards, pairs) {
    this._name = name
    this._cards = cards
    this._pairs = pairs
  }

  name() {
    return this._name
  }

  cards() {
    return this._cards
  }

  pairs() {
    return this._pairs
  }
}
