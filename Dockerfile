FROM python:3.8

ADD . .
RUN pip install -r requirements.txt
EXPOSE 11001
ENTRYPOINT ["bash","-c","python3 ./locust_exporter.py 11001 locust-master:8089"]