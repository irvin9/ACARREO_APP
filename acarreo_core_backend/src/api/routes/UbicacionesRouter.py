from flask import Blueprint
from api.app.Controllers.UbicacionesController import index, find, store, update, delete
from api.app.Services.UbicacionesService import UbicacionesService

ubicaciones_router = Blueprint("ubicaciones", __name__)
ubicaciones_service = UbicacionesService()

ubicaciones_router.route(
    "/", methods=["GET"], defaults={"service": ubicaciones_service}
)(index)
ubicaciones_router.route(
    "/", methods=["POST"], defaults={"service": ubicaciones_service}
)(store)
ubicaciones_router.route(
    "/<id>", methods=["GET"], defaults={"service": ubicaciones_service}
)(find)
ubicaciones_router.route(
    "/<id>", methods=["PUT"], defaults={"service": ubicaciones_service}
)(update)
ubicaciones_router.route(
    "/<id>", methods=["DELETE"], defaults={"service": ubicaciones_service}
)(delete)
