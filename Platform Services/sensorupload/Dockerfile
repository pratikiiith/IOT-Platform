FROM python:3
COPY requirements.txt ./

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt
ADD sensorupload.py .
CMD ["python","-u","sensorupload.py"]
