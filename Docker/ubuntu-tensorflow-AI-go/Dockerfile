FROM  arwineap/docker-ubuntu-python3.6
MAINTAINER yangboz "z@smartkit.info"
RUN apt-get update -y
#RUN apt-get install -y python-pip python-dev build-essential
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["main.py preprocess data/2017"]