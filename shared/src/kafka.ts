import { Kafka } from 'kafkajs';

const BASE_CONFIG = {
  clientId: 'my-app',
  brokers: ['kafka1:9092', 'kafka2:9092'],
};

const kafka = new Kafka(BASE_CONFIG);

export default kafka;
