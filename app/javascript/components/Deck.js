import React from 'react'
import PropTypes from 'prop-types'
import CardBack from '../img/cards/backs_red.png'

export default class RequestCardsButton extends React.Component {
  static propTypes = {
    cardsLeft: PropTypes.number.isRequired
  }

  render() {
    if (this.props.cardsLeft > 0) {
      return (
        <div className='deck'>
          <h3>Deck: </h3>
          <img alt='Deck' src={CardBack} />
        </div>
      )
    }
    return ''
  }
}
