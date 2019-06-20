import React from 'react'
import PropTypes from 'prop-types'

class Game extends React.Component {
  componentDidMount() {
    fetch(`/games/${this.props.id}.json`)
      .then(res => res.json())
      .then(data => console.log(data))
  }

  render() {
    return (
      <h3>Actual React Game Component</h3>
    )
  }
}

export default Game
