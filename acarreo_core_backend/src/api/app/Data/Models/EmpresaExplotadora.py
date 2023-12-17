from typing import Any, Dict, List
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from ...Core.Data.BaseModel import BaseModel


class EmpresaExplotadora(BaseModel):
    """ Table Empresasexplotadoras Database model

    Args:
        BaseModel (ORMClass): Parent class

    Returns:
        EmpresaExplotadora: Instance of model
    """
    __tablename__ = 'empresas_explotadoras'
    id = Column("id", Integer, primary_key=True)
    id_module = Column("module_Id", Integer, nullable=False)
    id_project = Column("id_obra", Integer, nullable=False)
    name = Column("nombre", String(191), nullable=False)
    address = Column("direccion", String(191), nullable=False)
    phone = Column("telefono", String(191), nullable=False)
    rfc = Column("rfc", String(191), nullable=False)
    created_at = Column("created_at", DateTime(timezone=True), default=func.now())
    updated_at = Column("updated_at", DateTime(timezone=True), onupdate=func.now())

    model_path_name = "EmpresaExplotadora"

    filter_columns = ["id_module", "id_project", "name", "address", "phone", "rfc"]

    def property_map(self) -> Dict:
        return {
            "id": "id",
            "id_module": "id_module",
            "id_project": "id_project",
            "name": "name",
            "address": "address",
            "phone": "phone",
            "rfc": "rfc",
            "created_at": "created_at",
            "updated_at": "updated_at",
        }

    @classmethod
    def display_members(cls) -> List[str]:
        return [
            "id",
            "id_module",
            "id_project",
            "name",
            "address",
            "phone",
            "rfc",
            "created_at",
            "updated_at"
        ]

    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {

        }
