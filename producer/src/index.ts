import { EdaAppKafkaProducer } from "../../shared/src/kafka"; //"@eda-site/shared";

async function main() {
  console.log('Starting producer!')
  const producer = new EdaAppKafkaProducer();

  const COUNTER_INTERVAL = 1000;
  let counter = 1;
  setInterval(async () => {
    producer.sendCounter(counter);
    console.log(`Counter sent: ${counter}`);
    counter++;
  }, COUNTER_INTERVAL);
}

main();