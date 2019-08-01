FROM mongo
COPY ./keyfile ./
USER root
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN chmod 400 ./keyfile
CMD mongod --config ./mongod.conf
