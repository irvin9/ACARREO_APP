from flask import Blueprint
from api.app.Controllers.TicketsrecepcionController import index, find, store, update, delete
from api.app.Services.TicketsrecepcionService import TicketsrecepcionService

ticketsrecepcion_router = Blueprint('ticketsrecepcion', __name__)
ticketsrecepcion_service = TicketsrecepcionService()

ticketsrecepcion_router.route('/', methods=['GET'], defaults={'service': ticketsrecepcion_service}) (index)
ticketsrecepcion_router.route('/', methods=['POST'], defaults={'service': ticketsrecepcion_service}) (store)
ticketsrecepcion_router.route('/<id>', methods=['GET'], defaults={'service': ticketsrecepcion_service}) (find)
ticketsrecepcion_router.route('/<id>', methods=['PUT'], defaults={'service': ticketsrecepcion_service}) (update)
ticketsrecepcion_router.route('/<id>', methods=['DELETE'], defaults={'service': ticketsrecepcion_service}) (delete)