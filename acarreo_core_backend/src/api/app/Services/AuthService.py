import jwt
import hashlib
import logging
import datetime
import Environment as env
from ...database.DBConnection import get_session
from api.app.Exceptions.APIException import APIException
from api.app.Data.Enum.http_status_code import HTTPStatusCode
from api.app.Services.ChecadoresService import ChecadoresService


class AuthService:
    def login(self, session, input_data: dict) -> dict:
        try:
            valid_user = self.validate_user_and_password(session, input_data)
            if valid_user == None:
                raise APIException(
                    "Credentials are incorrent!", HTTPStatusCode.BAD_REQUEST.value
                )
            expiration_time = datetime.datetime.utcnow() + datetime.timedelta(days=31)
            payload = {
                "id": valid_user["id"],
                "username": valid_user["user"],
                "exp": expiration_time,
            }
            secret_key = env.APP_SECRET_KEY
            seed = env.APP_SEED
            combined_key = hashlib.sha256((secret_key + seed).encode()).hexdigest()
            token = jwt.encode(payload, combined_key, algorithm="HS256")
            return {"token": token}
        except APIException as e:
            logging.exception("APIException occurred")
            raise e
        except Exception as e:
            logging.exception("Cannot make the request")
            raise e

    def validate_user_and_password(self, session, credentials):
        """User and Password Validator"""
        user = None
        if "user" in credentials and "password" in credentials:
            username = credentials.get("user", "")
            password = credentials.get("password", "")
            find_user = ChecadoresService().get_by_column(session, "user", username)
            if find_user:
                user = find_user.to_dict()
                return user if password == user["password"] else None
        return user
