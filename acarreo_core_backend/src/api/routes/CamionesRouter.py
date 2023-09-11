from flask import Blueprint
from api.app.Controllers.CamionesController import index, find, store, update, delete
from api.app.Services.CamionesService import CamionesService
from api.app.Midlewares.auth import auth_midleware

camiones_router = Blueprint("camiones", __name__)
_service = CamionesService()


@camiones_router.route("/", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _index(service):
    return index(service)


@camiones_router.route("/", methods=["POST"], defaults={"service": _service})
@auth_midleware
def _store(service):
    return store(service)


@camiones_router.route("/<id>", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _find(service, id):
    return find(service, id)


@camiones_router.route("/<id>", methods=["PUT"], defaults={"service": _service})
@auth_midleware
def _update(service, id):
    return update(service, id)


@camiones_router.route("/<id>", methods=["DELETE"], defaults={"service": _service})
@auth_midleware
def _delete(service, id):
    return delete(service, id)
