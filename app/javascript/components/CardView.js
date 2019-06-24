import React from 'react'
import PropTypes from 'prop-types'

class CardView extends React.Component {
  render() {
    // Make this display actual cards images later
    return (
      <p>{this.props.rank} of {this.props.suit}</p>
    )
  }
}

CardView.propTypes = {
  rank: PropTypes.string.isRequired,
  suit: PropTypes.string.isRequired
}

export default CardView
