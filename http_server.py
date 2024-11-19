from http.server import HTTPServer, SimpleHTTPRequestHandler
import os

def run(server_class=HTTPServer, handler_class=SimpleHTTPRequestHandler):
    server_address = ('', 3838)
    httpd = server_class(server_address, handler_class)
    print(f'Starting HTTP server on port {server_address[1]}...')
    httpd.serve_forever()

if __name__ == '__main__':
    os.chdir('/app')  # Ensure we serve from /app directory
    run()
