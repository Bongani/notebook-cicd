FROM artifactory.wbaa.pl.ing.net/registry/python:3.6

RUN mkdir /code

WORKDIR /code
COPY . .
RUN pip3 install requirements.txt

RUN pip3 install papermill


CMD ["sleep", "50000"]
#
#docker

