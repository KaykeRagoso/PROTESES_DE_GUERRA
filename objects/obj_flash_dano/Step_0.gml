//diminui o alpha gradualmente até sumir
alpha -= 0.05; 

//se ficar invisível ele destroi o objeto
if (alpha <= 0) {
    instance_destroy();
}