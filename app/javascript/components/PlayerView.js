import React from 'react'
import PropTypes from 'prop-types'
import CardView from './CardView'

export default class PlayerView extends React.Component {
  static propTypes = {
    player: PropTypes.object.isRequired,
    name: PropTypes.string.isRequired,
    selectedRank: PropTypes.string.isRequired,
    updateSelectedRank: PropTypes.func.isRequired,
    playerTurn: PropTypes.number.isRequired,
    players: PropTypes.array.isRequired
  }

  getSelectedRank() {
    if (this.currentPlayer() === this.props.name) {
      return this.props.selectedRank
    }
    return ''
  }

  getUpdateSelectedRank() {
    if (this.currentPlayer() === this.props.name) {
      return this.props.updateSelectedRank
    }
    return () => {}
  }

  currentPlayer() {
    return this.props.players[this.props.playerTurn - 1]
  }

  renderCards(cards) {
    return cards.map(card => (
      <CardView
        key={`${card.rank}${card.suit}`}
        className='card'
        rank={card.rank}
        suit={card.suit}
        selectedRank={this.getSelectedRank()}
        updateSelectedRank={this.getUpdateSelectedRank()}
      />
    ))
  }

  renderPairs(cards) {
    return (
      <div className='pairs'>
        {cards.map(card => (
          <CardView
            key={`${card.rank}${card.suit}`}
            rank={card.rank}
            suit={card.suit}
            updateSelectedRank={() => {}}
          />
        ))}
      </div>
    )
  }

  renderPlayerTurn() {
    if (this.currentPlayer() === this.props.name) {
      return "It's your turn"
    }
    return `Waiting for ${this.currentPlayer()} to finish their turn`
  }

  render() {
    return (
      <div>
        {this.renderPlayerTurn()}
        <h3>{this.props.name}</h3>
        {this.renderCards(this.props.player.cards())}
        {this.renderPairs(this.props.player.pairs())}
      </div>
    )
  }
}
