// Pega a posição X da câmera atual
var _cam_x = camera_get_view_x(view_camera[0]);

// Ajusta a velocidade de cada camada (layer)
// Quanto maior o número que divide, mais longe o fundo parece estar.

// Camada bem longe (nuvens ou prédios distantes)
//layer_x("Background7", _cam_x * 1.3); 

// Camada intermediária (prédios mais próximos)
layer_x("Background6", _cam_x * 1.1);

// Camada de frente (detalhes do hospital)
layer_x("Background5", _cam_x * 0.9);

// Camada de frente (detalhes do hospital)
layer_x("Background4", _cam_x * 0.7);

// Camada de frente (detalhes do hospital)
layer_x("Background3", _cam_x * 0.5);

// Camada de frente (detalhes do hospital)
layer_x("Background2", _cam_x * 0.3);

// Camada de frente (detalhes do hospital)
layer_x("Background1", _cam_x * 0.1);