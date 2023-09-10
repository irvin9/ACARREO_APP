from flask import Blueprint
from api.app.Controllers.ChecadoresController import index, find, store, update, delete
from api.app.Services.ChecadoresService import ChecadoresService

checadores_router = Blueprint('checadores', __name__)
checadores_service = ChecadoresService()

checadores_router.route('/', methods=['GET'], defaults={'service': checadores_service}) (index)
checadores_router.route('/', methods=['POST'], defaults={'service': checadores_service}) (store)
checadores_router.route('/<id>', methods=['GET'], defaults={'service': checadores_service}) (find)
checadores_router.route('/<id>', methods=['PUT'], defaults={'service': checadores_service}) (update)
checadores_router.route('/<id>', methods=['DELETE'], defaults={'service': checadores_service}) (delete)