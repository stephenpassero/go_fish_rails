const pusher = new Pusher('2ffc946d2ff557abffef', {
  cluster: 'us2',
  forceTLS: true
})

const channel = pusher.subscribe('game')
channel.bind('new-game', () => {
  if (window.location.pathname === '/games') {
    window.location.reload()
  }
})

channel.bind('player-left', () => {
  if (window.location.pathname.includes('/games/')
      && window.location.pathname !== '/games/new'
      && window.location.pathname !== '/games/') {
    setTimeout(() => {
      window.location.reload()
    }, 1000)
  }
})

channel.bind('player-joined', () => {
  if (window.location.pathname.includes('/games/')
      && window.location.pathname !== '/games/new'
      && window.location.pathname !== '/games/') {
    window.location.reload()
  }
})
