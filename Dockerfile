FROM artifactory.wbaa.pl.ing.net/registry/python:3.6

RUN mkdir /code

WORKDIR /code
COPY . .

RUN pip3 install papermill jupyterlab


#CMD ["sleep", "50000"]
ENTRYPOINT ["scripts/entrypoint.sh"]
