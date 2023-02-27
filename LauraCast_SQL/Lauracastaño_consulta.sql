
--Consulta Práctica 

select b.nombre as MODELO, c.nombre_marca as MARCA, f.nombre_grupo as GRUPO_EMPRESARIAL , a.fecha_compra as FECHA_COMPRA, a.matricula, d.nombre as COLOR, a.total_kms as KILóMETROS, e.nombre_aseguradora as ASEGURADORA, a.num_poliza as Nº_POLIZA
from lauracastaño_bd_sql.coches  a 
inner join lauracastaño_bd_sql.modelos b on a.id_modelo =  b.id_modelo
inner join lauracastaño_bd_sql.marcas c on b.id_marca = c.id_marca
inner join lauracastaño_bd_sql.color_coches d on a.id_color = d.id_color 
inner join lauracastaño_bd_sql.aseguradoras e on a.id_aseguradora  = e.id_aseguradora 
inner join lauracastaño_bd_sql.grupo_empresarial f on c.id_grupo_empresarial  = f.id_grupo_empresarial 


----consulta extra para practicar
 

select c.nombre_marca as MARCA, b.nombre as MODELO, a.matricula, d.fecha_revision, d.kms_ultima_revision , concat (d.precio_revision,' ', e.nombre) as PRECIO_úLTIMA_REVISIóN  
from  lauracastaño_bd_sql.coches  a 
inner join lauracastaño_bd_sql.modelos b on a.id_modelo = b.id_modelo 
inner join lauracastaño_bd_sql.marcas c on b.id_marca = c.id_marca
inner join lauracastaño_bd_sql.revisiones_coches d on a.id_coche = d.id_coche 
inner join lauracastaño_bd_sql.monedas e on d.id_moneda = e.id_moneda 






