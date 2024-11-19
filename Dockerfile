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
COPY https_server.py .

# Copy and set up entrypoint
COPY --chmod=777 entrypoint.sh .

# Copy streamlit command to /usr/bin
COPY --chmod=777 streamlit /usr/bin/streamlit

# Set up app directory permissions
RUN chown -R streamlit:streamlit /app

# Switch to streamlit user
USER streamlit

EXPOSE 8443

ENTRYPOINT ["./entrypoint.sh"]
