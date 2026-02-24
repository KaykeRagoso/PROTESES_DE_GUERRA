// 1. Resolução Interna (Baixa para manter o estilo Pixel Art)
largura_view = 720; 
altura_view = 405;

// 2. Multiplicador da Janela (Aumenta o tamanho da janela sem borrar)
escala_janela = 2.5; 

// 3. Configurações de Seguimento
alvo = obj_Player;
suavidade = 0.1; // Delay suave
offset_y = -72;  // Foca um pouco acima da cabeça do player

// 4. Inicializar Câmera e Superfície
camera = camera_create_view(0, 0, largura_view, altura_view);
view_set_camera(0, camera);

// Redimensionar a janela e a área de desenho para evitar bugs visuais
window_set_size(largura_view * escala_janela, altura_view * escala_janela);
surface_resize(application_surface, largura_view * escala_janela, altura_view * escala_janela);

display_reset(0, true); // Ativa V-Sync (evita quebra de quadros)
alarm[0] = 1; // Centralizar janela