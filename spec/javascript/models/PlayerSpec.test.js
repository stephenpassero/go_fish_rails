import Player from 'models/Player' // eslint-disable-line import/no-unresolved

describe('Player', () => {
  let player
  beforeEach(() => {
    player = new Player('Stephen', [{ rank: '3', suit: 'Spades' }], [{ rank: 'A', suit: 'Spades' }])
  })

  it('has a name', () => {
    expect(player.name()).toEqual('Stephen')
  })

  it('has cards', () => {
    expect(player.cards()).toEqual([{ rank: '3', suit: 'Spades' }])
  })

  it('has pairs', () => {
    expect(player.pairs()).toEqual([{ rank: 'A', suit: 'Spades' }])
  })
})
