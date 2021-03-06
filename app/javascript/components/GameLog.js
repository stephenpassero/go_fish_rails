import React from 'react'
import PropTypes from 'prop-types'

export default class RequestCardsButton extends React.Component {
  static propTypes = {
    gameLog: PropTypes.array.isRequired
  }

  render() {
    return (
      <div className='gameLog'>
        {
          this.props.gameLog.map((logStatement, index) => <p key={index} className='logStatement'>{logStatement}</p>)
        }
      </div>
    )
  }
}
