import { Consumer, ConsumerRunConfig, Kafka, Message, Producer } from 'kafkajs';

// Base Kafka Configuration
const BASE_CONFIG = {
  clientId: 'my-app',
  brokers: ['0.0.0.0:9092'],
  // brokers: ['kafka1:9092', 'kafka2:9092'],
};

// Kafka  Topics
export const TOPIC = {
  counter: 'counter-topic'
};

const kafka = new Kafka(BASE_CONFIG);

/*
 * PRODUCER
 */
export class EdaAppKafkaProducer {
  _base: Kafka;
  _prod: Producer;

  constructor() {
    this._base = kafka;
    this._prod = this._base.producer();
  }

  _send = async (topic: string, messages: Message[]): Promise<void> => {
    await this._prod.connect();
    await this._prod.send({
      topic,
      messages: messages.map(({ key, value }) => ({ key, value }))
    });
    await this._prod.disconnect();
  };

  sendCounter = async (count: number): Promise<void> => this._send(TOPIC.counter, [{
    key: 'counter',
    value: count.toString()
  }]);
}

/*
 * CONSUMERS
 */

export class EdaAppKafkaConsumer {
  _base: Kafka;
  _cons: Consumer;

  constructor(groupId: string) {
    this._base = kafka;
    this._cons = this._base.consumer({ groupId });
  }

  _connectAndSubscribe = async (topic: string, fromBeginning=true): Promise<void> => {
    await this._cons.connect();
    await this._cons.subscribe({ topic, fromBeginning });
  }

  connectAndSubscribe_counter = async(fromBeginning=true): Promise<void> => {
    this._connectAndSubscribe(TOPIC.counter, fromBeginning);
  }

  run = async (config: ConsumerRunConfig): Promise<void> => this._cons.run(config);
}
