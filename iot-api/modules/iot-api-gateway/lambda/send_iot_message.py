import boto3
import json


def send_iot_message(topic, message):
    iot_client = boto3.client("iot-data")
    payload = json.dumps(message)
    response = iot_client.publish(topic=topic, qos=1, payload=payload)

    return response


def lambda_handler(event, context):
    topic = "poc/bioerrorlog"
    message = {"message": "Hello from Lambda"}
    response = send_iot_message(topic, message)

    api_gateway_response = {
        "statusCode": 200,
        "body": json.dumps({"message": "Message sent to IoT Core"}),
        "headers": {"Content-Type": "application/json"}
    }

    return api_gateway_response
