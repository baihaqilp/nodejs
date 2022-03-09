# pull the Node.js Docker image
FROM node
USER root
# create the directory inside the container
WORKDIR /usr/src/app

# copy the all files from local machine to container
COPY package*.json ./

# run npm install in our local machine
RUN npm install

# add the generated modules and all other files to the container
ADD . /usr/src/app/
# our app is running on port 5000 within the container, so need to expose it
EXPOSE 5001

# for execute docker in container bash
RUN mkdir -p /tmp/download && \
 curl -L https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz | tar -xz -C /tmp/download && \
 rm -rf /tmp/download/docker/dockerd && \
 mv /tmp/download/docker/docker* /usr/local/bin/ && \
 rm -rf /tmp/download && \
 groupadd -g 999 docker && \
 usermod -aG docker node
USER node
# the command that starts our app
CMD ["node", "index.js"]
