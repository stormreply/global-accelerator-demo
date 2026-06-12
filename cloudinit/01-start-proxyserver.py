#!/usr/bin/env python3
"""
minimalistic proxy server
- closing the connection after each request
- taking care of CORS
"""

import http.server
import os
import sys
import urllib.request

TARGET = "$global_accelerator_url"
PORT = 8080

print(f"BEGIN -- {os.path.basename(sys.argv[0])}")

class ProxyHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.close_connection = True

        try:
            with urllib.request.urlopen(TARGET, timeout=5) as resp:
                data = resp.read()
                content_type = resp.headers.get("Content-Type", "text/html")

            self.send_response(200)
            self.send_header("Access-Control-Allow-Origin", "*")
            self.send_header("Content-Type", content_type)
            self.send_header("Connection", "close")
            self.end_headers()
            self.wfile.write(data)
        except Exception as e:
            self.send_response(502)
            self.send_header("Access-Control-Allow-Origin", "*")
            self.send_header("Content-Type", "text/plain")
            self.send_header("Connection", "close")
            self.end_headers()
            self.wfile.write(str(e).encode())

    def log_message(self, format, *args):
        pass  # keep silence


if __name__ == "__main__":
    server = http.server.HTTPServer(("localhost", PORT), ProxyHandler)
    print(f"proxy running on {PORT}, aiming at {TARGET}")
    server.serve_forever()

print(f"END -- {os.path.basename(sys.argv[0])}")
