#!/usr/bin/env python
import pika

username='root-788d6b7f-1981-c835-ddc6-7943386b1338'
password='0bcde08a-f081-eaf3-7eb3-8383fcafe3e8'
cred=pika.PlainCredentials(username=username, password=password)
connection = pika.BlockingConnection(
    pika.ConnectionParameters(host='10.62.105.17', port=5672, virtual_host='/', credentials=cred))
channel = connection.channel()

channel.queue_declare(queue='hello')

print channel.basic_publish(exchange='', routing_key='hello', body='Hello World!')
print(" [x] Sent 'Hello World!'")
connection.close()
