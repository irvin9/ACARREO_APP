from typing import Any, Dict, List
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from ...Core.Data.BaseModel import BaseModel


class Materiales(BaseModel):
    """Table Materialess Database model

    Args:
        BaseModel (ORMClass): Parent class

    Returns:
        Materiales: Instance of model
    """

    __tablename__ = "materiales"
    id = Column("id", Integer, primary_key=True)
    material_name = Column("nombreMaterial", String(191), nullable=False)
    travel_mode = Column("modoViaje", String(191), nullable=False)
    truck = Column("camion", String(191), nullable=False)
    travel_price = Column("precioViaje", String(191), nullable=False)
    material_price = Column("precioMaterial", String(191), nullable=False)
    state = Column("estatus", String(191), nullable=False)
    id_client = Column("id_cliente", Integer, nullable=False)
    id_project = Column("id_obra", Integer, nullable=False)
    created_at = Column("created_at", DateTime(timezone=True), default=func.now())
    updated_at = Column("updated_at", DateTime(timezone=True), onupdate=func.now())

    model_path_name = "materiales"

    def property_map(self) -> Dict:
        return {
            "id": "id",
            "material_name": "material_name",
            "travel_mode": "travel_mode",
            "truck": "truck",
            "travel_price": "travel_price",
            "material_price": "material_price",
            "state": "state",
            "id_client": "id_client",
            "id_project": "id_project",
            "created_at": "created_at",
            "updated_at": "updated_at",
        }

    @classmethod
    def display_members(cls) -> List[str]:
        return [
            "id",
            "material_name",
            "travel_mode",
            "truck",
            "travel_price",
            "material_price",
            "state",
            "id_client",
            "id_project",
            "created_at",
            "updated_at",
        ]

    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {}
