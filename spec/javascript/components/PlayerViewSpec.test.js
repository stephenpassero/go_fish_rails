import { shallow } from 'enzyme';
import React from 'react'
import Player from 'models/Player' // eslint-disable-line import/no-unresolved
import PlayerView from 'components/PlayerView' // eslint-disable-line import/no-unresolved

describe('PlayerView', () => {
  let wrapper
  beforeEach(() => {
    wrapper = shallow(<PlayerView
      name='Player1'
      player={new Player({
        cards: [{ rank: '4', suit: 'Clubs' }, { rank: '8', suit: 'Hearts' }],
        pairs: [{ rank: '2', suit: 'Spades' }]
      })}
      selectedRank='3'
      updateSelectedRank={jest.fn()}
      playerTurn={1}
      players={['Player1', 'Player2']}
    />)
  })

  it('renders the player\'s name, pairs, and cards', () => {
    expect(wrapper.find('h3').text()).toEqual('Player1')
    // 2 cards + 1 pairs
    expect(wrapper.find('CardView').length).toEqual(3)
  })
})
