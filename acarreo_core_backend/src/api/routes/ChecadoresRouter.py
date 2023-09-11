from flask import Blueprint
from api.app.Controllers.ChecadoresController import index, find, store, update, delete
from api.app.Services.ChecadoresService import ChecadoresService
from api.app.Midlewares.auth import auth_midleware

checadores_router = Blueprint("checadores", __name__)
_service = ChecadoresService()


@checadores_router.route("/", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _index(service):
    return index(service)


@checadores_router.route("/", methods=["POST"], defaults={"service": _service})
@auth_midleware
def _store(service):
    return store(service)


@checadores_router.route("/<id>", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _find(service, id):
    return find(service, id)


@checadores_router.route("/<id>", methods=["PUT"], defaults={"service": _service})
@auth_midleware
def _update(service, id):
    return update(service, id)


@checadores_router.route("/<id>", methods=["DELETE"], defaults={"service": _service})
@auth_midleware
def _delete(service, id):
    return delete(service, id)
