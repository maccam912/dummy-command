import http.server
import ssl
import os
from generate_cert import generate_self_signed_cert

def run_https_server(port=8443):
    # Generate certificate if not exists
    if not (os.path.exists("server.crt") and os.path.exists("server.key")):
        generate_self_signed_cert()

    # Create HTTP server
    server_address = ('', port)
    httpd = http.server.HTTPServer(server_address, http.server.SimpleHTTPRequestHandler)

    # Create SSL context
    context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    context.load_cert_chain('server.crt', 'server.key')

    # Wrap the socket with SSL
    httpd.socket = context.wrap_socket(httpd.socket, server_side=True)

    print(f"Serving HTTPS on port {port}...")
    httpd.serve_forever()

if __name__ == "__main__":
    run_https_server()
