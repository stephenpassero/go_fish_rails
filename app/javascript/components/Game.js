import React from 'react'
import Pusher from 'pusher-js'
import PropTypes from 'prop-types'
import PlayerView from './PlayerView'
import OpponentView from './OpponentView'
import Player from '../models/Player'
import Opponent from '../models/Opponent'
import RequestCardsButton from './RequestCardsButton'
import GameLog from './GameLog'
import Deck from './Deck'

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
      players: props.playerData.players,
      gameLog: props.playerData.game_log,
      cardsLeft: props.playerData.cards_left
    }
  }

  componentDidMount() {
    const pusher = new Pusher('2ffc946d2ff557abffef', {
      cluster: 'us2',
      forceTLS: true
    });
    const channel = pusher.subscribe(`game${this.props.id}`);
    channel.bind('turn-played', () => {
      this.fetchGame()
    })
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
          selectedOpponent: '',
          selectedRank: '',
          gameLog: data.game_log,
          cardsLeft: data.cards_left
        }))
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

  renderPlayerTurn() {
    const currentPlayer = this.state.players[this.state.playerTurn - 1]
    if (currentPlayer === this.state.player.name()) {
      return <h2>It’s your turn</h2>
    }
    return <h2>Waiting for {currentPlayer} to finish their turn</h2>
  }

  render() {
    return (
      <div>
        <div className='turnIndicator'>
          {this.renderPlayerTurn()}
        </div>
        <div className='flex-container'>
          {this.renderOpponents()}
        </div>
        <Deck cardsLeft={this.state.cardsLeft} />
        <PlayerView
          selectedRank={this.state.selectedRank}
          updateSelectedRank={this.updateSelectedRank.bind(this)}
          player={this.state.player}
          name={this.state.player.name()}
          pairs={this.state.player.pairs()}
          playerTurn={this.state.playerTurn}
          players={this.state.players}
        />
        <div className='requestCards'>
          {this.renderRequestCards()}
        </div>
        <GameLog gameLog={this.state.gameLog} />
      </div>
    )
  }
}
