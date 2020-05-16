FROM python:3
COPY requirements.txt ./

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt
ADD serverlcm.py .
CMD ["python","-u","serverlcm.py"]
