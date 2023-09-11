import hashlib
import jwt
import Environment as env

from functools import wraps
from typing import cast
from flask import request

from api.app.Exceptions.APIException import APIException
from api.app.Data.Enum.http_status_code import HTTPStatusCode

from api.app.Services.ChecadoresService import ChecadoresService
from api.app.Controllers.ChecadoresController import find


def auth_midleware(func):
    @wraps(func)
    def decorator_func(*args, **kwargs):
        auth_header = cast(str, request.headers.get("Authorization"))
        if auth_header:
            auth_token = auth_header.split(" ")
            if len(auth_token) < 2:
                raise APIException("Bad token", HTTPStatusCode.UNAUTHORIZED.value)
            auth_token = auth_token[1]
        else:
            auth_token = None

        if auth_token:
            try:
                secret_key = env.APP_SECRET_KEY
                seed = env.APP_SEED
                combined_key = hashlib.sha256((secret_key + seed).encode()).hexdigest()
                data = jwt.decode(auth_token, combined_key, algorithms=["HS256"])
                current_user = find(ChecadoresService(), data["id"])

                if current_user is None:
                    raise APIException(
                        "Invalid Authentication token!",
                        HTTPStatusCode.UNAUTHORIZED.value,
                    )
                return func(current_user, *args, **kwargs)
            except Exception:
                raise APIException("Bad token", HTTPStatusCode.UNAUTHORIZED.value)

        raise APIException(
            "There is no token in headers", HTTPStatusCode.UNAUTHORIZED.value
        )

    return decorator_func
