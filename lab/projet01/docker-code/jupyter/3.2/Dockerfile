##
## Jupyter: image creation
##
FROM debian:11.1

MAINTAINER "your name" <your email>

# expose ports for other containers
EXPOSE 8888

# Set up directory requirements
RUN mkdir -p /opt/projet01/temp
RUN mkdir -p /opt/projet01/data-shared
RUN mkdir -p /opt/jupyter/logs
RUN mkdir -p /opt/jupyter/python-code
RUN mkdir -p /opt/jupyter/bash-code
RUN mkdir -p /opt/jupyter/scripts
RUN mkdir -p /opt/jupyter/config
RUN mkdir -p /opt/jupyter/software
RUN mkdir -p /opt/jupyter/jupyter-code
RUN mkdir -p /opt/jupyter/datasets

# setup spark lib
COPY config /opt/jupyter/config
COPY software /opt/jupyter/software

# copy scripts
COPY scripts/docker-entrypoint.sh /opt/jupyter/scripts
COPY scripts/docker-create-user.sh /opt/jupyter/scripts
COPY scripts/docker-healthcheck.sh /opt/jupyter/scripts
COPY scripts/docker-install-software.sh /opt/jupyter/scripts
COPY scripts/password-convert-sha256.py /opt/jupyter/scripts

# Create admin user
ARG USER_UID
ARG GROUP_GID
ARG UNAME
ENV USER_UID=$USER_UID
ENV GROUP_GID=$GROUP_GID
ENV UNAME=$UNAME
ENV JUPYTER_SETUP=$JUPYTER_SETUP
ENV JUPYTER_PASSWORD=$JUPYTER_PASSWORD
ENV LOGPATH="/opt/jupyter/logs"
ENV LOGUSER="docker-create_user.log"
ENV LOGENTRY="docker-entrypoint.log"
ENV LOGERROR="docker-entrypoint_error.log"
ENV NOTEBOOKDIR="/opt/jupyter/notebook01"

# Install jupyter
RUN chmod -R 755 /opt/jupyter
RUN chown -R $USER_UID:$GROUP_GID /opt/jupyter
RUN sh /opt/jupyter/scripts/docker-create-user.sh
RUN sh /opt/jupyter/scripts/docker-install-software.sh

# change volume owner to apache owner
RUN chmod -R 755 /opt/jupyter
RUN chown -R $USER_UID:$GROUP_GID /opt/jupyter

# Working directory
WORKDIR /opt/jupyter

# Set mongodb environment
ENV PATH $PATH:/opt/jupyter/datasets
ENV HOME /opt/jupyter

# start bootstrap script
USER $USER_UID:$GROUP_GID
ENTRYPOINT ["/opt/jupyter/scripts/docker-entrypoint.sh"]
