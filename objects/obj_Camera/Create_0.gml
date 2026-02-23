//Alvo;
target = obj_Player;

// Configuração de camera
cam_w = 910;
cam_h = 512;
follow_speed = 0.15;
offset_x = 0;
offset_y = 0;

/// Shake
shake_amount = 0;
shake_decay = 0.4;

// Posicionar a câmera já na posição inicial do player
var _start_x = target.x + offset_x - cam_w*0.5;
var _start_y = target.y + offset_y - cam_h*0.5;

// Guardar coordenadas atuais para lerp
_cx = _start_x;
_cy = _start_y;

// Setar posição da câmera
camera_set_view_pos(view_camera[0], _cx, _cy);

room_name = -1;