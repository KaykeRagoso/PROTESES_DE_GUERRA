// 1. Resolução Interna (Baixa para manter o estilo Pixel Art)
largura_view = camera_get_view_width(view_camera[0]) / 1.5; 
altura_view = camera_get_view_height(view_camera[0]) / 1.5;

// 2. Multiplicador da Janela (Aumenta o tamanho da janela sem borrar)
escala_janela = 2; 

// 3. Configurações de Seguimento
alvo = obj_Player;
suavidade = 0.1; // Delay suave
offset_y = -72;  // Foca um pouco acima da cabeça do player
offset_x = 0;
var _start_x = alvo.x + offset_x - largura_view*0.5;
var _start_y = alvo.y + offset_y - altura_view*0.5;

// 4. Inicializar Câmera e Superfície
camera = camera_create_view(_start_x, _start_y, largura_view, altura_view);
view_set_camera(0, camera);

// Redimensionar a janela e a área de desenho para evitar bugs visuais
window_set_size(largura_view * escala_janela, altura_view * escala_janela);
surface_resize(application_surface, largura_view * escala_janela, altura_view * escala_janela);

display_reset(0, true); // Ativa V-Sync (evita quebra de quadros)
alarm[0] = 1; // Centralizar janela

//window_set_fullscreen(true);
//surface_resize(application_surface, display_get_width(), display_get_height());

// Posicionar a câmera já na posição inicial do player


// Guardar coordenadas atuais para lerp
_cx = _start_x;
_cy = _start_y;

// Setar posição da câmera
camera_set_view_pos(view_camera[0], _cx, _cy);