import React from 'react'
import PropTypes from 'prop-types'
import CardView from './CardView'

class PlayerView extends React.Component {
  renderCards(cards) {
    return cards.map(card => <CardView key={`${card.rank}${card.suit}`} className='card' rank={card.rank} suit={card.suit} />)
  }

  render() {
    return (
      <div>
        <h3>{this.props.name}</h3>
        {this.renderCards(this.props.player.cards)}
      </div>
    )
  }
}

PlayerView.propTypes = {
  player: PropTypes.object.isRequired,
  name: PropTypes.string.isRequired
}

export default PlayerView
