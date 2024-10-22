'''
Print AWS Credentials to the screen in a way that they won't show up in ~/.bash_history
'''

import pathlib
import pdb
import re


class Creds:

    SPACES = '    '
    LEADING_SPACE_REGEX = re.compile(r'\A ')
    FILENAME = pathlib.Path.home().joinpath('.aws', 'credentials')
    INTRO_LINE = f'{SPACES}# Paste these into terminal to access AWS'
    BASE_LINE = f'{SPACES}export HISTCONTROL=ignorespace'
    BLANK_LINE = SPACES
    COPY_LINE = f'{SPACES}sudo cp /root/.docker/config.json ~/.docker/config.json'
    OWNER_LINE = f'{SPACES}sudo chown jack.desert:jack.desert ~/.docker/config.json'
    OUTPUT = []
    SPLITTER = '[default]'
    KEYS_OF_INTEREST = (
        'aws_access_key_id',
        'aws_secret_access_key',
        'aws_session_token',
        'aws_security_token',
    )

    __slots__ = (
        'contents',
        'lines',
    )

    def __init__(self):
        with open(self.FILENAME, encoding='utf-8') as reader:
            data = reader.read()
        # Store everything after SPLITTER to conents
        self.contents = data.split(self.SPLITTER)[1]
        self.lines = []

    def _line_from_key(self, key):
        regex = re.compile(rf'^{key} = (\S+)$', flags=re.MULTILINE)
        match = regex.search(self.contents)
        if match is None:
            raise ValueError(f'content does not match regex for {key}')
        value = match.groups()[0]
        line = f'{self.SPACES}export {key.upper()}={value}'
        return line

    def print(self):
        lines = []
        lines.append(self.INTRO_LINE)
        lines.append(self.BLANK_LINE)
        lines.append(self.BASE_LINE)

        for key in self.KEYS_OF_INTEREST:
            lines.append(self._line_from_key(key))

        lines.append(self.COPY_LINE)
        lines.append(self.OWNER_LINE)

        for line in lines:
            if not self.LEADING_SPACE_REGEX.match(line):
                raise ValueError(f'Line "{line}" must have a leading space')

        output = '\n'.join(lines)
        output = f'\n\n{output}\n\n'
        print(output)


if __name__ == '__main__':
    creds = Creds()
    creds.print()
