import React from 'react'
import PropTypes from 'prop-types'

export default class EndGameView extends React.Component {
  static propTypes = {
    playerPoints: PropTypes.array.isRequired
  }

  renderRankings() {
    return this.props.playerPoints.map((array, index) => (
      <h3>{index + 1}. {array[0]}: {array[1]} points</h3>
    ))
  }

  render() {
    return (
      <div>
        <h1>Game Over</h1>
        <h2>Rankings:</h2>
        {this.renderRankings()}
      </div>
    )
  }
}
