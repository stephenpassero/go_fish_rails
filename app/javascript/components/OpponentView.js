import React from 'react'
import PropTypes from 'prop-types'
import CardView from './CardView'
import CardBack from '../img/cards/backs_red.png'

export default class OpponentView extends React.Component {
  static propTypes = {
    numOfCards: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    pairs: PropTypes.array.isRequired,
    selectedOpponent: PropTypes.string.isRequired,
    updateSelectedOpponent: PropTypes.func.isRequired
  }

  getClasses() {
    if (this.props.selectedOpponent === this.props.name) {
      return 'opponent selected'
    }
    return 'opponent'
  }

  renderCardBacks(numOfCards) {
    return [...new Array(numOfCards).keys()].map(index => <img alt='Card Back' key={index} src={CardBack} />)
  }

  renderPairs(pairs) {
    return (
      <div className='pairs'>
        {pairs.map(pair => (
          <CardView
            key={`${pair.rank}`}
            updateSelectedRank={() => {}}
            rank={pair.rank}
            suit={pair.suit}
          />
        ))}
      </div>
    )
  }

  render() {
    return (
      <div
        className={this.getClasses()}
        onClick={this.props.updateSelectedOpponent.bind(this, this.props.name)}
      >
        <h3>{this.props.name}</h3>
        {this.renderCardBacks(this.props.numOfCards)}
        {this.renderPairs(this.props.pairs)}
      </div>
    )
  }
}
