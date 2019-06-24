import React from 'react'
import PropTypes from 'prop-types'
import CardView from './CardView'

export default class PlayerView extends React.Component {
  static propTypes = {
    player: PropTypes.object.isRequired,
    name: PropTypes.string.isRequired
  }

  renderCards(cards) {
    return cards.map(card => <CardView key={`${card.rank}${card.suit}`} className='card' rank={card.rank} suit={card.suit} />)
  }

  render() {
    return (
      <div>
        <h3>{this.props.name}</h3>
        {this.renderCards(this.props.player.cards)}
        {this.renderCards(this.props.player.pairs)}
      </div>
    )
  }
}
