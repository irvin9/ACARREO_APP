from api.app.Core.Services.BaseService import BaseService
from api.app.Data.Models import Materiales


class MaterialesService(BaseService):
    def __init__(self) -> None:
        super().__init__(Materiales)