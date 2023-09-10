from flask import Blueprint
from api.app.Controllers.MaterialesController import index, find, store, update, delete
from api.app.Services.MaterialesService import MaterialesService

materiales_router = Blueprint('materiales', __name__)
materiales_service = MaterialesService()

materiales_router.route('/', methods=['GET'], defaults={'service': materiales_service}) (index)
materiales_router.route('/', methods=['POST'], defaults={'service': materiales_service}) (store)
materiales_router.route('/<id>', methods=['GET'], defaults={'service': materiales_service}) (find)
materiales_router.route('/<id>', methods=['PUT'], defaults={'service': materiales_service}) (update)
materiales_router.route('/<id>', methods=['DELETE'], defaults={'service': materiales_service}) (delete)