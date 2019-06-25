import { shallow } from 'enzyme';
import React from 'react'
import CardView from 'components/CardView' // eslint-disable-line import/no-unresolved

describe('CardView', () => {
  let wrapper

  beforeEach(() => {
    wrapper = shallow(<CardView
      rank="5"
      suit="Hearts"
      updateSelectedRank={jest.fn()}
    />)
  })

  it('renders the cards passed in cards', () => {
    expect(wrapper.find('img').length).toEqual(1)
    // It should be the actual card, not just a random img element
    expect(wrapper.find('img[alt="5 of Hearts"]').length).toEqual(1)
  })
})
