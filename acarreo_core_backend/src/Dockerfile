# set base image (host OS)
FROM python:3.9-slim



# set the working directory in the container
WORKDIR /code

ENV FLASK_APP api
ENV FLASK_RUN_HOST 0.0.0.0
ENV FLASK_ENV development

# copy the dependencies file to the working directory
COPY requirements.txt requirements.txt

# install dependencies
RUN pip install -r requirements.txt

COPY . .

ENTRYPOINT ["bash", "./entrypoint.sh"]
