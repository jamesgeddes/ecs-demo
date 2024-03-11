from flask import Flask, render_template, url_for
import os
import socket
import boto3
from json import loads
from requests import get
from random import randint
from uuid import uuid4
from random import choice
from datetime import datetime

app = Flask(__name__)
port = 5000
dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("catfacts")
s3 = boto3.client("s3")


def list_s3_objects(bucket_name):
    """List the objects in an S3 bucket."""
    objects = s3.list_objects_v2(Bucket=bucket_name)
    return [obj["Key"] for obj in objects.get("Contents", [])]


def select_random_object(bucket_name):
    """Select a random object from an S3 bucket."""
    objects = list_s3_objects(bucket_name)
    if not objects:
        return None
    return choice(objects)


def download_object(bucket_name, object_key, download_path):
    """Download an object from S3."""
    s3.download_file(bucket_name, object_key, download_path)


def write_value_to_database(attribute_name, attribute_value):
    day_of_year = datetime.today().timetuple().tm_yday
    if day_of_year != randint(a=1, b=365):
        # Prevent the database from getting too many cat facts
        return 0
    record_id = str(uuid4())
    table.put_item(Item={"id": record_id, attribute_name: attribute_value})
    return record_id


def get_random_catfact_from_database():
    response = table.scan(ProjectionExpression="id")
    items = response.get("Items", [])

    if not items:
        return "No cat facts found."

    random_item_id = choice(items)["id"]
    response = table.get_item(Key={"id": random_item_id})
    item = response.get("Item", None)

    if item:
        return item["catfact_text"]
    else:
        return "Cat fact not found."


def get_new_catfact():
    response = get(url="https://catfact.ninja/fact")
    if response.status_code == 200:
        catfact_content = loads(response.text)["fact"]
        return catfact_content


@app.route("/")
def index():
    container_id = (
        os.popen("hostname").read().strip()
    )  # Container ID is the hostname in Docker
    webserver_ip = socket.gethostbyname(socket.gethostname())  # Get server IP address

    new_catfact = get_new_catfact()
    write_value_to_database(attribute_name="catfact_text", attribute_value=new_catfact)
    existing_catfact = get_random_catfact_from_database()

    artefacts_bucket = "ecs-demo-global-artefacts-bucket"

    selected_file = select_random_object(bucket_name=artefacts_bucket)
    download_object(
        bucket_name=artefacts_bucket,
        object_key=selected_file,
        download_path="static/random.jpg",
    )

    data = {
        "webserver_ip": webserver_ip,
        "container_id": container_id,
        "port": port,
        "random_file": url_for("static", filename="random.jpg"),
        "db_value": existing_catfact,
    }

    return render_template("index.html", **data)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=port)
