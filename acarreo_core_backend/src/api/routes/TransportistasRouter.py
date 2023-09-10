from flask import Blueprint
from api.app.Controllers.TransportistasController import index, find, store, update, delete
from api.app.Services.TransportistasService import TransportistasService

transportistas_router = Blueprint('transportistas', __name__)
transportistas_service = TransportistasService()

transportistas_router.route('/', methods=['GET'], defaults={'service': transportistas_service}) (index)
transportistas_router.route('/', methods=['POST'], defaults={'service': transportistas_service}) (store)
transportistas_router.route('/<id>', methods=['GET'], defaults={'service': transportistas_service}) (find)
transportistas_router.route('/<id>', methods=['PUT'], defaults={'service': transportistas_service}) (update)
transportistas_router.route('/<id>', methods=['DELETE'], defaults={'service': transportistas_service}) (delete)