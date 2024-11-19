from http.server import HTTPServer, SimpleHTTPRequestHandler
import os
import ssl

class HealthCheckHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/healthz':
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b'healthy')
        else:
            super().do_GET()

def run(server_class=HTTPServer, handler_class=HealthCheckHandler):
    server_address = ('', 8443)
    httpd = server_class(server_address, handler_class)
    
    # Configure SSL/TLS
    ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    ssl_context.load_cert_chain('/app/dash.crt', '/app/dash.key')
    httpd.socket = ssl_context.wrap_socket(httpd.socket, server_side=True)
    
    print(f'Starting HTTPS server on port {server_address[1]}...')
    httpd.serve_forever()

if __name__ == '__main__':
    os.chdir('/app')  # Ensure we serve from /app directory
    run()
