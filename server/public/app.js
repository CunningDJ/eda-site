(function () {
  // Content elements
  const contentEl = document.getElementById('content');
  
  function addContent(paragraphString) {
    const contentParEl = document.createElement('p');
    contentParEl.innerText = paragraphString;
    contentEl.appendChild(contentParEl);
  }

  function newContent(paragraphStrings) {
    contentEl.innerHTML = null;
    paragraphStrings.forEach(ps => addContent(ps));
  }

  // Websocket
  let ws = new WebSocket(`ws://${location.host}`);
  ws.addEventListener('open', () => {
    console.log('WebSocket connected.');
    newContent(['WebSocket connected!'])
    // contentParEl.innerText = 'WebSocket connected.';
  });
  ws.addEventListener('message', e => {
    const messageText = e.data;
    addContent(messageText);
  });
})();