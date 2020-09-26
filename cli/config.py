class Config:
    version: str

    def __init__(self, version: str):
        self.version = version


def parse_config(config_path: str):
    return Config(version='0.0.1')
