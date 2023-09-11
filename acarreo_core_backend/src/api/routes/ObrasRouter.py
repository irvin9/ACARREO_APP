from flask import Blueprint
from api.app.Controllers.ObrasController import index, find, store, update, delete
from api.app.Services.ObrasService import ObrasService
from api.app.Midlewares.auth import auth_midleware

obras_router = Blueprint("obras", __name__)
_service = ObrasService()


@obras_router.route("/", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _index(service):
    return index(service)


@obras_router.route("/", methods=["POST"], defaults={"service": _service})
@auth_midleware
def _store(service):
    return store(service)


@obras_router.route("/<id>", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _find(service, id):
    return find(service, id)


@obras_router.route("/<id>", methods=["PUT"], defaults={"service": _service})
@auth_midleware
def _update(service, id):
    return update(service, id)


@obras_router.route("/<id>", methods=["DELETE"], defaults={"service": _service})
@auth_midleware
def _delete(service, id):
    return delete(service, id)
