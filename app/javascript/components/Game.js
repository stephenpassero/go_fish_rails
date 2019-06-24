import React from 'react'
import PropTypes from 'prop-types'
import PlayerView from './PlayerView'

class Game extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      playerData: this.props.initialState
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
      })
  }

  render() {
    return (
      <div>
        <PlayerView player={this.state.playerData.player} name={this.props.playerName} />
      </div>
    )
  }
}

Game.propTypes = {
  id: PropTypes.number.isRequired,
  playerName: PropTypes.string.isRequired,
  initialState: PropTypes.object.isRequired
}

export default Game
