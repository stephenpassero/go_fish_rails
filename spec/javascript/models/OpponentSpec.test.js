import Opponent from 'models/Opponent' // eslint-disable-line import/no-unresolved

describe('Opponent', () => {
  let opponent
  beforeEach(() => {
    opponent = new Opponent('Bot', 7, [{ rank: '9', suit: 'Spades' }])
  })

  it('has a name', () => {
    expect(opponent.name()).toEqual('Bot')
  })

  it('shows how many cards it has', () => {
    expect(opponent.totalCards()).toEqual(7)
  })

  it('has pairs', () => {
    expect(opponent.pairs()).toEqual([{ rank: '9', suit: 'Spades' }])
  })
})
