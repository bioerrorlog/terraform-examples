import time
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient


def configure_aws_iot_client(client_id, host, port, root_ca_path, private_key_path, certificate_path):
    iot_client = AWSIoTMQTTClient(client_id)
    iot_client.configureEndpoint(host, port)
    iot_client.configureCredentials(root_ca_path, private_key_path, certificate_path)

    # Configure the client connection settings
    iot_client.configureAutoReconnectBackoffTime(1, 32, 20)
    iot_client.configureOfflinePublishQueueing(-1)
    iot_client.configureDrainingFrequency(2)
    iot_client.configureConnectDisconnectTimeout(10)
    iot_client.configureMQTTOperationTimeout(5)

    return iot_client


# Callback function to handle received messages
def message_received(client, userdata, message):
    print("Message received on topic {}: {}".format(message.topic, message.payload))
    perform_iot_device_action(message.payload)


def perform_iot_device_action(payload):
    # Implement your action here based on the message payload
    pass


def main():
    # Set your AWS IoT Core endpoint, certificate, and private key file paths
    host = "your-iot-endpoint.amazonaws.com"
    port = 8883
    root_ca_path = "/path/to/root_ca.pem"
    certificate_path = "/path/to/certificate.pem.crt"
    private_key_path = "/path/to/private.pem.key"

    # Configure the MQTT client
    client_id = "raspberry_pi_subscriber"
    topic = "your/iot/topic"

    iot_client = configure_aws_iot_client(client_id, host, port, root_ca_path, private_key_path, certificate_path)

    # Connect to AWS IoT Core
    iot_client.connect()
    print("Connected to AWS IoT Core")

    # Subscribe to the topic
    iot_client.subscribe(topic, 1, message_received)
    print("Subscribed to topic: {}".format(topic))

    # Keep the script running to listen for messages
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        iot_client.unsubscribe(topic)
        iot_client.disconnect()
        print("Disconnected.")


if __name__ == '__main__':
    main()
