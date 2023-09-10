from flask import Blueprint
from api.app.Controllers.ClientesController import index, find, store, update, delete
from api.app.Services.ClientesService import ClientesService

clientes_router = Blueprint('clientes', __name__)
clientes_service = ClientesService()

clientes_router.route('/', methods=['GET'], defaults={'service': clientes_service}) (index)
clientes_router.route('/', methods=['POST'], defaults={'service': clientes_service}) (store)
clientes_router.route('/<id>', methods=['GET'], defaults={'service': clientes_service}) (find)
clientes_router.route('/<id>', methods=['PUT'], defaults={'service': clientes_service}) (update)
clientes_router.route('/<id>', methods=['DELETE'], defaults={'service': clientes_service}) (delete)