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

# Create and set permissions for config directories
RUN mkdir -p /.config /root/.config /home/streamlit/.config && \
    chmod 777 /.config /root/.config /home/streamlit/.config
RUN mkdir -p /.local /root/.local /home/streamlit/.local && \
    chmod 777 /.local /root/.local /home/streamlit/.local
RUN touch /app/dash.key && chmod 777 /app/dash.key
RUN touch /app/dash.crt && chmod 777 /app/dash.crt
# Switch to streamlit user
USER streamlit

EXPOSE 8443

ENTRYPOINT ["./entrypoint.sh"]
