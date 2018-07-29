_#!/bin/bash

SERVER_CONFIG_FILE=/opt/kafka/config/server.properties

cat <<EOM >$SERVER_CONFIG_FILE
broker.id=${KAFKA_BROKER_ID:-0}
listeners=PLAINTEXT://0.0.0.0:${KAFKA_LISTENER_PORT:-9092}
advertised.listeners=PLAINTEXT://${KAFKA_ADVERTISED_HOSTNAME:-$(hostname)}:${KAFKA_LISTENER_PORT:-9092}
num.network.threads=${KAFKA_NUM_NETWORK_THREADS:-3}
num.io.threads=${KAFKA_NUM_IO_THREADS:-8}
socket.send.buffer.bytes=${KAFKA_SOCKET_SEND_BUFFER_BYTES:-102400}
socket.receive.buffer.bytes=${KAFKA_SOCKET_RECEIVE_BUFFER_BYTES:-102400}
socket.request.max.bytes=${KAFKA_SOCKET_REQUEST_MAX_BYTES:-104857600}
log.dirs=${KAFKA_LOG_DIRS:-/tmp/kafka-logs}
num.partitions=${KAFKA_NUM_PARTITIONS:-1}
num.recovery.threads.per.data.dir=${KAFKA_NUM_RECOVERY_THREADS_PER_DATA_DIR:-1}
offsets.topic.replication.factor=${KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR:-1}
transaction.state.log.replication.factor=${KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR:-1}
transaction.state.log.min.isr=${KAFKA_TRANSACTION_STATE_LOG_MIN_ISR:-1}
log.retention.hours=${KAFKA_LOG_RETENTION_HOURS:-168}
log.segment.bytes=${KAFKA_LOG_SEGMENT_BYTES:-1073741824}
log.retention.check.interval.ms=${KAFKA_LOG_RETENTION_CHECK_INTERVAL_MS:-300000}
zookeeper.connect=${KAFKA_ZOOKEEPER_CONNECT:-zookeeper:2181}
zookeeper.connection.timeout.ms=${KAFKA_ZOOKEEPER_CONNECTION_TIMEOUT_MS:-6000}
group.initial.rebalance.delay.ms=${KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS:-0}
EOM

/opt/kafka/bin/kafka-server-start.sh $SERVER_CONFIG_FILE
