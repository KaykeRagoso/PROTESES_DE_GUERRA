// Cria partículas de energia subindo do portal
meu_sistema = part_system_create();
minha_part = part_type_create();

part_type_shape(minha_part, pt_shape_spark);
part_type_color1(minha_part, c_aqua);
part_type_size(minha_part, 0.1, 0.3, 0, 0);
part_type_speed(minha_part, 1, 3, 0, 0);
part_type_direction(minha_part, 70, 110, 0, 0); // Atira para cima
part_type_life(minha_part, 20, 40);