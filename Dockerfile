# Используем официальный образ Python
FROM python:3.9-slim

# Устанавливаем переменную окружения для предотвращения вывода буферизованных данных
ENV PYTHONUNBUFFERED 1

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем зависимости проекта (файлы: app.py и requirements.txt) в контейнер
COPY main.py .
COPY requirements.txt .
COPY datakuzeg.xlsx /app/datakuzeg.xlsx

# Устанавливаем зависимости Python из requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install pandas
RUN pip install openpyxl

# Определяем порт, который будет открыт в контейнере
EXPOSE 5000

# Добавляем readiness probe
HEALTHCHECK --interval=5s --timeout=3s \
  CMD curl -f http://localhost:5000/ || exit 1

# Команда для запуска приложения внутри контейнера
CMD ["python", "main.py"]