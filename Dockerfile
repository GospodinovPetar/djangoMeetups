FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      gcc \
      libjpeg-dev \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip \
 && pip install --no-cache-dir \
      asgiref==3.8.1 \
      Django==5.2.3 \
      pillow==11.3.0 \
      sqlparse==0.5.3 \
      gunicorn==22.0.0

COPY . .

EXPOSE 8000

CMD ["sh", "-c", "python manage.py migrate && gunicorn django_course_site.wsgi:application --bind 0.0.0.0:8000 --workers 3"]