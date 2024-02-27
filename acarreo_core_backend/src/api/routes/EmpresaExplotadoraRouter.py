from flask import Blueprint
from api.app.Controllers.EmpresaExplotadoraController import index, find, store, update, delete
from api.app.Services.EmpresaExplotadoraService import EmpresaexplotadoraService
from api.app.Midlewares.auth import auth_midleware


empresaExplotadora_router = Blueprint('empresaexplotadora', __name__)
_service = EmpresaexplotadoraService()

@empresaExplotadora_router.route("/", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _index(service):
    return index(service)


@empresaExplotadora_router.route("/", methods=["POST"], defaults={"service": _service})
@auth_midleware
def _store(service):
    return store(service)


@empresaExplotadora_router.route("/<id>", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _find(service, id):
    return find(service, id)


@empresaExplotadora_router.route("/<id>", methods=["PUT"], defaults={"service": _service})
@auth_midleware
def _update(service, id):
    return update(service, id)


@empresaExplotadora_router.route("/<id>", methods=["DELETE"], defaults={"service": _service})
@auth_midleware
def _delete(service, id):
    return delete(service, id)