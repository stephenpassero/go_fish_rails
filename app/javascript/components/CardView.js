import React from 'react'
import PropTypes from 'prop-types'

const ranks = ['a', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'j', 'q', 'k']
const suits = ['h', 'd', 's', 'c']
const cards = {}
ranks.forEach(rank => (
  suits.forEach((suit) => {
    cards[`${suit}${rank}`] = require(`../img/cards/${suit}${rank}.png`)
  })
))

export default class CardView extends React.Component {
  static propTypes = {
    rank: PropTypes.string.isRequired,
    suit: PropTypes.string.isRequired,
    selectedRank: PropTypes.string,
    updateSelectedRank: PropTypes.func.isRequired
  }

  render() {
    // Make this display actual cards images later
    if (this.props.selectedRank === this.props.rank) {
      return (
        <img
          className='selected'
          alt={`${this.props.rank} of ${this.props.suit}`}
          src={cards[`${this.props.suit.charAt(0).toLowerCase()}${this.props.rank.toLowerCase()}`]}
        />
      )
    }
    return (
      <img
        alt={`${this.props.rank} of ${this.props.suit}`}
        src={cards[`${this.props.suit.charAt(0).toLowerCase()}${this.props.rank.toLowerCase()}`]}
        onClick={this.props.updateSelectedRank.bind(this, this.props.rank)}
      />
    )
  }
}
