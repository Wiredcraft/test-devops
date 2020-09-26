class Config:
    def __init__(self, version):
        self.version = version

def parse_config(config_path):
    return Config(version='0.0.1')
