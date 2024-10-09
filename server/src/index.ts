import './declare';

import http from 'http';
import { v4 as uuidv4 } from 'uuid';
import { WebSocketServer } from 'ws';
import express from 'express';
import expressSession from 'express-session';

import kafka from "../../shared/src/kafka"; //"@eda-site/shared";

const EXPRESS_SESSION_SECRET = 'eda-app-secret';

const HTTP_PORT = 8080;

const wss = new WebSocketServer({
  noServer: true
});

const expressSessionParser = expressSession({
  secret: EXPRESS_SESSION_SECRET,
  saveUninitialized: true,
  resave: false
});

const expressApp = express();
expressApp.use(expressSessionParser);
expressApp.use(express.static('public'));

const httpServer = new http.Server(expressApp);

httpServer.on('upgrade', (serverReq, socket, head) => {
  // TODO: fix any typing
  expressSessionParser(serverReq as any, {} as any, () => {
    const req = serverReq as unknown as Express.Request;
    if (!req.session.user) {
      const id = uuidv4();
      req.session.user = {
        id
      };
    }
    wss.handleUpgrade(serverReq, socket, head, (ws) => {
      console.log(req.session)
      // emit a 'connection' event (handler above) with the create WebSocket and current session
      wss.emit('connection', ws, req)
    });
  });
});

httpServer.listen(HTTP_PORT, () => {
  console.log(`Server is running on ${HTTP_PORT}!`)
});

wss.on('connection', function (ws, serverReq) {
  // Initial connection logic
  const req = serverReq as unknown as Express.Request;
  const { user } = req.session;
  const userIdMessage = `User Session ID: ${user ? user.id : 'No user ID'}`;
  ws.send(userIdMessage);
  console.log(`[Sent] ${userIdMessage}`)

  // Error logic
  ws.on('error', console.error);

  ws.on('message', (message: string) => {
    // TODO: receive message logic
  });
});