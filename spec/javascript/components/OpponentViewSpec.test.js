import { shallow } from 'enzyme'
import React from 'react'
import OpponentView from 'components/OpponentView' // eslint-disable-line import/no-unresolved

describe('OpponentView', () => {
  let wrapper

  beforeEach(() => {
    wrapper = shallow(<OpponentView
      name='Player2'
      numOfCards={4}
      pairs={[{ rank: '3', suit: 'Spades' }]}
    />)
  })

  it('renders the opponent\'s name', () => {
    expect(wrapper.find('h3').text()).toEqual('Player2')
  })

  it('shows how many cards the opponent has', () => {
    expect(wrapper.find('img').length).toEqual(4)
  })

  it('shows the opponent\'s pairs', () => {
    // The pairs are the only actual card images
    expect(wrapper.find('CardView').length).toEqual(1)
  })
})
