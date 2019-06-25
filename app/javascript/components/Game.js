import React from 'react'
import PropTypes from 'prop-types'
import PlayerView from './PlayerView'
import OpponentView from './OpponentView'
import Player from '../models/Player'
import Opponent from '../models/Opponent'

export default class Game extends React.Component {
  static propTypes = {
    id: PropTypes.number.isRequired,
    playerData: PropTypes.object.isRequired
  }

  constructor(props) {
    super(props)
    this.state = {
      player: new Player(props.playerData.player),
      opponents: props.playerData.opponents.map(opponent => new Opponent(opponent)),
      selectedRank: '',
      selectedOpponent: ''
    }
  }

  fetchGame() {
    fetch(`/games/${this.props.id}`, { headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    } })
      .then(res => res.json())
      .then((data) => {
        const { opponents } = data
        this.setState({ player: new Player(data.player) })
        this.setState({ opponents: opponents.map(opponent => new Opponent(opponent)) })
      })
  }

  updateSelectedRank(rank) {
    this.setState({ selectedRank: rank })
  }

  updateSelectedOpponent(opponentName) {
    this.setState({ selectedOpponent: opponentName })
  }

  renderOpponents() {
    return this.state.opponents.map(opponent => (
      <OpponentView
        key={opponent.name()}
        name={opponent.name()}
        numOfCards={opponent.totalCards()}
        pairs={opponent.pairs()}
        selectedOpponent={this.state.selectedOpponent}
        updateSelectedOpponent={this.updateSelectedOpponent}
      />
    ))
  }

  render() {
    return (
      <div>
        {this.renderOpponents()}
        <PlayerView
          selectedRank={this.state.selectedRank}
          updateSelectedRank={this.updateSelectedRank}
          player={this.state.player}
          name={this.state.player.name()}
          pairs={this.state.player.pairs()}
        />
      </div>
    )
  }
}
