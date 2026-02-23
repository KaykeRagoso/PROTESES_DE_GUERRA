// Verificar se alvo(player) existe
if (!instance_exists(target)) exit;

// Pegar as cordenadas do player
var _tx = target.x + offset_x;
var _ty = target.y + offset_y;

// Pegar as configurações da Caemra
var _cx = camera_get_view_x(view_camera[0]);
var _cy = camera_get_view_y(view_camera[0]);

var _goal_x = _tx - cam_w*0.5;
var _goal_y = _ty - cam_h*0.5;

_cx = lerp(_cx, _goal_x, follow_speed);
_cy = lerp(_cy, _goal_y, follow_speed);

var _final_x = _cx;
var _final_y = _cy;

if (shake_amount > 0){
    _final_x += irandom_range(-shake_amount, shake_amount);
    _final_y += irandom_range(-shake_amount, shake_amount);
    shake_amount *= shake_decay;
    if (shake_amount < 0.1) shake_amount = 0;
}

_final_x = clamp(_final_x, 0, room_width - cam_w);
_final_y = clamp(_final_y, 0, room_height - cam_h);

camera_set_view_pos(view_camera[0], _final_x, _final_y);

room_name = room_get_name(room);