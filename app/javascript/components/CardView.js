import React from 'react'
import PropTypes from 'prop-types'

export default class CardView extends React.Component {
  static propTypes = {
    rank: PropTypes.string.isRequired,
    suit: PropTypes.string.isRequired,
    selectedRank: PropTypes.string,
    updateSelectedRank: PropTypes.func
  }

  render() {
    // Make this display actual cards images later
    if (this.props.selectedRank === this.props.rank) {
      return (
        <img
          className='selected'
          alt={`${this.props.rank} of ${this.props.suit}`}
          src='#'
          onClick={this.props.updateSelectedRank.bind(this, this.props.rank)}
        />
      )
    }
    return (
      <img
        alt={`${this.props.rank} of ${this.props.suit}`}
        src='#'
        onClick={this.props.updateSelectedRank.bind(this, this.props.rank)}
      />
    )
  }
}
