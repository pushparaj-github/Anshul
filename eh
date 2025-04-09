from azure.eventhub import EventHubConsumerClient

connection_str = "<your-connection-string>"
eventhub_name = "<your-eventhub-name>"
consumer_group = "<your-consumer-group>"

client = EventHubConsumerClient.from_connection_string(
    conn_str=connection_str,
    consumer_group=consumer_group,
    eventhub_name=eventhub_name
)

with client:
    partition_ids = client.get_partition_ids()
    for partition_id in partition_ids:
        props = client.get_partition_properties(partition_id)
        print(f"Partition: {partition_id}")
        print(f"  Last enqueued sequence number: {props['last_enqueued_sequence_number']}")
        print(f"  Last enqueued time: {props['last_enqueued_time_utc']}")
