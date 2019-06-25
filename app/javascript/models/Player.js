export default class Player {
  constructor(player) {
    this._name = player.name
    this._cards = player.cards
    this._pairs = player.pairs
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
