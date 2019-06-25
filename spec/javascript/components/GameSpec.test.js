import { shallow } from 'enzyme';
import React from 'react'
import Game from 'components/Game' // eslint-disable-line import/no-unresolved
import playerData from './playerData'

global.fetch = jest.fn(() => new Promise(resolve => resolve()))
describe('Game', () => {
  let wrapper

  beforeEach(() => {
    wrapper = shallow(<Game
      id={3}
      playerData={playerData}
    />)
  })

  it('renders a player', () => {
    expect(wrapper.find('PlayerView').length).toEqual(1)
  })

  it('renders an opponent', () => {
    expect(wrapper.find('OpponentView').length).toEqual(1)
  })
})
