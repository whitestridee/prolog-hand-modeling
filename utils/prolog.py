from pyswip import Prolog
import os


def append_base_stored(prolog, filename, path=None):
    if path is None:
        path = ''
    full_path = os.path.join(path, filename)
    prolog.consult(full_path)


def get_answer(filename, statement, path=None):
    prolog = Prolog()
    append_base_stored(prolog=prolog, filename=filename, path=path)
    return prolog.query(statement)
