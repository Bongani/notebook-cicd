FROM python:3.6

RUN apt-get update

RUN apt-get -y install nano
RUN mkdir /code

WORKDIR /code
COPY . .

RUN pip3 install papermill jupyterlab

#CMD ["sleep", "50000"]
ENTRYPOINT ["scripts/entrypoint.sh"]

