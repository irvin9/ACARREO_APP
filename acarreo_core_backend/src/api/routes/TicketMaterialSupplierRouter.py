from flask import Blueprint
from api.app.Controllers.TicketmaterialsupplierController import index, find, store, update, delete
from api.app.Services.TicketMaterialSupplierService import TicketmaterialsupplierService
from api.app.Midlewares.auth import auth_midleware


ticketMaterialSupplier_router = Blueprint('ticketmaterialsupplier', __name__)
_service = TicketmaterialsupplierService()


@ticketMaterialSupplier_router.route("/", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _index(service):
    return index(service)


@ticketMaterialSupplier_router.route("/", methods=["POST"], defaults={"service": _service})
@auth_midleware
def _store(service):
    return store(service)


@ticketMaterialSupplier_router.route("/<id>", methods=["GET"], defaults={"service": _service})
@auth_midleware
def _find(service, id):
    return find(service, id)


@ticketMaterialSupplier_router.route("/<id>", methods=["PUT"], defaults={"service": _service})
@auth_midleware
def _update(service, id):
    return update(service, id)


@ticketMaterialSupplier_router.route("/<id>", methods=["DELETE"], defaults={"service": _service})
@auth_midleware
def _delete(service, id):
    return delete(service, id)