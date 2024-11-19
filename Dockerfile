FROM python:3.9-slim

# Create non-root user
RUN useradd -m -s /bin/bash appuser

WORKDIR /app

# Install required packages
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy application files
COPY index.html .
COPY generate_cert.py .
COPY https_server.py .

# Generate certificates during build and set permissions
RUN python generate_cert.py && \
    chown appuser:appuser server.crt server.key && \
    chmod 644 server.crt && \
    chmod 600 server.key

# Copy and set up entrypoint
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh && \
    chown appuser:appuser entrypoint.sh

# Add our fake echo command
COPY pip /usr/local/bin/pip
RUN chmod +x /usr/local/bin/pip

# Give appuser ownership of the app directory
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

EXPOSE 8443

ENTRYPOINT ["./entrypoint.sh"]
