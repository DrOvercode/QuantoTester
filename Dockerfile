FROM python:3.12-slim

# Install system packages
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    poppler-utils \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Prevent Python from buffering output
ENV PYTHONUNBUFFERED=1

# Working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . .

# Render provides PORT automatically
CMD ["uvicorn", "core:app", "--host", "0.0.0.0", "--port", "10000"]
