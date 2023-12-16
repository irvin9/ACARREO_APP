from flask import Blueprint
from api.app.Controllers.CustomerController import index, find, store, update, delete
from api.app.Services.CustomerService import CustomerService
from api.app.Midlewares.auth import auth_midleware

customer_router = Blueprint('customer', __name__)
_service = CustomerService()


@customer_router.route("/", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _index(service):
    return index(service)


@customer_router.route("/", methods=["POST"], defaults={"service": _service})
@auth_midleware
def _store(service):
    return store(service)


@customer_router.route("/<id>", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _find(service, id):
    return find(service, id)


@customer_router.route("/<id>", methods=["PUT"], defaults={"service": _service})
@auth_midleware
def _update(service, id):
    return update(service, id)


@customer_router.route("/<id>", methods=["DELETE"], defaults={"service": _service})
@auth_midleware
def _delete(service, id):
    return delete(service, id)
