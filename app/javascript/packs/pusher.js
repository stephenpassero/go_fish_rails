if (!window.pusher) {
  window.pusher = new Pusher('2ffc946d2ff557abffef', {
    cluster: 'us2',
    forceTLS: true
  })
}

const channel = window.pusher.subscribe('game')
channel.bind('new-game', () => {
  if (window.location.pathname === '/games') {
    window.location.reload()
  }
})

channel.bind('player-left', (data) => {
  if (window.location.pathname === `/games/${data.game_id}` || window.location.pathname === '/games') {
    if (data.user_id !== document.body.dataset.current_user_id) {
      window.location.reload()
    }
  }
})

channel.bind('player-joined', (data) => {
  if (window.location.pathname === `/games/${data.game_id}` || window.location.pathname === '/games') {
    if (data.user_id !== document.body.dataset.current_user_id) {
      window.location.reload()
    }
  }
})
