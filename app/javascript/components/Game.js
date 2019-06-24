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
      playerData: this.props.playerData,
      isLoaded: false,
      player: '',
      selectedRank: '',
      selectedOpponent: ''
    }
    this.setUpPlayer()
    this.setUpOpponents()
  }

  componentDidMount() {
    fetch(`/games/${this.props.id}`, { headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    } })
      .then(res => res.json())
      .then((data) => {
        this.setState({ playerData: data })
        this.state.isLoaded = true
      })
  }

  setUpPlayer() {
    if (this.state.isLoaded) {
      this.state.player = new Player(
        this.props.playerName,
        this.state.playerData.player.cards,
        this.state.playerData.player.pairs
      )
    } else {
      this.state.player = new Player(
        this.props.playerName,
        this.props.playerData.player.cards,
        this.props.playerData.player.pairs
      )
    }
  }

  setUpOpponents() {
    if (this.state.isLoaded) {
      this.state.opponents = this.state.playerData.opponents.map((opponent) => {
        return new Opponent(
          opponent.name,
          opponent.cards_left,
          opponent.pairs
        )
      })
    } else {
      this.state.opponents = this.props.playerData.opponents.map((opponent) => {
        return new Opponent(
          opponent.name,
          opponent.cards_left,
          opponent.pairs
        )
      })
    }
  }

  renderOpponents() {
    return this.state.opponents.map((opponent) => { // eslint-disable-line arrow-body-style
      return (
        <OpponentView
          key={opponent.name()}
          name={opponent.name()}
          numOfCards={opponent.totalCards()}
          pairs={opponent.pairs()}
          selectedOpponent={this.state.selectedOpponent}
        />
      )
    })
  }

  render() {
    return (
      <div>
        {this.renderOpponents()}
        <PlayerView
          selectedRank={this.state.selectedRank}
          player={this.state.player}
          name={this.state.player.name()}
          pairs={this.state.player.pairs()}
        />
      </div>
    )
  }
}
