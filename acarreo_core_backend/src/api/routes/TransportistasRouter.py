from flask import Blueprint
from api.app.Controllers.TransportistasController import (
    index,
    find,
    store,
    update,
    delete,
)
from api.app.Services.TransportistasService import TransportistasService
from api.app.Midlewares.auth import auth_midleware

transportistas_router = Blueprint("transportistas", __name__)
_service = TransportistasService()


@transportistas_router.route("/", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _index(service):
    return index(service)


@transportistas_router.route("/", methods=["POST"], defaults={"service": _service})
@auth_midleware
def _store(service):
    return store(service)


@transportistas_router.route("/<id>", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _find(service, id):
    return find(service, id)


@transportistas_router.route("/<id>", methods=["PUT"], defaults={"service": _service})
@auth_midleware
def _update(service, id):
    return update(service, id)


@transportistas_router.route(
    "/<id>", methods=["DELETE"], defaults={"service": _service}
)
@auth_midleware
def _delete(service, id):
    return delete(service, id)
