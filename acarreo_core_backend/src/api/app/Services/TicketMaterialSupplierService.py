from api.app.Core.Services.BaseService import BaseService
from api.app.Data.Models import TicketMaterialSupplier


class TicketmaterialsupplierService(BaseService):
    def __init__(self) -> None:
        super().__init__(TicketMaterialSupplier)