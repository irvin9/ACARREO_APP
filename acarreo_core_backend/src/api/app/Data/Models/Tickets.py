from typing import Any, Dict, List
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from ...Core.Data.BaseModel import BaseModel


class Tickets(BaseModel):
    """Table Ticketss Database model

    Args:
        BaseModel (ORMClass): Parent class

    Returns:
        Tickets: Instance of model
    """

    __tablename__ = "tickets"
    id = Column("id", Integer, primary_key=True)
    date = Column("fecha", String(191), nullable=True)
    id_truck = Column("id_camion", Integer, nullable=False)
    id_tracker = Column("id_checador", Integer, nullable=False)
    id_start_travel = Column("id_ubicacionOrigen", Integer, nullable=False)
    id_end_travel = Column("id_ubicacionDestino", Integer, nullable=False)
    id_material = Column("id_material", Integer, nullable=False)
    description = Column("nota", String(191), nullable=True)
    folio = Column("folio", String(191), nullable=True)
    id_client = Column("id_cliente", Integer, nullable=False)
    id_project = Column("id_obra", Integer, nullable=False)
    created_at = Column("created_at", DateTime(timezone=True), default=func.now())
    updated_at = Column("updated_at", DateTime(timezone=True), onupdate=func.now())

    model_path_name = "tickets"

    def property_map(self) -> Dict:
        return {
            "id": "id",
            "date": "date",
            "id_truck": "id_truck",
            "id_tracker": "id_tracker",
            "id_start_travel": "id_start_travel",
            "id_end_travel": "id_end_travel",
            "id_material": "id_material",
            "description": "description",
            "folio": "folio",
            "id_client": "id_client",
            "id_project": "id_project",
            "created_at": "created_at",
            "updated_at": "updated_at",
        }

    @classmethod
    def display_members(cls) -> List[str]:
        return [
            "id",
            "date",
            "id_truck",
            "id_tracker",
            "id_start_travel",
            "id_end_travel",
            "id_material",
            "description",
            "folio",
            "id_client",
            "id_project",
            "created_at",
            "updated_at",
        ]

    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {}
