import React from 'react'
import PropTypes from 'prop-types'
import CardView from './CardView'

export default class OpponentView extends React.Component {
  static propTypes = {
    numOfCards: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    pairs: PropTypes.array.isRequired
  }

  // Make this display actual cards images later
  renderCardBacks(numOfCards) {
    return [...new Array(numOfCards).keys()].map(index => <img alt='Card Back' key={index} src='#' />)
  }

  renderPairs(pairs) {
    return pairs.map(pair => <CardView key={`${pair.rank}`} rank={pair.rank} suit={pair.suit} />)
  }

  render() {
    return (
      <div>
        <h3>{this.props.name}</h3>
        {this.renderCardBacks(this.props.numOfCards)}
        {this.renderPairs(this.props.pairs)}
      </div>
    )
  }
}
