FROM python:3
COPY requirements.txt ./

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt
ADD sensorregistration.py .
CMD ["python","-u","sensorregistration.py"]
