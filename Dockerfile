FROM python:3.11-slim

# Cài đặt MS ODBC driver và các công cụ cần thiết
RUN apt-get update && \
    apt-get install -y curl gnupg2 apt-transport-https gcc g++ unixodbc-dev && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Tạo thư mục ứng dụng
WORKDIR /app

# Cài đặt thư viện Python
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy toàn bộ mã nguồn vào container
COPY . .

# Khởi chạy ứng dụng
CMD ["python", "AI.py"]
