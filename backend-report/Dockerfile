FROM alpine
ADD app /app
WORKDIR /app
RUN apk add --no-cache curl py3-pip
RUN pip install -r requirements.txt \
    && curl https://storage.yandexcloud.net/cloud-certs/CA.pem \
    -o /usr/local/share/ca-certificates/YandexInternalRootCA.crt \
    && update-ca-certificates
ENTRYPOINT ["python"]
CMD ["app.py"]
EXPOSE 8080
