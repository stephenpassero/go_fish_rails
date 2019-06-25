import React from 'react'
import PropTypes from 'prop-types'
import PlayerView from './PlayerView'
import OpponentView from './OpponentView'
import Player from '../models/Player'
import Opponent from '../models/Opponent'

export default class Game extends React.Component {
  static propTypes = {
    id: PropTypes.number.isRequired,
    playerName: PropTypes.string.isRequired,
    playerData: PropTypes.object.isRequired
  }

  constructor(props) {
    super(props)
    this.state = {
      playerData: props.playerData,
      player: '',
      selectedRank: '',
      selectedOpponent: ''
    }
    this.setUpPlayer()
    this.setUpOpponents()
  }

  // Pull into refresh state button
  componentDidMount() {
    fetch(`/games/${this.props.id}`, { headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    } })
      .then(res => res.json())
      .then((data) => {
        this.setState({ playerData: data })
        const { opponents } = this.state.playerData
        this.setState({ player: new Player(this.state.playerData.player) })
        this.setState({ opponents: opponents.map(opponent => new Opponent(opponent)) })
      })
  }

  setUpPlayer() {
    this.setState(() => (
      { player: new Player(this.props.playerData.player) }
    ))
  }

  setUpOpponents() {
    this.setState(() => (
      { opponents: this.props.playerData.opponents.map(opponent => new Opponent(opponent)) }
    ))
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
