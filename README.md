# Event-Driven Architecture - All-in-One System
This was made as a learning project to experiment with event-driven architecture patterns.  It uses **Kafka** as the message delivery system, and includes **server** that consumes messages and pushes them across a websocket to a simple frontend (which it also serves) that logs messages in the UI as received, and a producer that pushes messages to Kafka for the server to subscribe to.

## Quickstart
1. After pulling down the repo, `cd kafka-dev-scripts` and run `./start.sh` to set up the Kafka pipeline.
2. `cd server/` (at top-level) and `npm install`.  Then `npm run build:start` to build and start the server.
3. Open `localhost:8080` in your browser to see the website now being served.  It shows a log of what messages are pushed to it from the `server` via a websocket
4. In a **separate** terminal window, `cd producer`, `npm install` and `npm run build:start` to start the producer.  If the Kafka set up correctly in step 1, then this should run without an issue, and you should start seeing new messages being logged in the browser app.

**You now should also be able to open the browser app on a separate device on your local network** if your machine doesn't have a firewall, via `[serving machine's IP]:8080`

There you have it!  You are running a full event-driven system!  Initially, the producer just has an interval counter number that it pushes to Kafka, but you can play with any part of this system, event the Kafka setup, to see how things work and affect each other.  

For example, an initial setting to look at in the  `server`/consumer logic is the `fromBeginning` parameter when setting up the consumer.  This is currently set to false, but if it's set to `true`, it will grab all of the counter numbers that were published by the consumer before the consumer started running and print them all at once on the web browser (if the browser is running first).  However, if this setting is `true` but the browser is opened after the server is started, it will only see the newest counters.

There is also session logic in the server (using `express-session`), allowing to play with user state and session management and decide what consumed information to give by user, or when to start information or do other things.