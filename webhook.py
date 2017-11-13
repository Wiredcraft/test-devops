# -*- coding: utf-8 -*-

import BaseHTTPServer
import cgi
import json
import sys
from git import Repo  

reload(sys)  
sys.setdefaultencoding('utf8')

class MyHandler(BaseHTTPServer.BaseHTTPRequestHandler):
    def do_POST(self):
        if self.path == '/getcommitfile':
            self.send_response(200)
            self.send_header("Content-type", "text/html")
            self.end_headers()
            form = cgi.FieldStorage(
            fp=self.rfile, 
            headers=self.headers,
            environ={'REQUEST_METHOD':'POST',
                     'CONTENT_TYPE':self.headers['Content-Type'],
                     })
            form_string = form.value
            json_string = json.loads(form_string)
            commit_message =  json_string['head_commit']['message']
            print commit_message
            if 'dev' in commit_message:
                repo = Repo('/opt/hugo/dev/test-devops')
                git = repo.git
                git.checkout('shenyi')
                git.pull('origin', 'shenyi')
                return
            elif 'staging' in commit_message:
                repo = Repo('/opt/hugo/staging/test-devops')
                git = repo.git
                git.checkout('shenyi')
                git.pull('origin', 'shenyi')
                return
            return

if __name__ == '__main__':
    server_class = BaseHTTPServer.HTTPServer
    httpd = server_class(('', 8055), MyHandler)
    httpd.serve_forever()