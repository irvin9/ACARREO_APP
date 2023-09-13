from functools import wraps

from api.utils.http_utils import decode_token, parser_token
from api.app.Exceptions.APIException import APIException
from api.app.Controllers.ChecadoresController import find
from api.app.Data.Enum.http_status_code import HTTPStatusCode

from api.app.Services.ChecadoresService import ChecadoresService


def auth_midleware(func):
    @wraps(func)
    def decorator_func(*args, **kwargs):
        auth_token = parser_token()
        if auth_token:
            try:
                data = decode_token(auth_token)
                current_user = find(ChecadoresService(), data["id"])
                if current_user.status_code != HTTPStatusCode.OK.value:
                    raise APIException(
                        "Invalid Authentication token!",
                        HTTPStatusCode.UNAUTHORIZED.value,
                    )
                return func(*args, **kwargs)
            except Exception as e:
                print(e)
                raise APIException("Bad token", HTTPStatusCode.UNAUTHORIZED.value)

        raise APIException("There is no token in headers", HTTPStatusCode.UNAUTHORIZED.value)

    return decorator_func
