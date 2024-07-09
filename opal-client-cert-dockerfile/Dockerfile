FROM permitio/opal-client-cedar:0.7.1
USER root
RUN pip3 install certifi
RUN chmod 777 /usr/local/lib/python3.10/site-packages/certifi
COPY certs/opal-server-cert.crt /usr/local/share/ca-certificates/
COPY certs/apigee-sit.crt /usr/local/share/ca-certificates/
COPY certs/apigee-uat.crt /usr/local/share/ca-certificates/
COPY certs/apigee-prod.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates
RUN cat /etc/ssl/certs/opal-server-cert.pem >> /usr/local/lib/python3.10/site-packages/certifi/cacert.pem
RUN cat /etc/ssl/certs/apigee-sit.pem >> /usr/local/lib/python3.10/site-packages/certifi/cacert.pem
RUN cat /etc/ssl/certs/apigee-uat.pem >> /usr/local/lib/python3.10/site-packages/certifi/cacert.pem
RUN cat /etc/ssl/certs/apigee-prod.pem >> /usr/local/lib/python3.10/site-packages/certifi/cacert.pem
