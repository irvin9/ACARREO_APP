from typing import Any, Dict, List
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from ...Core.Data.BaseModel import BaseModel


class Clientes(BaseModel):
    """Table Clientess Database model

    Args:
        BaseModel (ORMClass): Parent class

    Returns:
        Clientes: Instance of model
    """

    __tablename__ = "clientes"
    id = Column("id", Integer, primary_key=True)
    name = Column("nombre", String(191), nullable=False)
    address = Column("direccion", String(191), nullable=False)
    phone = Column("telefono", String(191), nullable=False)
    rfc = Column("rfc", String(191), nullable=False)
    account_level = Column("accountLevel", String(191), nullable=False)
    created_at = Column("created_at", DateTime(timezone=True), default=func.now())
    updated_at = Column("updated_at", DateTime(timezone=True), onupdate=func.now())

    model_path_name = "clientes"

    filter_columns = ["name", "phone", "rfc", "account_level"]

    def property_map(self) -> Dict:
        return {
            "id": "id",
            "name": "name",
            "address": "address",
            "phone": "phone",
            "rfc": "rfc",
            "created_at": "created_at",
            "account_level": "account_level",
            "updated_at": "updated_at",
        }

    @classmethod
    def display_members(cls) -> List[str]:
        return [
            "id",
            "name",
            "address",
            "phone",
            "rfc",
            "account_level",
            "created_at",
            "updated_at",
        ]

    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {}
