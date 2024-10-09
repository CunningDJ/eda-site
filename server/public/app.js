(function () {
  // Content elements
  const contentEl = document.getElementById('content');
  const websocketStatusEl = document.getElementById('websocket-status')
  const websocketMessagesLogEl = document.getElementById('websocket-messages-log')
  
  function showWebsocketStatus(statusString) {
    websocketStatusEl.innerText = statusString;
  }

  function addMessageLog(paragraphString) {
    const logDate = new Date();
    const logParagraphEl = document.createElement('p');
    // Prepends date logged to the message text
    logParagraphEl.innerText = `[${logDate.toISOString()}] ${paragraphString}`;
    websocketMessagesLogEl.appendChild(logParagraphEl);
  }

  // Websocket
  let ws = new WebSocket(`ws://${location.host}`);
  ws.addEventListener('open', () => {
    showWebsocketStatus('WebSocket connected!');
  });
  ws.addEventListener('message', e => {
    const messageText = e.data;
    addMessageLog(messageText);
  });
})();