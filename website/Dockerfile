FROM python
WORKDIR /app

COPY . .
RUN mkdir static
RUN pip install -r requirements.txt
EXPOSE 5000

CMD ["python", "./app.py"]
