from api.app.Core.Services.BaseService import BaseService
from api.app.Data.Models import Ubicaciones


class UbicacionesService(BaseService):
    def __init__(self) -> None:
        super().__init__(Ubicaciones)
