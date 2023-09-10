from flask import Blueprint
from api.app.Controllers.ObrasController import index, find, store, update, delete
from api.app.Services.ObrasService import ObrasService

obras_router = Blueprint('obras', __name__)
obras_service = ObrasService()

obras_router.route('/', methods=['GET'], defaults={'service': obras_service}) (index)
obras_router.route('/', methods=['POST'], defaults={'service': obras_service}) (store)
obras_router.route('/<id>', methods=['GET'], defaults={'service': obras_service}) (find)
obras_router.route('/<id>', methods=['PUT'], defaults={'service': obras_service}) (update)
obras_router.route('/<id>', methods=['DELETE'], defaults={'service': obras_service}) (delete)