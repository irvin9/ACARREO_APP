from flask import Blueprint
from api.app.Controllers.MaterialesController import index, find, store, update, delete
from api.app.Services.MaterialesService import MaterialesService
from api.app.Midlewares.auth import auth_midleware

materiales_router = Blueprint("materiales", __name__)
_service = MaterialesService()


@materiales_router.route("/", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _index(service):
    return index(service)


@materiales_router.route("/", methods=["POST"], defaults={"service": _service})
@auth_midleware
def _store(service):
    return store(service)


@materiales_router.route("/<id>", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _find(service, id):
    return find(service, id)


@materiales_router.route("/<id>", methods=["PUT"], defaults={"service": _service})
@auth_midleware
def _update(service, id):
    return update(service, id)


@materiales_router.route("/<id>", methods=["DELETE"], defaults={"service": _service})
@auth_midleware
def _delete(service, id):
    return delete(service, id)
