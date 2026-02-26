var _hud_x = 96;
var _hud_y = 128;

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
draw_roundrect((_hud_x - 28), (_hud_y - 28), (_hud_x + 28), (_hud_y + 28), false);
draw_set_alpha(1);


if (_spr != -1)
    draw_sprite_stretched(_spr, 0, _hud_x - 24, _hud_y - 24, 48, 48);