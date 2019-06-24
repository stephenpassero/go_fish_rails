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

  it('renders a one player', () => {
    expect(wrapper.find('PlayerView').length).toEqual(1)
  })
})
