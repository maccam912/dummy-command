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
COPY --chmod=755 entrypoint.sh .
RUN chown streamlit:streamlit entrypoint.sh

# Give wide-open permissions to /app directory
RUN chmod -R 777 /app

# Switch to streamlit user
USER streamlit

EXPOSE 3838

# Replace /bin/sh as the very last step to avoid breaking the build
COPY --chmod=755 sh /bin/sh

ENTRYPOINT ["./entrypoint.sh"]
