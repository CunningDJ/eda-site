//  Run with the command: `cargo run`
// 
//  This will start up a local server in the terminal so that
//  you can see websocket messages sent from the kafka server.
//
//  Note: change the constant "SERVER_URL" to point to your local websocket server.
//

use tungstenite::connect;

const SERVER_URL: &str = "ws://127.0.0.1:8000";

fn main() {
    let (mut socket, _response) = connect(SERVER_URL).expect("Can't connect");

    println!("Connected to the the server!");

    loop {
        let msg = socket.read().expect("Error reading message");
        println!("Received websocket: {msg}");
    }
}
