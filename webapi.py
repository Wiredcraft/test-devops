from flask import Flask, request
import subprocess

app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'ALIVE.'


@app.route("/api", methods=["POST"])
def resp_webhook():
    payload = request.get_json()
    def someone(s):
        try:
            subprocess.check_output(
                "ansible-playbook /root/playbook/deploy_%s.yml" %s,
                shell=True
            )
            return "OK"
        except:
            return "Fail"
    if "tags" in payload["ref"]:
        return someone("staging")
    else:
        return someone("test")


if __name__ == '__main__':
    app.run(
        host="0.0.0.0",
        port=80
    )
