"""empty message

Revision ID: 2e467262df1f
Revises: f610bf799e52
Create Date: 2023-09-08 06:19:15.600698

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '2e467262df1f'
down_revision = 'f610bf799e52'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('permissions', schema=None) as batch_op:
        batch_op.drop_index('permissions_name_guard_name_unique')

    op.drop_table('permissions')
    with op.batch_alter_table('password_resets', schema=None) as batch_op:
        batch_op.drop_index('password_resets_email_index')

    op.drop_table('password_resets')
    with op.batch_alter_table('personal_access_tokens', schema=None) as batch_op:
        batch_op.drop_index('personal_access_tokens_token_unique')
        batch_op.drop_index('personal_access_tokens_tokenable_type_tokenable_id_index')

    op.drop_table('personal_access_tokens')
    op.drop_table('ubicaciones')
    with op.batch_alter_table('roles', schema=None) as batch_op:
        batch_op.drop_index('roles_name_guard_name_unique')

    op.drop_table('roles')
    op.drop_table('migrations')
    with op.batch_alter_table('users', schema=None) as batch_op:
        batch_op.drop_index('users_email_unique')

    op.drop_table('users')
    op.drop_table('ticketsrecepcion')
    op.drop_table('tickets')
    op.drop_table('checadores')
    op.drop_table('materiales')
    op.drop_table('clientes')
    op.drop_table('transportistas')
    op.drop_table('camiones')
    with op.batch_alter_table('model_has_permissions', schema=None) as batch_op:
        batch_op.drop_index('model_has_permissions_model_id_model_type_index')

    op.drop_table('model_has_permissions')
    with op.batch_alter_table('model_has_roles', schema=None) as batch_op:
        batch_op.drop_index('model_has_roles_model_id_model_type_index')

    op.drop_table('model_has_roles')
    op.drop_table('role_has_permissions')
    with op.batch_alter_table('failed_jobs', schema=None) as batch_op:
        batch_op.drop_index('failed_jobs_uuid_unique')

    op.drop_table('failed_jobs')
    op.drop_table('obras')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('obras',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('nombreEmpresa', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('codigoObra', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('nombreObra', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('estatus', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_cliente', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    op.create_table('failed_jobs',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('uuid', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('connection', mysql.TEXT(), nullable=False),
    sa.Column('queue', mysql.TEXT(), nullable=False),
    sa.Column('payload', mysql.LONGTEXT(), nullable=False),
    sa.Column('exception', mysql.LONGTEXT(), nullable=False),
    sa.Column('failed_at', mysql.TIMESTAMP(), default=func.now()=sa.text('current_timestamp()'), nullable=False),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    with op.batch_alter_table('failed_jobs', schema=None) as batch_op:
        batch_op.create_index('failed_jobs_uuid_unique', ['uuid'], unique=False)

    op.create_table('role_has_permissions',
    sa.Column('permission_id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=False, nullable=False),
    sa.Column('role_id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['permission_id'], ['permissions.id'], name='role_has_permissions_permission_id_foreign', ondelete='CASCADE'),
    sa.ForeignKeyConstraint(['role_id'], ['roles.id'], name='role_has_permissions_role_id_foreign', ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('permission_id', 'role_id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    op.create_table('model_has_roles',
    sa.Column('role_id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=False, nullable=False),
    sa.Column('model_type', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('model_id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['role_id'], ['roles.id'], name='model_has_roles_role_id_foreign', ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('role_id', 'model_id', 'model_type'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    with op.batch_alter_table('model_has_roles', schema=None) as batch_op:
        batch_op.create_index('model_has_roles_model_id_model_type_index', ['model_id', 'model_type'], unique=False)

    op.create_table('model_has_permissions',
    sa.Column('permission_id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=False, nullable=False),
    sa.Column('model_type', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('model_id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['permission_id'], ['permissions.id'], name='model_has_permissions_permission_id_foreign', ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('permission_id', 'model_id', 'model_type'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    with op.batch_alter_table('model_has_permissions', schema=None) as batch_op:
        batch_op.create_index('model_has_permissions_model_id_model_type_index', ['model_id', 'model_type'], unique=False)

    op.create_table('camiones',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('conductor', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('Marca', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('capacidad', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('placas', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('placasGondola', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('capacidadExtra', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('id_transportista', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_cliente', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_obra', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    op.create_table('transportistas',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('nombre', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('rfc', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('direccion', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('colonia', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('municipio', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('estado', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('cp', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('telefono', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('email', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('id_cliente', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_obra', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    op.create_table('clientes',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('nombre', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('direccion', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('telefono', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('rfc', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    op.create_table('materiales',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('nombreMaterial', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('modoViaje', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('camion', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('precioViaje', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('precioMaterial', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('estatus', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('id_cliente', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_obra', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    op.create_table('checadores',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('usuario', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('password', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('nombre', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('apellidoPaterno', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('apellidoMaterno', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('id_cliente', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_obra', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    op.create_table('tickets',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('folioId', mysql.VARCHAR(length=191), nullable=True),
    sa.Column('fecha', mysql.VARCHAR(length=191), nullable=True),
    sa.Column('id_camion', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_checador', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_ubicacionOrigen', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_ubicacionDestino', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_material', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('nota', mysql.VARCHAR(length=191), nullable=True),
    sa.Column('folio', mysql.VARCHAR(length=191), nullable=True),
    sa.Column('id_cliente', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_obra', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    op.create_table('ticketsrecepcion',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('folioOrigen', mysql.VARCHAR(length=191), nullable=True),
    sa.Column('folio', mysql.VARCHAR(length=191), nullable=True),
    sa.Column('fecha', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('id_camion', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_checador', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_ubicacionDestino', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_material', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('nota', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('unidadObra', mysql.VARCHAR(length=191), nullable=True),
    sa.Column('id_cliente', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_obra', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    op.create_table('users',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('name', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('email', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('email_verified_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('password', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('remember_token', mysql.VARCHAR(length=100), nullable=True),
    sa.Column('id_cliente', mysql.INTEGER(display_width=11), autoincrement=False, nullable=True),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    with op.batch_alter_table('users', schema=None) as batch_op:
        batch_op.create_index('users_email_unique', ['email'], unique=False)

    op.create_table('migrations',
    sa.Column('id', mysql.INTEGER(display_width=10, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('migration', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('batch', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    op.create_table('roles',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('name', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('guard_name', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    with op.batch_alter_table('roles', schema=None) as batch_op:
        batch_op.create_index('roles_name_guard_name_unique', ['name', 'guard_name'], unique=False)

    op.create_table('ubicaciones',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('nombre', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('latitud', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('longitud', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('estatus', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_cliente', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('id_obra', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    op.create_table('personal_access_tokens',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('tokenable_type', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('tokenable_id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=False, nullable=False),
    sa.Column('name', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('token', mysql.VARCHAR(length=64), nullable=False),
    sa.Column('abilities', mysql.TEXT(), nullable=True),
    sa.Column('last_used_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    with op.batch_alter_table('personal_access_tokens', schema=None) as batch_op:
        batch_op.create_index('personal_access_tokens_tokenable_type_tokenable_id_index', ['tokenable_type', 'tokenable_id'], unique=False)
        batch_op.create_index('personal_access_tokens_token_unique', ['token'], unique=False)

    op.create_table('password_resets',
    sa.Column('email', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('token', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    with op.batch_alter_table('password_resets', schema=None) as batch_op:
        batch_op.create_index('password_resets_email_index', ['email'], unique=False)

    op.create_table('permissions',
    sa.Column('id', mysql.BIGINT(display_width=20, unsigned=True), autoincrement=True, nullable=False),
    sa.Column('name', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('guard_name', mysql.VARCHAR(length=191), nullable=False),
    sa.Column('created_at', mysql.TIMESTAMP(), nullable=True),
    sa.Column('updated_at', mysql.TIMESTAMP(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb3_spanish_ci',
    mysql_default_charset='utf8mb3',
    mysql_engine='InnoDB'
    )
    with op.batch_alter_table('permissions', schema=None) as batch_op:
        batch_op.create_index('permissions_name_guard_name_unique', ['name', 'guard_name'], unique=False)

    # ### end Alembic commands ###
