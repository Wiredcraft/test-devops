import argparse

from config import parse_config


def update_minor_version(version):
    sub_versions = version.split('.')
    minor = int(sub_versions[1]) + 1
    return f'{sub_versions[0]}.{minor}.{sub_versions[2]}'


def update_patch_version(version):
    sub_versions = version.split('.')
    patch = int(sub_versions[2]) + 1
    return f'{sub_versions[0]}.{sub_versions[1]}.{patch}'


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Maintain website.')
    parser.add_argument('stage', type=str, help='dev/staging')
    parser.add_argument('-c', '--config', type=str,
                        help='website config file path')
    args = parser.parse_args()

    stage = args.stage
    config = parse_config(args.config)

    if stage == 'dev':
        version = update_patch_version(config.version)
        print(version)
    elif stage == 'staging':
        version = update_minor_version(config.version)
        print(version)
    else:
        parser.print_help()
