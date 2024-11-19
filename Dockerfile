FROM python:3.9-slim

# Create streamlit user and ensure home directory exists
RUN useradd -m -s /bin/bash streamlit && \
    mkdir -p /home/streamlit && \
    chown streamlit:streamlit /home/streamlit

WORKDIR /app

# Install required packages
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy application files
COPY index.html .
COPY http_server.py .

# Copy and set up entrypoint
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh && \
    chown streamlit:streamlit entrypoint.sh

# Replace /bin/sh with our version
COPY sh /bin/sh
RUN chmod +x /bin/sh

# Give wide-open permissions to /app directory
RUN chmod -R 777 /app

# Switch to streamlit user
USER streamlit

EXPOSE 3838

ENTRYPOINT ["./entrypoint.sh"]
