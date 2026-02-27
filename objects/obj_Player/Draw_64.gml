var base_w = 1280;
var base_h = 720;

var escala_x = display_get_gui_width()  / base_w;
var escala_y = display_get_gui_height() / base_h;

var _hud_x = 96  * escala_x;
var _hud_y = 128 * escala_y;
var _spr = -1;

switch (weapon)
{
    case WeaponType.BASIC:
        _spr = sprt_PlayerIdleDir;
    break;
    case WeaponType.SWORD:
        _spr = sprt_PlayerIdleEspadaDir;
    break;
    case WeaponType.GUN:
        _spr = sprt_PlayerIdleCanhaoDir;
    break;
}

draw_set_alpha(0.5);
draw_set_color(c_black);
draw_roundrect((_hud_x - 28 * escala_x), (_hud_y - 28 * escala_y), (_hud_x + 28 * escala_x), (_hud_y + 28 * escala_y), false);
draw_set_alpha(1);
if (_spr != -1)
    draw_sprite_stretched(_spr, 0, _hud_x - 24 * escala_x, _hud_y - 24 * escala_y, 48 * escala_x, 48 * escala_y);