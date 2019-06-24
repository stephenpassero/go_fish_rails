import React from 'react'
import PropTypes from 'prop-types'

export default class CardView extends React.Component {
  static propTypes = {
    rank: PropTypes.string.isRequired,
    suit: PropTypes.string.isRequired
  }

  render() {
    // Make this display actual cards images later
    return (
      <img alt={`${this.props.rank} of ${this.props.suit}`} src='#' />
    )
  }
}
