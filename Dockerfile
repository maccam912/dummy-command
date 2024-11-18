FROM python:3.9-slim

WORKDIR /app
COPY index.html .

# Create an entrypoint script that will run the server and then execute any additional commands
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
