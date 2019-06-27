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
import EndGameView from './EndGameView'

export default class Game extends React.Component {
  static propTypes = {
    id: PropTypes.number.isRequired,
    playerData: PropTypes.object.isRequired
  }

  constructor(props) {
    super(props)
    const data = props.playerData
    this.state = {
      player: new Player(data.player),
      opponents: data.opponents.map(opponent => new Opponent(opponent)),
      selectedRank: '',
      selectedOpponent: '',
      playerTurn: data.player_turn,
      players: data.players,
      gameLog: data.game_log,
      cardsLeft: data.cards_left,
      playerPairs: data.player_pairs,
      winner: data.winner
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
    },
    credentials: 'same-origin' })
      .then(res => res.json())
      .then((data) => {
        const { opponents } = data
        this.setState(() => ({
          player: new Player(data.player),
          opponents: opponents.map(opponent => new Opponent(opponent)),
          playerTurn: data.player_turn,
          selectedOpponent: '',
          selectedRank: '',
          gameLog: data.game_log,
          cardsLeft: data.cards_left,
          playerPairs: data.player_pairs,
          winner: data.winner
        }))
      })
  }

  updateSelectedRank(rank) {
    this.setState({ selectedRank: rank })
  }

  updateSelectedOpponent(opponentName) {
    this.setState({ selectedOpponent: opponentName })
  }

  gameView() {
    return (
      <div>
        {this.renderPlayerTurn()}
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
        {this.renderRequestCards()}
        <GameLog gameLog={this.state.gameLog} />
      </div>
    )
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

  renderPlayerTurn() {
    const currentPlayer = this.state.players[this.state.playerTurn - 1]
    if (currentPlayer === this.state.player.name()) {
      return <h2>It’s your turn</h2>
    }
    return <h2>Waiting for {currentPlayer} to finish their turn</h2>
  }

  render() {
    if (this.state.winner) {
      return <EndGameView playerPoints={this.state.playerPairs} />
    }
    return this.gameView()
  }
}
