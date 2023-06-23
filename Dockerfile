FROM ubuntu:latest

RUN apt-get update && apt-get install -y python3

COPY app.py /app/app.py

RUN python3 /app/app.py
RUN python3 -c "print('hello world, This is Ali')"
