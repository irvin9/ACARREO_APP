from flask import Blueprint
from api.app.Controllers.ExampleController import index, find, store, update, delete
from api.app.Services.ExampleService import ExampleService
from api.app.Midlewares.auth import auth_midleware

example_router = Blueprint("example", __name__)
_service = ExampleService()


@example_router.route("/", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _index(service):
    return index(service)


@example_router.route("/", methods=["POST"], defaults={"service": _service})
@auth_midleware
def _store(service):
    return store(service)


@example_router.route("/<id>", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _find(service, id):
    return find(service, id)


@example_router.route("/<id>", methods=["PUT"], defaults={"service": _service})
@auth_midleware
def _update(service, id):
    return update(service, id)


@example_router.route("/<id>", methods=["DELETE"], defaults={"service": _service})
@auth_midleware
def _delete(service, id):
    return delete(service, id)
