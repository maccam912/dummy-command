FROM python:3.9-slim

WORKDIR /app

# Install required packages
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy application files
COPY index.html .
COPY generate_cert.py .
COPY https_server.py .

# Create an entrypoint script that will run the server and then execute any additional commands
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Add our fake echo command
COPY pip /usr/local/bin/pip
RUN chmod +x /usr/local/bin/pip

EXPOSE 8443

ENTRYPOINT ["/app/entrypoint.sh"]
