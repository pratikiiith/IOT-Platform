FROM python:3
COPY requirements.txt .

RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt
ADD ./RequestManager/combined.py .
ADD ./RequestManager/sensorupload.py .
ADD ./RequestManager/test.json .
ADD ./RequestManager/test.py .
ADD ./RequestManager/codes ./codes
ADD ./RequestManager/static ./static
ADD ./RequestManager/templates ./templates
CMD ["python","-u","sensorupload.py"]
