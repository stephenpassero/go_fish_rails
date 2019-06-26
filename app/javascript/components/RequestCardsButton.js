import React from 'react'
import PropTypes from 'prop-types'

export default class RequestCardsButton extends React.Component {
  static propTypes = {
    selectedRank: PropTypes.string.isRequired,
    selectedOpponent: PropTypes.string.isRequired,
    gameId: PropTypes.number.isRequired
  }

  createJSON() {
    return {
      selectedOpponent: this.props.selectedOpponent,
      gameId: this.props.gameId,
      selectedRank: this.props.selectedRank
    }
  }

  requestCards() {
    fetch('games/run_round', {
      method: 'POST',
      body: JSON.stringify(this.createJSON()),
      headers: {
        'Content-Type': 'application/json'
      }
    })
  }

  render() {
    return (
      <button type='button' onClick={this.requestCards.bind(this)}>Request Cards</button>
    )
  }
}