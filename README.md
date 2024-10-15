# Event-Driven Architecture - All-in-One System
This was made as a learning project to experiment with event-driven architecture patterns.  It uses **Kafka** as the message delivery system, and includes **server** that consumes messages and pushes them across a websocket to a simple frontend (which it also serves) that logs messages in the UI as received, and a producer that pushes messages to Kafka for the server to subscribe to.

## Quickstart
1. Install all node modules: `npm run install:all`
2. Set up and run Kafka: `npm run start:kafka`
3. Build and run the server/consumer: `npm run build:start:server`
4. Open the website at [localhost:8080](http://localhost:8080) in your browser.  Note the logging of messages received.
5. In a separate terminal window, build and run the producer: `npm run build:start:producer`.  Note how counters are now being logged on the website.

**You now should also be able to open the browser app on a separate device on your local network** if your machine doesn't have a firewall, via `[serving machine's IP]:8080`

There you have it!  You are running a full event-driven system!  Initially, the producer just has an interval counter number that it pushes to Kafka, but you can play with any part of this system, event the Kafka setup, to see how things work and affect each other.  

For example, an initial setting to look at in the  `server`/consumer logic is the `fromBeginning` parameter when setting up the consumer.  This is currently set to false, but if it's set to `true`, it will grab all of the counter numbers that were published by the consumer before the consumer started running and print them all at once on the web browser (if the browser is running first).  However, if this setting is `true` but the browser is opened after the server is started, it will only see the newest counters.

There is also session logic in the server (using `express-session`), allowing to play with user state and session management and decide what consumed information to give by user, or when to start information or do other things.