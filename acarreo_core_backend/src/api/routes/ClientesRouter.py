from flask import Blueprint
from api.app.Controllers.ClientesController import index, find, store, update, delete
from api.app.Services.ClientesService import ClientesService
from api.app.Midlewares.auth import auth_midleware

clientes_router = Blueprint("clientes", __name__)
_service = ClientesService()


@clientes_router.route("/", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _index(service):
    return index(service)


@clientes_router.route("/", methods=["POST"], defaults={"service": _service})
@auth_midleware
def _store(service):
    return store(service)


@clientes_router.route("/<id>", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _find(service, id):
    return find(service, id)


@clientes_router.route("/<id>", methods=["PUT"], defaults={"service": _service})
@auth_midleware
def _update(service, id):
    return update(service, id)


@clientes_router.route("/<id>", methods=["DELETE"], defaults={"service": _service})
@auth_midleware
def _delete(service, id):
    return delete(service, id)
