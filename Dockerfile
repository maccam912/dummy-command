FROM python:3.9-slim

WORKDIR /app
COPY index.html .

# Create an entrypoint script that will run the server and then execute any additional commands
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Add our fake echo command
COPY pip /usr/local/bin/pip
RUN chmod +x /usr/local/bin/pip

#ENTRYPOINT ["/app/entrypoint.sh"]
