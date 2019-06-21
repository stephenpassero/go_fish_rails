import React from 'react'
import PropTypes from 'prop-types'

class Game extends React.Component {
  constructor() {
    super()
    this.state = {
      playerData: ''
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

  render() {
    return (
      <div>
        <h3>{this.props.playerName}</h3>
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
