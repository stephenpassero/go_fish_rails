import React from 'react'
import PropTypes from 'prop-types'
import CardView from './CardView'

export default class PlayerView extends React.Component {
  static propTypes = {
    player: PropTypes.object.isRequired,
    name: PropTypes.string.isRequired,
    selectedRank: PropTypes.string.isRequired,
    updateSelectedRank: PropTypes.func.isRequired
  }

  renderCards(cards) {
    return cards.map((card) => {
      return (
        <CardView
          key={`${card.rank}${card.suit}`}
          className='card'
          rank={card.rank}
          suit={card.suit}
          selectedRank={this.props.selectedRank}
          updateSelectedRank={this.props.updateSelectedRank}
        />
      )
    })
  }

  render() {
    return (
      <div>
        <h3>{this.props.name}</h3>
        {this.renderCards(this.props.player.cards())}
        {this.renderCards(this.props.player.pairs())}
      </div>
    )
  }
}
