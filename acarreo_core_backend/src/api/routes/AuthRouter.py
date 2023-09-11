from flask import Blueprint, Response
from api.app.Services.AuthService import AuthService
from api.app.Controllers.AuthController import login


auth_router = Blueprint("auth", __name__)
auth_service = AuthService()

auth_router.route("/login", methods=["POST"], defaults={"service": auth_service})(login)


@auth_router.route("/logout", methods=["DELETE"], defaults={"service": auth_service})
def logout(service):
    return Response(status=204)
