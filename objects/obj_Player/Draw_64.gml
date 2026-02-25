// HUD - Arma/Ataque atual
var _hud_x = 96;
var _hud_y = 128;

var _spr = -1;

switch (weapon)
{
    case WeaponType.BASIC:
        switch (attack_type)
        {
            case 1: case 2: _spr = sprt_PlayerSocoFrenteDir;      break;
            case 3:         _spr = sprt_PlayerChuteBaixoDir;       break;
            case 4:         _spr = sprt_PlayerAtaqueGiratorioDir;  break;
            default:        _spr = sprt_PlayerIdleDir;             break;
        }
    break;

    case WeaponType.SWORD:
        switch (attack_type)
        {
            case 1: case 2: _spr = sprt_PlayerAtaqueEspadaDir;      break;
            case 3:         _spr = sprt_PlayerAtaqueLoucoEspadaDir; break;
            default:        _spr = sprt_PlayerIdleEspadaDir;        break;
        }
    break;

    case WeaponType.GUN:
        // Mostra o sprite do tiro carregado atual
        switch (attack_type)
        {
            case 10: _spr = sprt_TiroFracoPequeno;  break;
            case 11: _spr = sprt_TiroFracoMedio;    break;
            case 12: _spr = sprt_TiroFracoGrande;   break;
            case 13: _spr = sprt_TiroGrande;        break;
            case 14: _spr = sprt_TiroAzulForte;     break;
            case 15: _spr = sprt_TiroRoxoForte;     break;
            case 16: _spr = sprt_TiroVermelhoForte; break;
            default: _spr = sprt_PlayerIdleCanhaoDir; break;
        }
    break;
}

// Fundo escuro atrás do ícone (opcional, fica mais legível)
draw_set_alpha(0.5);
draw_set_color(c_black);
draw_roundrect((_hud_x - 28), (_hud_y - 28), (_hud_x + 28), (_hud_y + 28), false);
draw_set_alpha(1);

// Desenha o sprite
if (_spr != -1)
    draw_sprite_stretched(_spr, 0, _hud_x - 24, _hud_y - 24, 48, 48);