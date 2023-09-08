from typing import Any, Dict, List
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from ...Core.Data.BaseModel import BaseModel

class Camiones(BaseModel):
    ''' Table Camioness Database model

    Args:
        BaseModel (ORMClass): Parent class

    Returns:
        Camiones: Instance of model
    '''
    __tablename__ = 'camiones'
    id = Column('id', Integer, primary_key=True)
    driver = Column('conductor', String(191), nullable=False)
    branch = Column('Marca', String(191), nullable=False)
    capacity = Column('capacidad', String(191), nullable=False)
    plate = Column('placas', String(191), nullable=False)
    plate_gondola = Column('placasGondola', String(191), nullable=False)
    extra_capacity = Column('capacidadExtra', String(191), nullable=False)
    # Column('id_transportista', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False)
    # Column('id_cliente', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False)
    # Column('id_obra', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False)
    created_at = Column('created_at', DateTime(timezone=True), server_default=func.now())
    updated_at = Column('updated_at', DateTime(timezone=True), onupdate=func.now())
    
    model_path_name = 'camiones'
    
    def property_map(self) -> Dict:
        return {
            'id': 'id',
            'driver': 'driver',
            'branch': 'branch',
            'capacity': 'capacity',
            'plate': 'plate',
            'plate_gondola': 'plate_gondola',
            'extra_capacity': 'extra_capacity',
            'created_at': 'created_at',
            'updated_at': 'updated_at'
        }
    
    def display_members(self) -> List[str]:
        return ['id', 
                'driver', 
                'branch', 
                'capacity', 
                'plate',
                'plate_gondola',
                'extra_capacity',
                'created_at',
                'updated_at'
        ]
    
    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {
            
        }
