FROM python:3.11-slim

# Cài đặt hệ thống và MS ODBC driver
RUN apt-get update && apt-get install -y curl gnupg2 unixodbc-dev gcc g++ \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Tạo thư mục app
WORKDIR /app

# Cài thư viện Python
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy toàn bộ mã nguồn
COPY . .

# Mặc định chạy ứng dụng (sửa nếu bạn dùng Flask hoặc FastAPI)
CMD ["python", "AI.py"]
