FROM python:3.11-slim

# Cài driver MS SQL Server
RUN apt-get update && apt-get install -y curl gnupg unixodbc-dev gcc g++ \
  && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Tạo thư mục app
WORKDIR /app

# Copy file requirements
COPY requirements.txt .

# Cài thư viện Python
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy toàn bộ source code
COPY . .

# Command để chạy app Flask
CMD ["gunicorn", "AI:app", "--bind", "0.0.0.0:10000"]
