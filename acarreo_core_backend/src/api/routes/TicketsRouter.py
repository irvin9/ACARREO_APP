from flask import Blueprint
from api.app.Controllers.TicketsController import index, find, store, update, delete
from api.app.Services.TicketsService import TicketsService

tickets_router = Blueprint('tickets', __name__)
tickets_service = TicketsService()

tickets_router.route('/', methods=['GET'], defaults={'service': tickets_service}) (index)
tickets_router.route('/', methods=['POST'], defaults={'service': tickets_service}) (store)
tickets_router.route('/<id>', methods=['GET'], defaults={'service': tickets_service}) (find)
tickets_router.route('/<id>', methods=['PUT'], defaults={'service': tickets_service}) (update)
tickets_router.route('/<id>', methods=['DELETE'], defaults={'service': tickets_service}) (delete)