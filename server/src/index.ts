import http from 'http';
import { WebSocketServer } from 'ws';
import express from 'express';
import expressSession from 'express-session';

import kafka from "../../shared/src/kafka"; //"@eda-site/shared";

const EXPRESS_SESSION_SECRET = 'eda-app-secret';

const HTTP_PORT = 8080;

const wss = new WebSocketServer({
  noServer: true

  // port: 8080,
});

const expressSessionParser = expressSession({
  secret: EXPRESS_SESSION_SECRET,
  saveUninitialized: true,
  resave: false
});

const expressApp = express();
expressApp.use(expressSessionParser);
const httpServer = new http.Server(expressApp);

httpServer.on('upgrade', (serverReq, socket, head) => {
  // TODO: fix any typing
  expressSessionParser(serverReq as any, {} as any, () => {
    const req = serverReq as unknown as Express.Request;
    wss.handleUpgrade(serverReq, socket, head, (ws) => {
      console.log(req.session)
      // emit a 'connection' event (handler above) with the create WebSocket and current session
      wss.emit('connection', ws, req.session)
    });
  });
});

httpServer.listen(HTTP_PORT, () => {
  console.log(`Server is running on ${HTTP_PORT}!`)
});

wss.on('connection', function connection(ws) {
  ws.on('error', console.error);

  ws.on('message', function message(data) {
    // TODO: receive message logic


    // TODO: send?
    // ws.send('something');
  });

  kafka.consumer
});