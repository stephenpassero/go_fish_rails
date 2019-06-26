import React from 'react'
import PropTypes from 'prop-types'
import PlayerView from './PlayerView'
import OpponentView from './OpponentView'
import Player from '../models/Player'
import Opponent from '../models/Opponent'
import RequestCardsButton from './RequestCardsButton'

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
      selectedOpponent: '',
      playerTurn: props.playerData.player_turn,
      players: props.playerData.players
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
        console.log(data)
        this.setState(() => ({
          player: new Player(data.player),
          opponents: opponents.map(opponent => new Opponent(opponent)),
          playerTurn: data.player_turn,
          selectedOpponent: ''
        }))
      })
  }

  updateSelectedRank(rank) {
    this.setState({ selectedRank: rank })
  }

  updateSelectedOpponent(opponentName) {
    this.setState({ selectedOpponent: opponentName })
  }

  renderFetchGame() {
    return (
      <button type='button' onClick={this.fetchGame.bind(this)}>Fetch Game</button>
    )
  }

  renderOpponents() {
    return this.state.opponents.map(opponent => (
      <OpponentView
        key={opponent.name()}
        name={opponent.name()}
        numOfCards={opponent.totalCards()}
        pairs={opponent.pairs()}
        selectedOpponent={this.state.selectedOpponent}
        updateSelectedOpponent={this.updateSelectedOpponent.bind(this)}
      />
    ))
  }

  renderRequestCards() {
    if (this.state.selectedRank === '' || this.state.selectedOpponent === '') return ''
    return (
      <RequestCardsButton
        gameId={this.props.id}
        selectedRank={this.state.selectedRank}
        selectedOpponent={this.state.selectedOpponent}
      />
    )
  }

  render() {
    return (
      <div>
        {this.renderOpponents()}
        <PlayerView
          selectedRank={this.state.selectedRank}
          updateSelectedRank={this.updateSelectedRank.bind(this)}
          player={this.state.player}
          name={this.state.player.name()}
          pairs={this.state.player.pairs()}
          playerTurn={this.state.playerTurn}
          players={this.state.players}
        />
        {this.renderRequestCards()}
        {this.renderFetchGame()}
      </div>
    )
  }
}
