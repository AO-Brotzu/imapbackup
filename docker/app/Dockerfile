FROM snakepacker/python:2.6

USER root

RUN apt-get update && apt-get -y install sudo && apt-get -y install iputils-ping  && apt-get -y install vim

RUN ln -s /usr/bin/python2.6 /usr/bin/python2 && ln -s /usr/bin/python2 /usr/bin/python

RUN ln -s /opt/aob/imapbackup/bin/imapbackup.sh /usr/bin/imapbackup

#creating user aob
RUN useradd -rm -d /opt/aob -s /bin/bash -g root -G sudo -u 1001 aob 
RUN echo 'aob:aob' | chpasswd

RUN mkdir -p    /opt/aob/imapbackup
RUN chmod -R -754  /opt/aob/imapbackup & chown -R aob /opt/aob 

USER aob

ENV IMAP_DOMAIN=pec.aobrotzu.it

WORKDIR /opt/aob/imapbackup/

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["sleep infinity"]