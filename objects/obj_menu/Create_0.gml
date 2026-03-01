/// obj_Menu - Create Event

// Opções
menu_options = ["INICIAR", "CONFIGURAÇÕES", "CRÉDITOS", "SAIR"];
index = 0;
alpha = 0;
menu_x_offset = -100;
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

//controladores da animação individual dos botões
for (var i = 0; i < array_length(menu_options); i++) {
    button_x[i] = 0;      
    button_glow[i] = 0;   
}

fade_alpha = 0;
fade_speed = 0.04;
iniciando = false;

// Confirmação de saída
confirmando_saida = false;
confirm_index = 0; // 0 = SIM | 1 = NÃO

// Menu de configurações
em_config = false;
config_index = 0;
config_options = ["VOLUME MASTER", "VOLUME SFX", "DIFICULDADE", "VOLTAR"];
config_values = [100, 100, 1]; // Master, SFX, Dificuldade (0=fácil, 1=normal, 2=difícil)
config_dificuldade = ["FÁCIL", "NORMAL", "DIFÍCIL"];
