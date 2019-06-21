import { shallow } from 'enzyme';
import React from 'react'
import Game from 'components/Game' // eslint-disable-line import/no-unresolved
import initialState from './initialState'

global.fetch = jest.fn(() => new Promise(resolve => resolve()))
describe('Game', () => {
  let wrapper

  beforeEach(() => {
    wrapper = shallow(<Game
      id={3}
      playerName="Stephen"
      initialState={initialState}
    />)
  })

  it('renders a component', () => {
    expect(wrapper.text()).toContain('Stephen')
  })

  it('renders a player with cards', () => {
    expect(wrapper.find('.playerName').textContent()).toEqual('Stephen')
    // I'm setting how many cards the player has in ./initialState.js
    expect(wrapper.find('.card').length).toEqual(2)
  })
})
