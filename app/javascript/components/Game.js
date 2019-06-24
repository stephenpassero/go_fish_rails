import React from 'react'
import PropTypes from 'prop-types'
import PlayerView from './PlayerView'
import OpponentView from './OpponentView'

export default class Game extends React.Component {
  static propTypes = {
    id: PropTypes.number.isRequired,
    playerName: PropTypes.string.isRequired,
    playerData: PropTypes.object.isRequired
  }

  constructor(props) {
    super(props)
    this.state = {
      playerData: this.props.playerData
    }
  }

  componentDidMount() {
    fetch(`/games/${this.props.id}`, { headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    } })
      .then(res => res.json())
      .then((data) => {
        this.setState({ playerData: data })
        console.log(this.state.playerData)
      })
  }

  renderOpponents() {
    return this.state.playerData.opponents.map((opponent) => { // eslint-disable-line arrow-body-style
      return (
        <OpponentView
          key={opponent.name}
          name={opponent.name}
          numOfCards={opponent.cards_left}
          pairs={opponent.pairs}
        />
      )
    })
  }

  render() {
    return (
      <div>
        {this.renderOpponents()}
        <PlayerView player={this.state.playerData.player} name={this.props.playerName} />
      </div>
    )
  }
}
