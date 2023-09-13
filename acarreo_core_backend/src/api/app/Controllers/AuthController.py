import json
import logging
from flask import request
from api.app.Exceptions.APIException import APIException
from api.app.Data.Enum.http_status_code import HTTPStatusCode
from api.app.Services.AuthService import AuthService

from ...utils.http_utils import build_response, decode_token, parser_token
from ...database.DBConnection import (
    get_session,
)


def login(service: AuthService):
    session = get_session()
    try:
        input_params = request.get_json(silent=True)
        body: dict = service.login(session, input_data=input_params)
        response = json.dumps(body)
        status_code = HTTPStatusCode.OK.value
    except APIException as e:
        logging.exception("APIException occurred")
        response = json.dumps(e.to_dict())
        status_code = e.status_code
    except Exception:
        logging.exception("No se pudo realizar la consulta")
        body = dict(message="No se pudo realizar la consulta")
        response = body
        status_code = HTTPStatusCode.UNPROCESABLE_ENTITY.value
    finally:
        session.close()

    return build_response(status_code, response, is_body_str=True)


def verify_token(service: AuthService):
    session = get_session()
    try:
        token = parser_token()
        data_token = decode_token(token)
        user_id = data_token["id"]
        body: dict = service.verify_user(session, user_id)
        response = json.dumps(body)
        status_code = HTTPStatusCode.OK.value
    except APIException as e:
        logging.exception("APIException occurred")
        response = json.dumps(e.to_dict())
        status_code = e.status_code
    except Exception:
        logging.exception("No se pudo realizar la consulta")
        body = dict(message="No se pudo realizar la consulta")
        response = body
        status_code = HTTPStatusCode.UNPROCESABLE_ENTITY.value
    finally:
        session.close()

    return build_response(status_code, response, is_body_str=True)
