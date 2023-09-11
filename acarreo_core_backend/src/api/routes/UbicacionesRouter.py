from flask import Blueprint
from api.app.Controllers.UbicacionesController import index, find, store, update, delete
from api.app.Services.UbicacionesService import UbicacionesService
from api.app.Midlewares.auth import auth_midleware

ubicaciones_router = Blueprint("ubicaciones", __name__)
_service = UbicacionesService()


@ubicaciones_router.route("/", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _index(service):
    return index(service)


@ubicaciones_router.route("/", methods=["POST"], defaults={"service": _service})
@auth_midleware
def _store(service):
    return store(service)


@ubicaciones_router.route("/<id>", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _find(service, id):
    return find(service, id)


@ubicaciones_router.route("/<id>", methods=["PUT"], defaults={"service": _service})
@auth_midleware
def _update(service, id):
    return update(service, id)


@ubicaciones_router.route("/<id>", methods=["DELETE"], defaults={"service": _service})
@auth_midleware
def _delete(service, id):
    return delete(service, id)
