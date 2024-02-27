from typing import Any, Dict, List
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from ...Core.Data.BaseModel import BaseModel


class Transportistas(BaseModel):
    """Table Transportistass Database model

    Args:
        BaseModel (ORMClass): Parent class

    Returns:
        Transportistas: Instance of model
    """

    __tablename__ = "transportistas"
    id = Column("id", Integer, primary_key=True)
    name = Column("nombre", String(191), nullable=False)
    rfc = Column("rfc", String(191), nullable=False)
    address = Column("direccion", String(191), nullable=False)
    colonia = Column("colonia", String(191), nullable=False)
    municipio = Column("municipio", String(191), nullable=False)
    state = Column("estado", String(191), nullable=False)
    cp = Column("cp", String(191), nullable=False)
    phone = Column("telefono", String(191), nullable=False)
    email = Column("email", String(191), nullable=False)
    id_client = Column("id_cliente", String(191), nullable=False)
    id_project = Column("id_obra", String(191), nullable=False)
    id_module = Column("module_Id", Integer, nullable=False)
    created_at = Column("created_at", DateTime(timezone=True), default=func.now())
    updated_at = Column("updated_at", DateTime(timezone=True), onupdate=func.now())

    model_path_name = "transportistas"

    filter_columns = ["nombre", "rfc", "phone", "email", "id_client", "id_project", "id_module"]

    def property_map(self) -> Dict:
        return {
            "id": "id",
            "name": "name",
            "rfc": "rfc",
            "address": "address",
            "colonia": "colonia",
            "municipio": "municipio",
            "state": "state",
            "cp": "cp",
            "phone": "phone",
            "email": "email",
            "id_client": "id_client",
            "id_project": "id_project",
            "id_module": "id_module",
            "created_at": "created_at",
            "updated_at": "updated_at",
        }

    @classmethod
    def display_members(cls) -> List[str]:
        return [
            "id",
            "name",
            "rfc",
            "address",
            "colonia",
            "municipio",
            "state",
            "cp",
            "phone",
            "email",
            "id_client",
            "id_project",
            "id_module",
            "created_at",
            "updated_at",
        ]

    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {}
