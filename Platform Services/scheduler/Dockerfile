FROM python:3
COPY requirements.txt ./

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt
ADD scheduler.py .
CMD ["python","-u","scheduler.py"]
