// Pega a posição X da câmera atual
var _cam_x = camera_get_view_x(view_camera[0]);

// Ajusta a velocidade de cada camada (layer)
// Quanto maior o número que divide, mais longe o fundo parece estar.

// Camada bem longe (nuvens ou prédios distantes)
layer_x("Background_longe", _cam_x * 0.9); 

// Camada intermediária (prédios mais próximos)
layer_x("Background_meio", _cam_x * 0.7);

// Camada de frente (detalhes do hospital)
layer_x("Background_perto", _cam_x * 0.4);