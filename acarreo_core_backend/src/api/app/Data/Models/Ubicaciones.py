from typing import Any, Dict, List
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from ...Core.Data.BaseModel import BaseModel


class Ubicaciones(BaseModel):
    """Table ubicacioness Database model

    Args:
        BaseModel (ORMClass): Parent class

    Returns:
        ubicaciones: Instance of model
    """

    __tablename__ = "ubicaciones"
    id = Column("id", Integer, primary_key=True)
    name = Column("nombre", String(191), nullable=False)
    latitude = Column("latitud", String(191), nullable=False)
    longitude = Column("longitud", String(191), nullable=False)
    state = Column("estatus", Integer, nullable=False)
    type = Column("tipo", String(191), nullable=False)
    id_client = Column("id_cliente", Integer, nullable=False)
    id_project = Column("id_obra", Integer, nullable=False)
    id_label = Column("id_etiqueta", Integer, nullable=True)
    id_module = Column("module_Id", Integer, nullable=False)
    created_at = Column("created_at", DateTime(timezone=True), default=func.now())
    updated_at = Column("updated_at", DateTime(timezone=True), onupdate=func.now())

    model_path_name = "ubicaciones"

    filter_columns = ["name", "state", "id_client", "id_label", "id_project", "type", "folio", "id_module"]

    def property_map(self) -> Dict:
        return {
            "id": "id",
            "name": "name",
            "latitude": "latitude",
            "longitude": "longitude",
            "state": "state",
            "type": "type",
            "id_client": "id_client",
            "id_project": "id_project",
            "id_label": "id_label",
            "id_module": "id_module",
            "created_at": "created_at",
            "updated_at": "updated_at",
        }

    @classmethod
    def display_members(cls) -> List[str]:
        return [
            "id",
            "name",
            "latitude",
            "longitude",
            "state",
            "type",
            "id_client",
            "id_project",
            "id_label",
            "id_module",
            "created_at",
            "updated_at",
        ]

    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {}
