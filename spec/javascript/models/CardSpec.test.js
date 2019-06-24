import Card from 'models/Card' // eslint-disable-line import/no-unresolved

describe('Card', () => {
  let card
  beforeEach(() => {
    card = new Card('8', 'Hearts')
  })

  it('has a rank', () => {
    expect(card.rank()).toEqual('8')
  })

  it('has a suit', () => {
    expect(card.suit()).toEqual('Hearts')
  })
})
