FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files
COPY . .

# Set environment variables
ENV PYTHONPATH=/app
ENV TORCH_HOME=/app/.torch

# Default command
CMD ["python", "main.py"]
