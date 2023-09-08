from flask import Blueprint
from api.app.Controllers.CamionesController import index, find, store, update, delete
from api.app.Services.CamionesService import CamionesService

camiones_router = Blueprint('camiones', __name__)
camiones_service = CamionesService()

camiones_router.route('/', methods=['GET'], defaults={'service': camiones_service}) (index)
camiones_router.route('/', methods=['POST'], defaults={'service': camiones_service}) (store)
camiones_router.route('/<id>', methods=['GET'], defaults={'service': camiones_service}) (find)
camiones_router.route('/<id>', methods=['PUT'], defaults={'service': camiones_service}) (update)
camiones_router.route('/<id>', methods=['DELETE'], defaults={'service': camiones_service}) (delete)