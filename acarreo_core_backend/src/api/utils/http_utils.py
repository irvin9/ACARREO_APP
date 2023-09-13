import jwt
import json
import decimal
import hashlib
import datetime
import Environment as env
from json.encoder import JSONEncoder
from typing import Tuple, cast
from flask import json, Response, request
from flask.wrappers import Request
from api.app.Data.Enum.http_status_code import HTTPStatusCode
from api.app.Exceptions.APIException import APIException


class CustomJSONDecoder(json.JSONEncoder):
    """Clase que ayuda con el manejo de JSON de un blob Storage de Azure"""

    def default(self, o):
        if isinstance(o, decimal.Decimal):
            if o % 1 > 0:
                return float(o)
            else:
                return int(o)
        if isinstance(o, bytes):
            return o.decode()
        if isinstance(o, (datetime.date, datetime.datetime)):
            return o.isoformat()
        return super(CustomJSONDecoder, self).default(o)


def build_response(status: int, body: dict, application_type: str = "application/json", jsonEncoder: JSONEncoder = CustomJSONDecoder, circular: bool = True, is_body_str: bool = False, encoder_extras: dict = {}) -> Response:
    """Devuelve el formato que acepta azure para una respuesta de HTTP

    Args:
        status (int): Codido http
        body (dict): Contenido del json de respuesta
        application_type (str, optional): Tipo de respuesta. Defaults to 'application/json'.
        jsonEncoder (JSONEncoder, optional): Codificacion el JSON de salida. Defaults to CustomJSONDecoder.
        circular (bool, optional): Inidica si la codificacion la hara por cada parametro del JSON. Defaults to True.

    Returns:
        func.HttpResponse: Respuesta HTTP aceptada por Azure
    """
    return Response(status=status, response=body if is_body_str else json.dumps(body, cls=jsonEncoder, check_circular=circular, **encoder_extras), mimetype=application_type)


def serialize_json(data: dict, jsonEncoder: JSONEncoder = CustomJSONDecoder, circular: bool = True) -> str:
    """Devuelve una cadena en formato JSON de un objeto

    Args:
        data (dict): Contenido del json de respuesta
        jsonEncoder (JSONEncoder, optional): Codificacion el JSON de salida. Defaults to CustomJSONDecoder.
        circular (bool, optional): Inidica si la codificacion la hara por cada parametro del JSON. Defaults to True.

    Returns:
        str: Cadena con formato JSON del contenido
    """
    return json.dumps(data, cls=jsonEncoder, check_circular=circular)


def get_paginate_params(req: Request) -> Tuple[bool, int, int]:
    """Devuelve los parametros de paginacion de una peticion http

    Args:
        req (func.HttpRequest): Peticion http

    Returns:
        Tuple[bool, int, int]: Parametros de paginacion (Paginado, num de pagina, elementos por pagina)
    """

    page = req.args.get("page")
    if page is not None:
        page = int(page)
    else:
        page = 1

    per_page = req.args.get("per_page")
    if per_page is not None:
        per_page = int(per_page)
    else:
        per_page = 10

    return (page, per_page)


def get_filter_params(req: Request) -> dict:
    """Obtiene filtros de query

    Args:
        req (dict): Peticion http

    Returns:
        dict: Filtros formados como par valor
    """
    if req.args is None:
        return {}

    ret_dict = {}
    for key in req.args.keys():
        if key == "page" or key == "per_page" or key == "relationships":
            pass
        else:
            ret_dict.update({key: req.args[key]})

    return ret_dict


def get_relationship_params(req: Request) -> dict:
    """Obtiene filtros de query

    Args:
        req (dict): Peticion http

    Returns:
        dict: Filtros formados como par valor
    """
    if req.args is None:
        return {}

    ret_dict = {}
    if "relationships" in req.args.keys():
        ret_dict.update(dict(relationships=req.args.getlist("relationships")))

    return ret_dict


def get_search_params(req: Request) -> dict:
    """Obtiene filtros de query

    Args:
        req (dict): Peticion http

    Returns:
        dict: Filtros formados como par valor
    """
    if req.args is None:
        return {}

    ret_dict = {}
    for k in req.args.keys():
        if str(k).startswith("search-"):
            key = str(k).split("-")[1]
            ret_dict[key] = str(req.args[k]).replace("*", "%")

    return ret_dict


def get_search_method_param(req: Request) -> str:
    """Obtiene el metodo de filtrado de query

    Args:
        req (dict): Peticion http

    Returns:
        str: Metodo de filtraddo
    """
    if req.args is None:
        return "AND"
    if "searchmethod" not in req.args:
        return "AND"

    method = str(req.args["searchmethod"]).upper()
    return "AND" if method not in ["AND", "OR"] else method


def parser_token():
    auth_header = cast(str, request.headers.get("Authorization"))
    if auth_header:
        auth_token = auth_header.split(" ")
        if len(auth_token) < 2:
            raise APIException("Bad token", HTTPStatusCode.UNAUTHORIZED.value)
        auth_token = auth_token[1]
    else:
        auth_token = None
    return auth_token


def decode_token(token):
    secret_key = env.APP_SECRET_KEY
    seed = env.APP_SEED
    combined_key = hashlib.sha256((secret_key + seed).encode()).hexdigest()
    data = jwt.decode(token, combined_key, algorithms=["HS256"])
    return data
